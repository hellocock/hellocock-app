import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/policy/privacy_policy/privacy_policy_screen.dart';
import 'package:hellocock/screens/policy/service_policy/service_policy_screen.dart';
import 'package:hellocock/screens/signIn/sign_in_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:flutter_svg/flutter_svg.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  TextEditingController _birth = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _sms = TextEditingController();
  TextEditingController _address1 = TextEditingController();
  TextEditingController _address2 = TextEditingController();

  bool _success;
  String _userEmail;
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  KopoModel model;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            style: TextStyle(fontSize: 15),
            keyboardType: TextInputType.name,
            autofocus: false,
            cursorColor: kActiveColor,
            controller: _name,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
            " 이메일",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            style: TextStyle(fontSize: 15),
            keyboardType: TextInputType.emailAddress,
            cursorColor: kActiveColor,
            controller: _email,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '이메일을 입력해주세요.';
              }
              return null;
            },
          ),
          VerticalSpacing(of: 20),
          Text(
            " 비밀번호",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            style: TextStyle(fontSize: 15),
            cursorColor: kActiveColor,
            controller: _password,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintText: "6자리 이상 입력해주세요.",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '비밀번호를 입력해주세요';
              }
              if (value.length < 6) {
                return "6자리 이상 입력해주세요";
              }
              return null;
            },
            obscureText: true,
          ),
          VerticalSpacing(of: 20),
          Text(
            " 비밀번호 확인",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            style: TextStyle(fontSize: 15),
            cursorColor: kActiveColor,
            controller: _confirm,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintText: "6자리 이상 입력해주세요.",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '비밀번호를 입력해주세요';
              }
              if (value != _password.text) {
                return '비밀번호가 맞지 않습니다.';
              }
              return null;
            },
            obscureText: true,
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
            style: TextStyle(fontSize: 15),
            cursorColor: kActiveColor,
            controller: _birth,
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintText: "생년월일 8자리",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '생년월일 입력해주세요';
              }
              if (value.length != 8) {
                return '생년월일 8자리를 입력해주세요';
              }
              return null;
            },
          ),
          VerticalSpacing(of: 20),
          Text(
            " 핸드폰 번호",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            controller: _phone,
            style: TextStyle(fontSize: 15),
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "숫자만 입력해주세요",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '핸드폰 번호를 입력해주세요';
              }
              return null;
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SizedBox(
          //       width: SizeConfig.screenWidth - 200,
          //       child: TextFormField(
          //         controller: _phone,
          //         style: TextStyle(fontSize: 15),
          //         cursorColor: kActiveColor,
          //         decoration: InputDecoration(
          //           fillColor: Colors.grey[100],
          //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(32.0)),
          //         ),
          //         validator: (String value) {
          //           if (value.isEmpty) {
          //             return '핸드폰 번호를 입력해주세요';
          //           }
          //           return null;
          //         },
          //       ),
          //     ),
          //     VerticalSpacing(),
          //     SizedBox(
          //         width: 100,
          //         child: PrimaryButton(text: "인증요청", press: () async {}))
          //   ],
          // ),
          // VerticalSpacing(of: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SizedBox(
          //       width: SizeConfig.screenWidth - 200,
          //       child: TextFormField(
          //         controller: _sms,
          //         style: TextStyle(fontSize: 13),
          //         cursorColor: kActiveColor,
          //         decoration: InputDecoration(
          //           fillColor: Colors.grey[100],
          //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(32.0)),
          //         ),
          //         validator: (String value) {
          //           if (value.isEmpty) {
          //             return '인증 번호를 입력해주세요.';
          //           }
          //           return null;
          //         },
          //       ),
          //     ),
          //     VerticalSpacing(),
          //     SizedBox(
          //         width: 100,
          //         child: PrimaryButton(text: "인증완료", press: () async {})),
          //   ],
          // ),
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                      MaterialPageRoute(builder: (context) => RemediKopo()),
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
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintText: "상세주소를 입력하세요.",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '주소를 입력해주세요';
              }
              return null;
            },
          ),
          VerticalSpacing(of: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HorizontalSpacing(of: 5),
                  Center(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _value1 = !_value1;
                          });
                        },
                        child: _value1
                            ? CircleAvatar(
                                backgroundColor: kActiveColor,
                                radius: 7,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 7,
                              )),
                  ),
                  HorizontalSpacing(of: 8),
                  Text(
                    "이용약관 동의",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 12,
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: IconButton(
                  icon: SvgPicture.asset("assets/icons/arrow_next.svg"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicePolicyScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HorizontalSpacing(of: 5),
                  Center(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _value2 = !_value2;
                          });
                        },
                        child: _value2
                            ? CircleAvatar(
                                backgroundColor: kActiveColor,
                                radius: 7,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 7,
                              )),
                  ),
                  HorizontalSpacing(of: 8),
                  Text(
                    "개인정보 취급방침 동의",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 12,
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: IconButton(
                  icon: SvgPicture.asset("assets/icons/arrow_next.svg"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HorizontalSpacing(of: 5),
                  Center(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _value3 = !_value3;
                          });
                        },
                        child: _value3
                            ? CircleAvatar(
                                backgroundColor: kActiveColor,
                                radius: 7,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 7,
                              )),
                  ),
                  HorizontalSpacing(of: 8),
                  Text(
                    "마케팅 정보 수신 동의 (선택)",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 12,
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
          VerticalSpacing(of: 30),
          Center(
              child: PrimaryButton(
                  text: "가입하기",
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      if (_value1 == false || _value2 == false) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                content: Text(
                                  "약관에 동의해주세요",
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  new CupertinoDialogAction(
                                    child: Text(
                                      '확인',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        _register().then((User user) {
                          if (user != null) {
                            _userEmail = user.email;
                            user.updateProfile(
                                displayName: _name.text, photoURL: null);
                            FirebaseFirestore.instance
                                .collection("user")
                                .doc(_email.text)
                                .set({
                              'name': _name.text,
                              'email': _email.text,
                              'birth': _birth.text,
                              'address1': _address1.text,
                              'address2': _address2.text,
                              'phone': _phone.text,
                              'certificated': false,
                              'marketing_agreement': _value3
                            });
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    content: Text(
                                      "회원가입을 축하드립니다!",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      new CupertinoDialogAction(
                                          child: Text(
                                            '확인',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          onPressed: () =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInScreen(),
                                                  ))),
                                    ],
                                  );
                                });
                          }
                        });
                      }
                    }
                  })),
        ],
      ),
    );
  }

  showErrDialog(BuildContext context, String err) {
    return Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        err,
        textAlign: TextAlign.center,
        textScaleFactor: 1,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      backgroundColor: kActiveColor,
    ));
  }

  // Example code for registration.
  Future<User> _register() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ))
          .user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrDialog(context, "비밀번호가 취약합니다.");
      } else if (e.code == 'email-already-in-use') {
        showErrDialog(context, "이미 존재하는 계정입니다. 다른 이메일을 입력해주세요.");
      }
    } catch (e) {
      print(e);
    }
  }
}
