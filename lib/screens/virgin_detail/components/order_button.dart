import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/certification/certification_screen.dart';

import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/map/map_screen.dart';
import 'package:hellocock/screens/virgin_order/order_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hellocock/widgets/login_alert.dart';

class OrderButton extends StatefulWidget {
  final User user;
  final DocumentSnapshot document;
  OrderButton(this.user, this.document);
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _certificated;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 50,
        minWidth: SizeConfig.screenWidth - 40,
        child: Row(
          children: [
            SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  "assets/icons/logo.svg",
                  fit: BoxFit.fitWidth,
                )),
            HorizontalSpacing(
              of: 5,
            ),
            Text(
              "주문하기",
              textScaleFactor: 1,
              style: TextStyle(
                  fontFamily: "NotoSans",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.6),
            ),
          ],
        ),
        color: kActiveColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () async {
          if (widget.user == null) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return LoginAlert();
                });
          } else {
            FirebaseFirestore.instance
                .collection("cart")
                .doc(widget.user.email)
                .set({
              'name': widget.user.displayName,
              'address': '',
              'cocktail': {
                'name': widget.document['name'],
                'price': widget.document['price'],
                'quantity': 1
              },
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VirginOrderScreen(widget.user),
                ));
          }
        });
  }
}
