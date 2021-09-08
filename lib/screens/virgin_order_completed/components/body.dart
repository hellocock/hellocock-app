import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/root.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  final DocumentSnapshot document;
  final String ordernumber;
  Body(this.document, this.ordernumber);
  @override
  Widget build(BuildContext context) {
    var ordertime = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "주문 완료",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: kActiveColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  VerticalSpacing(
                    of: 50,
                  ),
                  Text(
                    document['cocktail']['name'] + " 칵테일 키트",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kBodyTextColor,
                      fontSize: 15,
                    ),
                  ),
                  VerticalSpacing(of: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "주문일시",
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ordertime,
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: kBodyTextColor,
                        ),
                      )
                    ],
                  ),
                  VerticalSpacing(of: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "주문번호",
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ordernumber,
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: kBodyTextColor,
                        ),
                      )
                    ],
                  ),
                  VerticalSpacing(of: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "배송주소",
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        document['address'],
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: kBodyTextColor,
                        ),
                      )
                    ],
                  ),
                  VerticalSpacing(of: 20),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                press: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootPage(),
                  ),
                ),
                text: "홈으로 돌아가기",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
