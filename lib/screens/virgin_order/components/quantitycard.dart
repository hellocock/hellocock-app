import 'package:flutter/material.dart';

import '../../../constants.dart';

class QuantityCard extends StatefulWidget {
  final int quantity;
  final GestureTapCallback onpressed1;
  final GestureTapCallback onpressed2;

  const QuantityCard(
      {Key key,
      @required this.quantity,
      @required this.onpressed1,
      @required this.onpressed2})
      : super(key: key);

  @override
  _QuantityCardState createState() => _QuantityCardState();
}

class _QuantityCardState extends State<QuantityCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 2.0,
      child: Container(
        width: 275,
        height: 38,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: widget.onpressed1,
                  child: Text(
                    '-',
                    style: TextStyle(
                        color: kBodyTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              Text(
                widget.quantity.toString(),
                style: TextStyle(
                    color: kBodyTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                  onPressed: widget.onpressed2,
                  child: Text(
                    '+',
                    style: TextStyle(
                        color: kBodyTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  )),
            ]),
      ),
    );
  }
}
