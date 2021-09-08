import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/detail/detail_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:hellocock/widgets/cards/card.dart';

class Body extends StatelessWidget {
  final User user;
  Body(this.user);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(of: 30),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cocktailkit')
                      .where('likedUsers', arrayContains: user.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.docs.length == 0) {
                      return Text(
                        "좋아하는 칵테일이 없어요..",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kBodyTextColor,
                            height: 1.5),
                      );
                    }
                    return GridView.count(
                        shrinkWrap: true, // You won't see infinite size error
                        primary: false,
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        padding: const EdgeInsets.all(20.0),
                        crossAxisSpacing: 10.0,
                        children: List.generate(
                            snapshot.data.docs.length,
                            (index) => _buildListItem(
                                snapshot.data.docs[index], index, context)));
                  }),
            ]),
      ),
    );
  }

  Widget _buildListItem(
      DocumentSnapshot document, int index, BuildContext context) {
    return InkWellCard(
      circular: 30,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(user, document)),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 154,
        height: 261,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                  imageUrl: document['image'],
                  width: double.infinity,
                  fit: BoxFit.fitWidth),
            ),
            VerticalSpacing(
              of: 20,
            ),
            Text(
              document['name_eng'],
              textScaleFactor: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kBodyTextColor),
            ),
            VerticalSpacing(),
            Icon(
              Icons.favorite,
              color: kActiveColor,
            ),
            VerticalSpacing(),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
