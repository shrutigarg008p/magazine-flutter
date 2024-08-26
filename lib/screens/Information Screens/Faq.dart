import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Assets/about_icon_icons.dart';
import 'package:graphics_news/Assets/contact_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_icon_icons.dart';
import 'package:graphics_news/Assets/setting_icon_icons.dart';
import 'package:graphics_news/Assets/about_icon_icons.dart';
import 'package:graphics_news/Assets/bookmark_icon_icons.dart';
import 'package:graphics_news/Assets/contact_icon_icons.dart';
import 'package:graphics_news/Assets/contact_left_icon_icons.dart';
import 'package:graphics_news/Assets/downloads_left_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_left_icon_icons.dart';
import 'package:graphics_news/Assets/home_calander_icon_icons.dart';
import 'package:graphics_news/Assets/home_icon_icons.dart';
import 'package:graphics_news/Assets/logout_left_icon_icons.dart';
import 'package:graphics_news/Assets/magazine_left_icon_icons.dart';
import 'package:graphics_news/Assets/menu_icon_icons.dart';
import 'package:graphics_news/Assets/news_left_icon_icons.dart';
import 'package:graphics_news/Assets/profile_left_icon_icons.dart';
import 'package:graphics_news/Assets/refer_left_icon_icons.dart';
import 'package:graphics_news/Assets/services_left_icon_icons.dart';
import 'package:graphics_news/Assets/setting_icon_icons.dart';
import 'package:graphics_news/Assets/speaker_icon_icons.dart';
import 'package:graphics_news/Assets/subscription_left_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/common_widget/common_app_bar.dart';

import 'package:graphics_news/screens/Auth/Login.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Information%20Screens/About_us.dart';
import 'package:graphics_news/screens/Information%20Screens/Contact.dart';
import 'package:graphics_news/screens/Magazines/Magazine_details.dart';
import 'package:graphics_news/screens/Magazines/Magazine_listing.dart';
import 'package:graphics_news/screens/Magazines/News_listing.dart';
import 'package:graphics_news/screens/Settings/Account.dart';
import 'package:graphics_news/screens/Settings/Downloads.dart';
import 'package:graphics_news/screens/Settings/Refer_friend.dart';
import 'package:graphics_news/screens/Settings/Settings.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';

import 'Bookmarks.dart';
import 'Graphics_services.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationSelectedIndex = 3;
  List expansiontile = [
    'Order Placing, cancellation and returns',
    'Payments and Transactions',
    'Orders, Saved Items and Cart',
    'Account and Security',
    'Payments and Transactions',
    'Orders, Saved Items and Cart',
    'Account and Security',
  ];
  dynamic mediaQueryData;
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: CommonAppBar.getAppBar(
          context, () => scaffoldKey.currentState!.openDrawer()),
      bottomNavigationBar: bottomNavigationDrawer(),
      drawer: faqDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32.0,
                      ),
                      faqText(),
                      SizedBox(
                        height: 16.0,
                      ),
                      faqContent(),
                      SizedBox(
                        height: 18.0,
                      ),
                      searchFormField(),
                      SizedBox(
                        height: 24.0,
                      ),
                      expansionFaqTiles(),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
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

  Widget faqDrawer() {
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Magazine_listing())),
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

  Widget faqText() {
    return Container(
        child: Text(
      'FAQ',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: mediaQueryData.orientation == Orientation.landscape &&
                  data.size.shortestSide < 600
              ? 17.0
              : 17.sp,
          color: Color(0xFF212121)),
    ));
  }

  Widget faqContent() {
    return Container(
      margin: EdgeInsets.only(left: 28.0, right: 28.0),
      //padding: EdgeInsets.symmetric(horizontal: 20.0),

      child: Text(
        "In a milieu that likes to box people and companies into short descriptions,one can define us as a ‘Digital Data Analytics and Consulting Company’.",
        style: TextStyle(
          fontSize: mediaQueryData.orientation == Orientation.landscape &&
                  data.size.shortestSide < 600
              ? 14.0
              : 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget searchFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
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
            //errorStyle: TextAlignVertical.center,
            //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.black),
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
      ),
    );
  }

  Widget expansionFaqTiles() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: expansiontile.length,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        isExpanded = value;
                      });
                    },
                    childrenPadding: EdgeInsets.symmetric(horizontal: 6.0),
                    trailing: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Color(0xFF212121),
                    ),
                    title: Text(
                      expansiontile[i].toString(),
                      style: TextStyle(
                          fontSize: mediaQueryData.orientation ==
                                      Orientation.landscape &&
                                  data.size.shortestSide < 600
                              ? 14.0
                              : 14.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF212121)),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          "In a milieu that likes to box people and companies into short descriptions,one can define us as a ‘Digital Data Analytics and Consulting Company’.",
                          style: TextStyle(
                            fontSize: mediaQueryData.orientation ==
                                        Orientation.landscape &&
                                    data.size.shortestSide < 600
                                ? 14.0
                                : 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22.0,
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.0,
                ),
              ],
            );
          }),
    );
  }
}
