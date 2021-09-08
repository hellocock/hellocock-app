import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/size_config.dart';
import '../../constants.dart';
import 'components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VirginOrderScreen extends StatelessWidget {
  final User user;

  VirginOrderScreen(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: SvgPicture.asset("assets/icons/arrow_back.svg"),
            color: kActiveColor,
            onPressed: () => Navigator.pop(context)),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .doc(user.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Body(
              user,
              snapshot.data,
            );
          }),
    );
  }
}
