import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/virgin_detail/components/order_bar.dart';

class Body extends StatelessWidget {
  final User user;
  final DocumentSnapshot document;
  Body(this.user, this.document);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: CachedNetworkImage(
              imageUrl: document['detail'],
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OrderBar(user, document),
          )
        ],
      ),
    );
  }
}
