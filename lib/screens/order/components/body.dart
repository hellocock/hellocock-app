import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/payment/payment_screen.dart';
import 'package:hellocock/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _valueList = ['18:00', '19:00', '20:00', '21:00'];
  var _selectedValue = '19:00';
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(37.54658, 127.07564)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                " 주문내역 확인",
                style: TextStyle(
                    color: kActiveColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(
                of: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "칵테일",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBodyTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("블루 하와이 칵테일 키트",
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ),
                  Text(
                    "8,900원",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text("바카디 2병, 파인애플 주스 2병, 블루 큐라소 1병",
                    style: TextStyle(
                      fontSize: 11,
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 2.0,
                child: Container(
                  width: 400,
                  height: 30,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(onPressed: () {}, child: Text('-')),
                        Text("1"),
                        FlatButton(onPressed: () {}, child: Text('+')),
                      ]),
                ),
              ),
              VerticalSpacing(
                of: 30,
              ),
              Text(
                " 수령 정보 확인",
                style: TextStyle(
                    color: kActiveColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(
                of: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "수령인",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text("김수염")
                ],
              ),
              VerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "수령시간",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    width: 97,
                    height: 35,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            iconEnabledColor: kActiveColor,
                            value: _selectedValue,
                            items: _valueList
                                .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 13),
                                    )))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              VerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "수령지",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text("궤도에 오르다")
                ],
              ),
              VerticalSpacing(),
              Container(
                width: 300,
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(37.550484, 127.073810), zoom: 15),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(allMarkers),
                ),
              ),
              VerticalSpacing(
                of: 50,
              ),
              PrimaryButton(
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  ),
                ),
                text: "결제하기",
              ),
              VerticalSpacing(
                of: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
