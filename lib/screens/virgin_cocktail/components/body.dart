import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/virgin_detail/virgin_detail_screen.dart';
import 'package:hellocock/widgets/cards/card.dart';
import 'package:hellocock/widgets/primary_alert.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  final User user;
  Body(this.user);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/hellocock-6b1dd.appspot.com/o/images%2Fvirgin.jpg?alt=media&token=ca6fa3df-cf14-4b01-9360-3acaac47ca85',
                fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('virgin')
                    .orderBy("soldout")
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
                  return GridView.count(
                      shrinkWrap: true, // You won't see infinite size error
                      primary: false,
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      padding: const EdgeInsets.only(top: 20.0),
                      crossAxisSpacing: 9.0,
                      children: List.generate(
                          snapshot.data.docs.length,
                          (index) => _buildListVirginItem(
                                context,
                                snapshot.data.docs[index],
                              )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListVirginItem(BuildContext context, DocumentSnapshot document) {
    return InkWellCard(
      circular: 20,
      onTap: () {
        if (document['soldout'] == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VirginDetailScreen(user, document),
            ),
          );
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Alert(
                  title: "Sold Out",
                  content: "품절되었어요 ㅠ.ㅠ",
                  action: "확인",
                );
              });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   document['mbti'],
            //   textScaleFactor: 1,
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontStyle: FontStyle.italic,
            //       fontSize: 15,
            //       color: kActiveColor),
            // ),
            // VerticalSpacing(),
            CachedNetworkImage(
                imageUrl: document['image'], fit: BoxFit.fitWidth),
            VerticalSpacing(),
            Text(
              document['name'],
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: kBodyTextColor),
            ),
            VerticalSpacing(),
            if (document['soldout'] == true)
              Text(
                "sold out",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red),
              )
            else
              Text(
                document['price'].toString() + "원",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kActiveColor),
              ),
          ],
        ),
      ),
    );
  }
}
