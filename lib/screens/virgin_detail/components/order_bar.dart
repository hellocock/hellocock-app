import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/virgin_detail/components/like_button.dart';
import 'package:hellocock/screens/virgin_detail/components/order_button.dart';
import 'package:hellocock/size_config.dart';

class OrderBar extends StatefulWidget {
  final User user;
  final DocumentSnapshot document;

  OrderBar(this.user, this.document);
  @override
  _OrderBarState createState() => _OrderBarState();
}

class _OrderBarState extends State<OrderBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //LikeButton(widget.user, widget.document),
          OrderButton(widget.user, widget.document),
        ],
      ),
    );
  }
}
