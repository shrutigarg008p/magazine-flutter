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
import 'package:graphics_news/Assets/home_calander_icon_icons.dart';
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

class TopStorieslisting extends StatefulWidget {
  @override
  _TopStorieslistingState createState() => _TopStorieslistingState();
}

class _TopStorieslistingState extends State<TopStorieslisting> {
  int bottomNavigationSelectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List categoryTile = [
    'LifeStyle',
    'Education',
    'Health',
    'Sports',
    'News',
    'Fashion',
    'Business',
  ];

  List magazineImages = [
    'images/img2.png',
    'images/img3.png',
    'images/img4.png',
    'images/img5.png',
    'images/img6.png',
    'images/img7.png',
    'images/img8.png',
    'images/img9.png',
    'images/img10.png',
    'images/img11.png',
    'images/img12.png',
    'images/img13.png',
    'images/img14.png',
  ];
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  dynamic mediaQueryData;
  Future? myFuture;
  var token;

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
        drawer: magazineListingDrawer(),
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
                                      //    selectedFieldIndexContainer(),
                                      //     SizedBox(
                                      //       height: 14.0,
                                      //     ),
                                      //     categoriesListTile(),
                                      //     SizedBox(
                                      //       height: 14.0,
                                      //     ),
                                      //     searchFilterRow(),
                                      //     SizedBox(
                                      //       height: 50.0,
                                      //     ),
                                      relatedNewsText(),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      magazineGrid(),
                                      SizedBox(
                                        height: 10.0,
                                      )
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

  Widget magazineListingDrawer() {
    return Builder(
      builder: (BuildContext context) {
        return Drawer(
          child: ListView(
            children: [
              Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.red)),
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle),
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //       image: AssetImage(
                            //         'assets/profile.jpg',
                            //       ),
                            //       fit: BoxFit.fill),
                            //   shape: BoxShape.circle,
                            // ),
                            child: Icon(
                              Icons.person,
                              size: 50.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         color: Colors.green,
                                  //         )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Profile Name",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         color: Colors.green,
                                  //         )),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Divider(),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'My Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  ProfileLeftIcon.my_profile,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Subscription())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'My Subscriptions',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  SubscriptionLeftIcon.my_subscription,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Downloads())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'My Downloads',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  DownloadsLeftIcon.my_downloads,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => null,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Magazines',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  MagazineLeftIcon.magazines,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => News_listing())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'News',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  NewsLeftIcon.news,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Graphics_services())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Graphic Services',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  ServicesLeftIcon.graphic_services,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Bookmarks())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Bookmarks',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  BookmarkIcon.bookmarks,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Refer_friend())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Refer friends',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  ReferLeftIcon.refer_friends,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Faq())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'FAQ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  FAQLeftIcon.faq2,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact())),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Contact us',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  ContactLeftIcon.contact_us,
                  color: Colors.black,
                ),
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  LogoutLeftIcon.logout,
                  color: Colors.black,
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.red)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image(
                        image: AssetImage('images/facebook_grey.png'),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('images/twitter_grey.png'),
                        )),
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('images/instagram_grey.png'),
                        )),
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('images/youtube_grey.png'),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget selectedFieldIndexContainer() {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: WidgetColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            height: 36.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              'Entertainment',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categoriesListTile() {
    return Container(
      margin: EdgeInsets.only(left: 17.0),
      height: 38.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              categoryTile.length,
              (index) => InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 36.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          categoryTile[index],
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget searchFilterRow() {
    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchPublicationField(),
          SizedBox(
            width: 11.0,
          ),
          Expanded(child: searchByDateField()),
        ],
      ),
    );
  }

  Widget searchPublicationField() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 20.0,
      height: 50.0,
      //borderRadius: BorderRadius.circular(5.0),

      child: TextFormField(
        //inputFormatters: [new LengthLimitingTextInputFormatter(10)],
        keyboardType: TextInputType.phone,
        cursorColor: WidgetColors.primaryColor,
        validator: (input) => input!.isEmpty
            ? 'Enter Username'
            : (input.length < 3 && input.isNotEmpty)
                ? 'Username too short'
                : (input.length < 10 && input.isNotEmpty)
                    ? 'Invalid Username'
                    : null,
        // if (input == null || input.length < ) {
        //   return 'Enter Phone';
        // }

        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () {},
          ),
          //errorStyle: TextAlignVertical.center,
          //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
          hintText: "Search Publication",
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: WidgetColors.primaryColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // onSaved: (input) => userName = input,
      ),
    );
  }

  Widget searchByDateField() {
    return Container(
      //width: MediaQuery.of(context).size.width / 2,

      child: TextFormField(
        //inputFormatters: [new LengthLimitingTextInputFormatter(10)],
        keyboardType: TextInputType.phone,
        cursorColor: WidgetColors.primaryColor,
        validator: (input) => input!.isEmpty
            ? 'Enter Username'
            : (input.length < 3 && input.isNotEmpty)
                ? 'Username too short'
                : (input.length < 10 && input.isNotEmpty)
                    ? 'Invalid Username'
                    : null,
        // if (input == null || input.length < ) {
        //   return 'Enter Phone';
        // }

        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          suffixIcon: IconButton(
            icon: Icon(ListingCalanderIcon.listing_page_calender),
            onPressed: () {},
          ),
          //errorStyle: TextAlignVertical.center,
          //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
          hintText: "Search by date",

          hintStyle: TextStyle(color: Colors.black, fontSize: 13.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: WidgetColors.primaryColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // onSaved: (input) => userName = input,
      ),
    );
  }

  Widget relatedNewsText() {
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
                    'Top Stories',
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

  Widget magazineGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
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
            childAspectRatio: 1.0,
          ),
          itemCount: promotedContentListingResponse['DATA'].length,
          itemBuilder: (context, index) => Container(
                width: 220.0,
                height: 200.0,
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: AspectRatio(
                          aspectRatio: 220 / 125,
                          child: Image(
                            image: NetworkImage(
                                promotedContentListingResponse['DATA'][index]
                                    ['content_image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promotedContentListingResponse['DATA'][index]
                                    ['slug'],
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 10.0
                                        : 10.0.sp,
                                    fontWeight: FontWeight.w400,
                                    color: WidgetColors.primaryColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Text(
                                promotedContentListingResponse['DATA'][index]
                                    ['short_description'],
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 10.0
                                        : 10.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      HomeCalanderIcon.home_calender,
                                      color: Colors.grey,
                                      size: 10.0,
                                    ),
                                    SizedBox(
                                      width: 5.0.w,
                                    ),
                                    Expanded(
                                        child: Text(
                                      promotedContentListingResponse['DATA']
                                          [index]['date'],
                                      // homePageResponse['DATA']
                                      //         ['top_stories'][index]
                                      //     ['date'],
                                      style: TextStyle(
                                          fontSize: mediaQueryData
                                                          .orientation ==
                                                      Orientation.landscape &&
                                                  data.size.shortestSide < 600
                                              ? 10.0
                                              : 10.0.sp,
                                          color: Colors.grey),
                                    ))
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              )
          //     Padding(
          //   padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          //   child: Container(
          //     width: 162.0,
          //     height: 250.0,
          //     child: Card(
          //       elevation: 0.0,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Image(
          //             height: 220.0,
          //             width: 162.0,
          //             // image: AssetImage(magazineImages[index]),
          //             image: NetworkImage(magazineListingResponse['DATA']['data']
          //             [index]['cover_image']),
          //             fit: BoxFit.fill,
          //           ),
          //           Text(
          //             magazineListingResponse['DATA']['data'][index]['title'],
          //             style: TextStyle(
          //               fontSize: 14.0,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           Expanded(
          //             child: Text(
          //               magazineListingResponse['DATA']['data'][index]['price'],
          //               style: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }

  Map<String, dynamic> promotedContentListingResponse = Map();

  Future _getDataForMagazineListingPage() async {
    String baseurl = "http://gcgl.dci.in/public/api/";
    String parameterurl = "customer/blogs/top_story/listing";

    var response = await http.get(Uri.parse(baseurl + parameterurl), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9nY2dsLmRjaS5pblwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjM0NzA0MzQ0LCJleHAiOjE2MzczMzIzNDQsIm5iZiI6MTYzNDcwNDM0NCwianRpIjoiWG1ZcEZIVTZZc0ZLZ1JySSIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.RmgRt_HtakUMMKI4Rj2-b2bcKiYGMdyBNEtJXDzD4hc',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    promotedContentListingResponse = json.decode(response.body);
    if (promotedContentListingResponse['STATUS'] == 200) {
      print('data fetched successfully');
      //   print(magazineDetailResponse.toString());
    } else
      print(promotedContentListingResponse['MESSAGE']);
  }
}
