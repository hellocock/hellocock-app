import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hellocock/screens/home/home_screen.dart';
import 'package:hellocock/screens/inquiry/inquiry_screen.dart';
import 'package:hellocock/screens/manual/manual_screen.dart';
import 'package:hellocock/screens/mycock/mycock_screen.dart';
import 'package:hellocock/screens/notice/notice_screen.dart';
import 'package:hellocock/screens/profile/profile_screen.dart';
import 'package:hellocock/screens/root.dart';
import 'package:hellocock/screens/virgin_cocktail/virgin_cocktail_screen.dart';
import '../size_config.dart';
import '../constants.dart';

class BottomNavBar extends StatefulWidget {
  final User user;
  BottomNavBar(this.user);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/virgin.svg", "title": "Virgin"},
    {"icon": "assets/icons/mycock.svg", "title": "My cock"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];

  List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(widget.user),
      VirginCocktailScreen(widget.user),
      MyCockScreen(widget.user),
      ProfileScreen(widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: kActiveColor,
        selectedItemColor: kActiveColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: buildSvgIcon(
                src: _navitems[index]['icon'],
                isActive: _selectedIndex == index),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.4,
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(
            Icons.menu,
            color: kActiveColor,
          ),
        ),
      ),
      title: SvgPicture.asset("assets/icons/hellocock_title.svg"),
      actions: [
        if (_selectedIndex == 3 && widget.user != null)
          IconButton(
              icon: SvgPicture.asset("assets/icons/signout.svg"),
              color: kActiveColor,
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text(
                          "로그아웃",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        content: Text(
                          "정말 로그아웃 하시겠어요?",
                          style: TextStyle(fontSize: 13, height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          new CupertinoDialogAction(
                              child: Text(
                                '아니오',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              }),
                          new CupertinoDialogAction(
                              child: Text(
                                '예',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/root'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RootPage()));
                              }),
                        ],
                      );
                    });
              })
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SvgPicture buildSvgIcon({@required String src, bool isActive = false}) {
    return src != "assets/icons/virgin.svg"
        ? SvgPicture.asset(
            src,
            width: 20,
            height: 20,
            color: kActiveColor,
          )
        : SvgPicture.asset(
            src,
            width: 20,
            height: 25,
            color: kActiveColor,
          );
  }

  Widget buildDrawer(BuildContext context) {
    return SizedBox(
      width: 226,
      child: Drawer(
        elevation: 10.0,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 246,
                  child: DrawerHeader(
                    child: null,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/hellocock-6b1dd.appspot.com/o/images%2Fimyourcocktail.png?alt=media&token=c161be7a-e11b-4178-b660-5f462016c43f")),
                    ),
                  ),
                ),
                VerticalSpacing(of: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoticeScreen(),
                          ),
                        ),
                        child: Text(
                          "- 공지사항",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: kBodyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      VerticalSpacing(of: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InquiryScreen(),
                          ),
                        ),
                        child: Text(
                          "- 1:1 문의 ",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: kBodyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      VerticalSpacing(of: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualScreen(),
                          ),
                        ),
                        child: Text(
                          "- 이용방법",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: kBodyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
