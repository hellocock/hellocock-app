import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/recipe/recipe_screen.dart';
import 'package:hellocock/widgets/cards/card.dart';
import 'package:hellocock/screens/detail/detail_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Body extends StatefulWidget {
  final User user;

  Body(this.user);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(of: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "키트로 칵테일 즐기기   >",
                style: TextStyle(fontSize: 16, color: kBodyTextColor),
                textScaleFactor: 1,
              ),
            ),
            VerticalSpacing(),
            Container(
              height: 350.0,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cocktailkit')
                      .where("isnull", isEqualTo: true)
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
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildListKitItem(snapshot.data.docs[index]);
                      },
                    );
                  }),
            ),
            VerticalSpacing(of: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "칵테일 레시피 보기   >",
                style: TextStyle(fontSize: 16, color: kBodyTextColor),
                textScaleFactor: 1,
              ),
            ),
            VerticalSpacing(),
            Container(
              height: 350,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cocktail')
                      .where("haverecipe", isEqualTo: true)
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
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildListRecipeItem(snapshot.data.docs[index]);
                      },
                    );
                  }),
            ),
            VerticalSpacing(
              of: 20,
            ),
            CachedNetworkImage(
                imageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/hellocock-6b1dd.appspot.com/o/images%2Fhellocock_info.png?alt=media&token=03a1dd83-b702-48e6-bf06-53135e25c090"),
            VerticalSpacing(
              of: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListKitItem(DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWellCard(
        circular: 30,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(widget.user, document),
          ),
        ),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                    imageUrl: document['thumbnail'],
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
              VerticalSpacing(of: 15),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document['name_eng'],
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: kBodyTextColor),
                    ),
                    Text(
                      document['price'].toString() +
                          "원 / " +
                          document['quantity'] +
                          "잔",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: kActiveColor,
                          height: 1.5),
                    ),
                    Text(
                      document['explain'].replaceAll('\\n', '\n'),
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: kBodyTextColor,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  Widget _buildListRecipeItem(DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWellCard(
        circular: 30,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(document),
          ),
        ),
        child: Container(
          width: 300,
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "recipe",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: kActiveColor,
                        height: 1.5),
                  ),
                ),
                VerticalSpacing(of: 10),
                Center(
                  child: SizedBox(
                      width: 150,
                      child: CachedNetworkImage(
                        imageUrl: document['image'],
                      )),
                ),
                VerticalSpacing(of: 15),
                Center(
                  child: Text(
                    document['name_eng'],
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: kBodyTextColor),
                  ),
                ),
                VerticalSpacing(of: 10),
                Center(
                  child: Text(
                    document['explain'].replaceAll('\\n', '\n'),
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: kBodyTextColor,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
