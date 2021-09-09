import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/shipping/shipping_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class Delivery extends StatefulWidget {
  final User user;
  final DocumentSnapshot cart;

  Delivery(this.user, this.cart);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  KopoModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "배송지",
            textScaleFactor: 1,
            style: TextStyle(
                color: kActiveColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          VerticalSpacing(of: 20),
          (widget.cart['address'] == '')
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "배송지를 입력해주세요",
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: kBodyTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddShippingScreen(widget.user),
                            ));
                      },
                      child: Text(
                        "입력하기",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: kActiveColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                      Text(
                        widget.cart['address'],
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: kBodyTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddShippingScreen(widget.user),
                              ));
                        },
                        child: Text(
                          "수정하기",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: kActiveColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ])
        ]);
  }
}
