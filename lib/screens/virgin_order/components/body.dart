import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/virgin_order/components/delivery.dart';
import 'package:hellocock/screens/virgin_order/components/order.dart';
import 'package:hellocock/screens/virgin_order/components/quantitycard.dart';
import 'package:hellocock/screens/virgin_order_completed/order_completed_screen.dart';
import 'package:hellocock/screens/policy/payment_policy/payment_policy_screen.dart';
import 'package:hellocock/screens/policy/pickup_policy/pickup_policy_screen.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bootpay_api/bootpay_api.dart';
import 'package:bootpay_api/model/payload.dart';
import 'package:bootpay_api/model/extra.dart';
import 'package:bootpay_api/model/user.dart' as bootpay;

class Body extends StatefulWidget {
  final User user;
  final DocumentSnapshot cart;

  Body(
    this.user,
    this.cart,
  );

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _totalprice = 0;
  bool food = false;
  int count = 0;
  bool value_all = false;
  bool value1 = false;
  bool value2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Order(widget.user, widget.cart),
              QuantityCard(
                quantity: widget.cart['cocktail']['quantity'],
                onpressed1: () {
                  if (widget.cart['cocktail']['quantity'] > 1) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection("cart")
                          .doc(widget.user.email)
                          .update({
                        'cocktail': {
                          'name': widget.cart['cocktail']['name'],
                          'price': widget.cart['cocktail']['price'],
                          'quantity': widget.cart['cocktail']['quantity'] - 1
                        },
                      });
                      _totalprice =
                          _totalprice - widget.cart['cocktail']['price'];
                    });
                  }
                },
                onpressed2: () {
                  setState(() {
                    FirebaseFirestore.instance
                        .collection("cart")
                        .doc(widget.user.email)
                        .update(
                      {
                        'cocktail': {
                          'name': widget.cart['cocktail']['name'],
                          'price': widget.cart['cocktail']['price'],
                          'quantity': widget.cart['cocktail']['quantity'] + 1
                        },
                      },
                    );
                    _totalprice =
                        _totalprice + widget.cart['cocktail']['price'];
                  });
                },
              ),
              Delivery(widget.user, widget.cart),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "결제 진행",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: kActiveColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                VerticalSpacing(
                  of: 30,
                ),
                Text(
                  "주문 금액",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 17,
                      color: kBodyTextColor,
                      fontWeight: FontWeight.bold),
                ),
                VerticalSpacing(
                  of: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        widget.cart['cocktail']['name'] +
                            " 키트 " +
                            widget.cart['cocktail']['quantity'].toString() +
                            "개",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: kBodyTextColor,
                            fontWeight: FontWeight.w500)),
                    Text(
                      (widget.cart['cocktail']['price'] *
                                  widget.cart['cocktail']['quantity'])
                              .toString() +
                          "원",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: Color(0xFFFF4D4D),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                VerticalSpacing(),
                Divider(
                  thickness: 1.5,
                  color: kBodyTextColor,
                ),
                VerticalSpacing(),
                StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("cart")
                        .snapshots(),
                    builder: (context, snapshot) {
                      _totalprice = widget.cart['cocktail']['price'] *
                          widget.cart['cocktail']['quantity'];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("총 결제 금액",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kBodyTextColor)),
                          Text(
                            _totalprice.toString() + "원",
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Color(0xFFFF4D4D),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    }),
                VerticalSpacing(of: 15),
                Text(
                  "위 내용을 확인하였으며 결제에 동의합니다.",
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 12, color: kBodyTextColor),
                ),
                VerticalSpacing(
                  of: 30,
                )
              ]),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Checkbox(
                      value: value_all,
                      onChanged: (bool value) {
                        setState(() {
                          value_all = !value_all;
                          if (value_all = true) {
                            value1 = true;
                            value2 = true;
                          }
                        });
                      },
                      hoverColor: kActiveColor,
                      focusColor: kActiveColor,
                      activeColor: kActiveColor,
                    ),
                  ),
                  Text(
                    " 모든 약관 동의",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor),
                  ),
                ],
              ),
              Divider(
                thickness: 1.5,
                color: kBodyTextColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Checkbox(
                          value: value1,
                          onChanged: (bool value) {
                            setState(() {
                              value1 = !value1;
                              if (value1 == false) value_all = false;
                            });
                          },
                          hoverColor: kActiveColor,
                          focusColor: kActiveColor,
                          activeColor: kActiveColor,
                        ),
                      ),
                      Text(
                        " [필수] 배송 이용약관",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 13, color: kBodyTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/arrow_next.svg"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PickupPolicyScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Checkbox(
                          value: value2,
                          onChanged: (bool value) {
                            setState(() {
                              value2 = !value2;
                              if (value2 == false) value_all = false;
                            });
                          },
                          hoverColor: kActiveColor,
                          focusColor: kActiveColor,
                          activeColor: kActiveColor,
                        ),
                      ),
                      Text(
                        " [필수] 청약철회방침",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 13, color: kBodyTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/arrow_next.svg"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPolicyScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              VerticalSpacing(
                of: 50,
              ),
              PrimaryButton(
                press: () {
                  if (value1 == true && value2 == true)
                    goBootpayRequest(context);
                  else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: Text(
                              "약관에 동의해야 결제가 가능합니다.",
                              style: TextStyle(
                                fontSize: 13,
                                color: kBodyTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              new CupertinoDialogAction(
                                child: Text(
                                  '확인',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
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

  void goBootpayRequest(BuildContext context) async {
    Payload payload = Payload();
    payload.androidApplicationId = '5feaba562fa5c20027038fc5';
    payload.iosApplicationId = '5feaba562fa5c20027038fc6';

    payload.method = 'card';
    payload.name = '헬로콕';
    payload.price = _totalprice.toDouble();
    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();

    bootpay.User user = bootpay.User();
    user.username = widget.cart['name'];
    user.email = widget.cart.id;
    user.area = widget.cart['address'];

    Extra extra = Extra();
    extra.appScheme = 'hellocock';
    extra.theme = 'custom';
    extra.custom_background = '#00c8ff';
    extra.custom_font_color = '#ffffff';

    // Item item1 = Item();
    // item1.itemName = "시브리즈 키트"; // 주문정보에 담길 상품명
    // item1.qty = 1; // 해당 상품의 주문 수량
    // item1.unique = "ITEM_CODE_SEABREEZE"; // 해당 상품의 고유 키
    // item1.price = 19000; // 상품의 가격

    // List<Item> itemList = [item1];

    BootpayApi.request(
      context,
      payload,
      extra: extra,
      user: user,
      //items: itemList,
      onDone: (String json) {
        print('onDone: $json');
        FirebaseFirestore.instance
            .collection("order")
            .doc(payload.orderId)
            .update({
          'number': payload.orderId,
          'name': widget.cart['name'],
          'email': widget.cart.id,
          'date': Timestamp.now(),
          'total_price': _totalprice,
          'cocktail': widget.cart['cocktail']
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrderCompletedScreen(widget.cart, payload.orderId),
          ),
        );
      },
      onReady: (String json) {
        //flutter는 가상계좌가 발급되었을때  onReady가 호출되지 않는다. onDone에서 처리해주어야 한다.
        print('onReady: $json');
      },
      onCancel: (String json) {
        print('onCancel: $json');
      },
      onError: (String json) {
        print('onError: $json');
      },
    );
  }
}
