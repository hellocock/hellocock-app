import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellocock/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hellocock/size_config.dart';
import 'package:intl/intl.dart';

class Pickup extends StatefulWidget {
  final User user;
  final DocumentSnapshot cart;
  final DocumentSnapshot store;
  Pickup(this.user, this.cart, this.store);

  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  final now = DateTime.now();
  DateTime _chosenDateTime;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];

  var latitude;
  var longitude;

  @override
  void initState() {
    super.initState();

    if (widget.cart['pickup_time'] != null)
      _chosenDateTime = widget.cart['pickup_time'].toDate();
    else {
      _chosenDateTime = new DateTime(now.year, now.month, now.day, 18, 00);
    }
    latitude = widget.store['location'].latitude.toDouble();
    longitude = widget.store['location'].longitude.toDouble();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        position: LatLng(latitude, longitude)));
  }

  void _showDatePicker(context) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    if (Platform.isIOS)
      showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                height: 275,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            minuteInterval: 30,
                            minimumDate:
                                DateTime(now.year, now.month, now.day, 18, 0),
                            maximumDate:
                                DateTime(now.year, now.month, now.day, 22, 0),
                            use24hFormat: true,
                            initialDateTime: _chosenDateTime,
                            onDateTimeChanged: (val) {
                              setState(() {
                                _chosenDateTime = val;
                              });
                            })),

                    // Close the modal
                    CupertinoButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ));
    if (Platform.isAndroid)
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Container(
                height: 200,
                color: Colors.white,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 30,
                    minimumDate: DateTime(now.year, now.month, now.day, 18, 0),
                    maximumDate: DateTime(now.year, now.month, now.day, 22, 0),
                    use24hFormat: true,
                    initialDateTime: _chosenDateTime,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "수령 정보 확인",
          textScaleFactor: 1,
          style: TextStyle(
              color: kActiveColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(
          of: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "수령인",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBodyTextColor,
                fontSize: 15,
              ),
            ),
            Text(
              widget.cart['name'],
              textScaleFactor: 1,
              style: TextStyle(
                  color: kBodyTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            )
          ],
        ),
        VerticalSpacing(of: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "수령시간",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBodyTextColor,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 30,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/icons/arrow_dropdown.svg"),
                        Text(
                          DateFormat('HH:mm').format(_chosenDateTime),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    onPressed: () => _showDatePicker(context),
                    color: Colors.white,
                  ),
                ),
                HorizontalSpacing(of: 3),
              ],
            ),
          ],
        ),
        VerticalSpacing(of: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "수령지",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBodyTextColor,
                fontSize: 15,
              ),
            ),
            Text(
              widget.store['name'],
              textScaleFactor: 1,
              style: TextStyle(
                  color: kBodyTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            )
          ],
        ),
        VerticalSpacing(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.store['address'].replaceAll("\\n", '\n'),
              textAlign: TextAlign.end,
              style: TextStyle(color: kBodyTextColor, fontSize: 12),
            ),
          ],
        ),
        VerticalSpacing(of: 30),
        Center(
          child: Container(
            width: 300,
            height: 300,
            child: Opacity(
              opacity: 0.8,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude), zoom: 16),
                markers: Set.from(allMarkers),
                myLocationButtonEnabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
