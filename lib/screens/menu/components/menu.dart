import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class MenuCard extends StatefulWidget {
  final DocumentSnapshot store;
  final int index;
  final User user;

  MenuCard(this.store, this.index, this.user);
  //final Widget image;

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("cart")
        .doc(widget.user.email)
        .update({'food': []});

    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: widget.store['food'][widget.index]['image'],
              height: 85,
              width: 130,
              fit: BoxFit.cover,
            )),
        HorizontalSpacing(),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.store['food'][widget.index]['name'],
                textScaleFactor: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kBodyTextColor),
              ),
              Text(
                widget.store['food'][widget.index]['explain']
                    .replaceAll("\\n", '\n'),
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14, color: kBodyTextColor),
              ),
              VerticalSpacing(
                of: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.store['food'][widget.index]['price'].toString() +
                        "원",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4D4D),
                    ),
                  ),
                  HorizontalSpacing(of: 50),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0,
                    child: Container(
                      width: 90,
                      height: 30,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                              child: FlatButton(
                                  onPressed: () {
                                    if (count > 0) {
                                      setState(() {
                                        count -= 1;

                                        _addfood();
                                      });
                                    }
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: kBodyTextColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Text(
                              "$count",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: kBodyTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 35,
                              child: FlatButton(
                                  onPressed: () {
                                    count += 1;
                                    _addfood();
                                    setState(() {});
                                  },
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: kBodyTextColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ]),
      ]),
    );
  }

  void _addfood() async {
    var data;
    var foodname;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(widget.user.email)
        .get()
        .then((DocumentSnapshot ds) {
      data = ds['food'];
    });
    await Future.delayed(Duration(seconds: 1));

    final List food = List<Map>.from(data ?? []);

    for (int i = 0; i < food.length; i++) {
      if (food[i]['name'] == widget.store['food'][widget.index]['name'])
        food.removeAt(i);
    }

    if (count != 0) {
      final updateData = {
        'name': widget.store['food'][widget.index]['name'],
        'price': widget.store['food'][widget.index]['price'],
        'quantity': count
      };
      print(food);

      food.add(updateData);
    }
    FirebaseFirestore.instance
        .collection("cart")
        .doc(widget.user.email)
        .update({'food': food});
  }
}
