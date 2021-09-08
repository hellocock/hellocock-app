import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/size_config.dart';
import 'components/body.dart';

class OrderCompletedScreen extends StatelessWidget {
  final DocumentSnapshot cart;
  final String ordernumber;
  OrderCompletedScreen(this.cart, this.ordernumber);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //appBar: buildAppBar(context),
      body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.collection("order").doc().snapshots(),
          builder: (context, snapshot) {
            return Body(cart, ordernumber);
          }),
    );
  }
}
