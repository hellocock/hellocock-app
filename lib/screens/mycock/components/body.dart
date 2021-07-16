import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/mycock/components/contents.dart';
import 'package:hellocock/screens/signIn/sign_in_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';

class Body extends StatefulWidget {
  final User user;
  Body(this.user);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.user != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('order')
                      .where('email', isEqualTo: widget.user.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kActiveColor),
                        ),
                      );
                    }
                    if (snapshot.data.docs.length == 0) {
                      return Column(
                        children: [
                          VerticalSpacing(of: 30),
                          Center(
                            child: Text(
                              "나의 칵테일 콜렉션이 비어 있어요 ㅠ,ㅠ",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kActiveColor,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      );
                    }
                    return Stack(
                      children: [
                        Column(
                          children: [
                            VerticalSpacing(
                              of: 120,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    (snapshot.data.docs.length / 4 + 1).toInt(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(children: [
                                    Divider(
                                      thickness: 1,
                                      color: kActiveColor,
                                    ),
                                    VerticalSpacing(
                                      of: 135,
                                    ),
                                  ]);
                                }),
                          ],
                        ),
                        Center(
                          child: GridView.count(
                            shrinkWrap:
                                true, // You won't see infinite size error
                            primary: false,
                            crossAxisCount: 4,
                            childAspectRatio: 0.6,
                            padding: const EdgeInsets.only(top: 30.0),
                            crossAxisSpacing: 1,
                            children: List.generate(
                                snapshot.data.docs.length,
                                (index) => MyCocktail(
                                    snapshot.data.docs.toList(), index)),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //VerticalSpacing(of: 50),
              Text(
                "로그인이 필요한 서비스입니다.",
                textScaleFactor: 1,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kActiveColor,
                    height: 1.5),
              ),
              VerticalSpacing(of: 30),
              Center(
                child: SizedBox(
                  width: 150,
                  child: PrimaryButton(
                    press: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ));
                    },
                    text: "로그인",
                  ),
                ),
              ),
            ],
          );
  }
}
