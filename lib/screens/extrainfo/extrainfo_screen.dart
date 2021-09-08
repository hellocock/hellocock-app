import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/bottom_nav_bar.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ExtraInfoScreen extends StatefulWidget {
  final User user;
  ExtraInfoScreen(this.user);

  @override
  _ExtraInfoScreenState createState() => _ExtraInfoScreenState();
}

class _ExtraInfoScreenState extends State<ExtraInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _birth = new TextEditingController();
  TextEditingController _address1 = new TextEditingController();
  TextEditingController _address2 = new TextEditingController();
  KopoModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(of: 60),
                Text(
                  "나머지 정보 입력",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: kActiveColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                VerticalSpacing(of: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " 이름",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kBodyTextColor),
                      ),
                      VerticalSpacing(),
                      TextFormField(
                        controller: _name,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "이름을 입력해주세요.",
                          hintStyle:
                              TextStyle(color: kBodyTextColor, fontSize: 13),
                          fillColor: Colors.grey[100],
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '이름을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      VerticalSpacing(of: 20),
                      Text(
                        " 전화번호",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kBodyTextColor),
                      ),
                      VerticalSpacing(),
                      TextFormField(
                        controller: _phone,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "'-'빼고 숫자만 입력",
                          hintStyle:
                              TextStyle(color: kBodyTextColor, fontSize: 13),
                          fillColor: Colors.grey[100],
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '전화번호를 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      VerticalSpacing(of: 20),
                      Text(
                        " 생년월일",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kBodyTextColor),
                      ),
                      VerticalSpacing(),
                      TextFormField(
                        controller: _birth,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "생년월일 8자리",
                          hintStyle:
                              TextStyle(color: kBodyTextColor, fontSize: 13),
                          fillColor: Colors.grey[100],
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '생년월일을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      VerticalSpacing(of: 20),
                      Text(
                        " 주소",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kBodyTextColor),
                      ),
                      VerticalSpacing(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth - 200,
                            child: TextFormField(
                              style: TextStyle(fontSize: 15),
                              controller: TextEditingController(
                                  text: this.model?.address ?? ""),
                              onTap: () async {
                                this.model = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RemediKopo()),
                                );
                                _address1.text = this.model?.address;

                                setState(() {});
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
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          VerticalSpacing(),
                          SizedBox(
                            width: 100,
                            child: PrimaryButton(
                              text: "우편번호",
                              press: () async {
                                this.model = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RemediKopo()),
                                );
                                setState(() {});
                              },
                            ),
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
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          hintText: "상세주소를 입력하세요.",
                          hintStyle: TextStyle(
                              fontSize: 12,
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
                      VerticalSpacing(of: 50),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                  text: "확인",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(widget.user.email)
                          .update({
                        'name': _name.text,
                        'email': widget.user.email,
                        'certificated': false,
                        'phone': widget.user.phoneNumber,
                        'birth': _birth.text,
                        'address1': _address1.text,
                        'address2': _address2.text,
                        'marketing_agreement': false
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(widget.user)));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
