import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Order extends StatefulWidget {
  final User user;
  final DocumentSnapshot cart;

  Order(this.user, this.cart);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 10,
      ),
      Text(
        "주문내역 확인",
        textScaleFactor: 1,
        style: TextStyle(
            color: kActiveColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      VerticalSpacing(
        of: 30,
      ),
      Text(
        "칵테일",
        textScaleFactor: 1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kBodyTextColor,
          fontSize: 17,
        ),
      ),
      VerticalSpacing(of: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.cart['cocktail']['name'] + " 칵테일 키트",
              textScaleFactor: 1,
              style: TextStyle(
                  color: kBodyTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text(
            widget.cart['cocktail']['price'].toString() + "원",
            textScaleFactor: 1,
            style: TextStyle(
                color: Color(0xFFFF4D4D),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
      VerticalSpacing(of: 15),
      
    ]);
  }
}
