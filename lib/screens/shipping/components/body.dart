import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/size_config.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:hellocock/widgets/primary_alert.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class Body extends StatefulWidget {
  final User user;
  final DocumentSnapshot cart;

  Body(this.user, this.cart);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  KopoModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _address1 = TextEditingController();
  TextEditingController _address2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        // 필드에 부여했단 글러벌키를 폼에 할당함
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "배송지 등록",
              textScaleFactor: 1,
              style: TextStyle(
                  color: kActiveColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            VerticalSpacing(of: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth - 190,
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller:
                        TextEditingController(text: this.model?.address ?? ""),
                    onTap: () async {
                      this.model = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RemediKopo()),
                      );
                      _address1.text = this.model?.address;

                      setState(() {
                        _address1.text = this.model?.address;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '주소를 입력해주세요';
                      }
                      return null;
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: PrimaryButton(
                      text: "우편번호",
                      press: () async {
                        this.model = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RemediKopo()),
                        );
                        _address1.text = this.model?.address;

                        setState(() {
                          _address1.text = this.model?.address;
                        });
                      }),
                )
              ],
            ),
            VerticalSpacing(),
            TextFormField(
              controller: _address2,
              style: TextStyle(fontSize: 15),
              cursorColor: kActiveColor,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                hintText: "상세주소를 입력하세요.",
                hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500]),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return '주소를 입력해주세요';
                }
                return null;
              },
            ),
            VerticalSpacing(
              of: 30,
            ),
            PrimaryButton(
                text: "배송지 등록",
                press: () {
                  if (_formKey.currentState.validate()) {
                    FirebaseFirestore.instance
                        .collection("cart")
                        .doc(widget.user.email)
                        .update({
                      'address': _address1.text + ", " + _address2.text
                    });
                    Navigator.pop(context);
                  } else {}
                }),
            VerticalSpacing(of: 20),
          ]),
        ));
  }
}
