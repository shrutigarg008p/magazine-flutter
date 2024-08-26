import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Assets/about_icon_icons.dart';
import 'package:graphics_news/Assets/bookmark_icon_icons.dart';
import 'package:graphics_news/Assets/contact_icon_icons.dart';
import 'package:graphics_news/Assets/contact_left_icon_icons.dart';
import 'package:graphics_news/Assets/downloads_left_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_left_icon_icons.dart';
import 'package:graphics_news/Assets/listing_calander_icon_icons.dart';
import 'package:graphics_news/Assets/logout_left_icon_icons.dart';
import 'package:graphics_news/Assets/magazine_left_icon_icons.dart';
import 'package:graphics_news/Assets/menu_icon_icons.dart';
import 'package:graphics_news/Assets/news_left_icon_icons.dart';
import 'package:graphics_news/Assets/profile_left_icon_icons.dart';
import 'package:graphics_news/Assets/refer_left_icon_icons.dart';
import 'package:graphics_news/Assets/services_left_icon_icons.dart';
import 'package:graphics_news/Assets/setting_icon_icons.dart';
import 'package:graphics_news/Assets/subscription_left_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/common_widget/common_app_bar.dart';
import 'package:graphics_news/screens/Auth/Login.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Information%20Screens/About_us.dart';
import 'package:graphics_news/screens/Information%20Screens/Bookmarks.dart';
import 'package:graphics_news/screens/Information%20Screens/Contact.dart';
import 'package:graphics_news/screens/Information%20Screens/Faq.dart';
import 'package:graphics_news/screens/Information%20Screens/Graphics_services.dart';
import 'package:graphics_news/screens/Magazines/News_listing.dart';
import 'package:graphics_news/screens/Settings/Account.dart';
import 'package:graphics_news/screens/Settings/Downloads.dart';
import 'package:graphics_news/screens/Settings/Refer_friend.dart';
import 'package:graphics_news/screens/Settings/Settings.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopicFollowDetails extends StatefulWidget {
  final int? topicId;
  final String? topicName;

  const TopicFollowDetails({Key? key, this.topicId, this.topicName})
      : super(key: key);

  @override
  _TopicFollowDetailsState createState() => _TopicFollowDetailsState();
}

class _TopicFollowDetailsState extends State<TopicFollowDetails> {
  int bottomNavigationSelectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  dynamic mediaQueryData;
  Future? myFuture;
  var token;
  int activeIndex = 0;
  bool isMagazine = true;
  bool isNewsPaper = false;
  List settingsTile = ['Magazines', 'NewsPapers'];

  Future getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = Future.wait([_getDataForMagazineListingPage(), getSharedPref()]);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "${widget.topicName}",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: WidgetColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: bottomNavigationDrawer(),
        body: FutureBuilder(
            future: myFuture,
            builder: (context, user) {
              if (user.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: WidgetColors.primaryColor,
                  ),
                );
              } else {
                return SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        settingsListTile(),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        height: 26.0,
                                      ),
                                      if (isMagazine) magazinesText(),
                                      if (isMagazine)
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                      if (isMagazine) magazineGrid(),
                                      if (isNewsPaper) newsPaperText(),
                                      if (isNewsPaper)
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                      if (isNewsPaper) newsPaperGrid(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  Widget bottomNavigationDrawer() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          bottomNavigationSelectedIndex = index;
        });
      },
      currentIndex: bottomNavigationSelectedIndex,
      items: [
        BottomNavigationBarItem(
          label: "HOME",
          icon: InkWell(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomePage())),
            child: Icon(
              Icons.home,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "ABOUT",
          icon: InkWell(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        Aboutus())),
            child: Icon(
              AboutIcon.about,
              // color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "SETTINGS",
          icon: InkWell(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        Settings())),
            child: Icon(
              SettingIcon.svg_settings,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "FAQ",
          icon: InkWell(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Faq())),
            child: Icon(
              FAQIcon.faq,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "CONTACT",
          icon: InkWell(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        Contact())),
            child: Icon(
              ContactIcon.svg_contact,
            ),
          ),
        ),
      ],
    );
  }

  Widget settingsListTile() {
    return Container(
      margin: EdgeInsets.only(left: 17.0),
      height: 48.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              settingsTile.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        switch (index) {
                          case 0:
                            isMagazine = true;
                            isNewsPaper = false;
                            break;
                          case 1:
                            isMagazine = false;
                            isNewsPaper = true;
                            break;
                        }
                        activeIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 44.0,
                        width: MediaQuery.of(context).size.width * 0.42,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: activeIndex == index
                              ? WidgetColors.primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          settingsTile[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 13.0
                                  : 13.0.sp,
                              fontWeight: FontWeight.w400,
                              color: activeIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget newsPaperText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          Container(
              width: 3.0,
              height: 20.0,
              child: VerticalDivider(
                thickness: 2.0,
                color: WidgetColors.primaryColor,
              )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'NewsPapers',
                    style: TextStyle(
                        fontSize: mediaQueryData.orientation ==
                                    Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 17.0
                            : 17.0.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget magazinesText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          Container(
              width: 3.0,
              height: 20.0,
              child: VerticalDivider(
                thickness: 2.0,
                color: WidgetColors.primaryColor,
              )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Magazines',
                    style: TextStyle(
                        fontSize: mediaQueryData.orientation ==
                                    Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 17.0
                            : 17.0.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget newsPaperGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mediaQueryData.orientation == Orientation.landscape
              ? 4
              : data.size.shortestSide > 600 &&
                      mediaQueryData.orientation == Orientation.portrait
                  ? 4
                  : 2,
          mainAxisSpacing: 13.0,
          childAspectRatio: 0.7,
        ),
        itemCount: magazineListingResponse['DATA']['newspapers'].length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            width: 178.0,
            height: 230.0,
            child: Card(
              elevation: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 210.0,
                    width: 178.0,
                    // image: AssetImage(magazineImages[index]),
                    image: NetworkImage(magazineListingResponse['DATA']
                        ['newspapers'][index]['cover_image']),
                    // fit: BoxFit.fill,
                  ),
                  Text(
                    magazineListingResponse['DATA']['newspapers'][index]
                        ['title'],
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      magazineListingResponse['DATA']['newspapers'][index]
                          ['price'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget magazineGrid() {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mediaQueryData.orientation == Orientation.landscape
              ? 4
              : data.size.shortestSide > 600 &&
                      mediaQueryData.orientation == Orientation.portrait
                  ? 4
                  : 2,
          mainAxisSpacing: 13.0,
          childAspectRatio: 0.7,
        ),
        itemCount: magazineListingResponse['DATA']['magazines'].length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            width: 178.0,
            height: 230.0,
            child: Card(
              elevation: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 210.0,
                    width: 178.0,
                    // image: AssetImage(magazineImages[index]),
                    image: NetworkImage(magazineListingResponse['DATA']
                        ['magazines'][index]['cover_image']),
                    //  fit: BoxFit.fill,
                  ),
                  Text(
                    "  ${magazineListingResponse['DATA']['magazines'][index]['title']}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "  ${magazineListingResponse['DATA']['magazines'][index]['price']}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> magazineListingResponse = Map();

  Future _getDataForMagazineListingPage() async {
    String baseurl = "http://gcgl.dci.in/public/api/";
    String parameterurl = "customer/tags/${widget.topicId}/details";

    var response = await http.get(Uri.parse(baseurl + parameterurl), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9nY2dsLmRjaS5pblwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjM0NzA0MzQ0LCJleHAiOjE2MzczMzIzNDQsIm5iZiI6MTYzNDcwNDM0NCwianRpIjoiWG1ZcEZIVTZZc0ZLZ1JySSIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.RmgRt_HtakUMMKI4Rj2-b2bcKiYGMdyBNEtJXDzD4hc',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    magazineListingResponse = json.decode(response.body);
    if (magazineListingResponse['STATUS'] == 200) {
      print('data fetched successfully');
      //   print(magazineDetailResponse.toString());
    } else
      print(magazineListingResponse['MESSAGE']);
  }
}
