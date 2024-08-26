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
import 'package:graphics_news/screens/Auth/Login.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Information%20Screens/About_us.dart';
import 'package:graphics_news/screens/Information%20Screens/Bookmarks.dart';
import 'package:graphics_news/screens/Information%20Screens/Contact.dart';
import 'package:graphics_news/screens/Information%20Screens/Faq.dart';
import 'package:graphics_news/screens/Information%20Screens/Graphics_services.dart';
import 'package:graphics_news/screens/Magazines/Magazine_listing.dart';
import 'package:graphics_news/screens/Magazines/News_listing.dart';
import 'package:graphics_news/screens/Settings/Account.dart';
import 'package:graphics_news/screens/Settings/Downloads.dart';
import 'package:graphics_news/screens/Settings/Refer_friend.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationSelectedIndex = 2;
  List settingsListHeadings = [
    'Allow Notifications',
    'Night Mode',
    'Font Size',
    'Change Password',
  ];

  List settingsListHeadingstwo = [
    'Allow Downloads on Mobile Data?',
    'Set Storage Location',
  ];

  List legalListItems = [
    'Privacy Policy',
    'Policies and Licenses',
    'Courtesies from GDPR and other laws'
  ];

  List prefsListHeadings = [
    'Education',
    'Health',
    'Entertainment',
    'Lifestyle',
    'International',
    'Relationship',
    'News',
    'Music',
    'Sports',
  ];

  bool isSwitched = true;
  dynamic mediaQueryData;
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
              color: Color(0xFF212121),
              fontSize: mediaQueryData.orientation == Orientation.landscape &&
                      data.size.shortestSide < 600
                  ? 17.0
                  : 17.0.sp,
              fontWeight: FontWeight.w600),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFFCA0A0A),
          ),
        ),
      ),
      key: scaffoldKey,
      bottomNavigationBar: bottomNavigationDrawer(),
      drawer: settingsDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // SizedBox(
                    //   height: 24.0,
                    // ),
                    notificationText('Notification'),
                    notificationList(),
                    notificationText('Downloads'),
                    notificationListTwo(),
                    notificationText('Legal'),
                    legalList(),
                    notificationText('Preferences'),
                    preferencesList(),
                    SizedBox(
                      height: 32.0,
                    ),
                    saveButton(),
                    SizedBox(
                      height: 38.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsDrawer() {
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

  Widget notificationText(String name) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      height: 42.0,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
                width: 3.0,
                height: 20.0,
                child: VerticalDivider(
                  thickness: 2.0,
                  color: WidgetColors.primaryColor,
                )),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: mediaQueryData.orientation ==
                                    Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 16.0
                            : 16.0.sp,
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

  Widget notificationList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: settingsListHeadings.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  settingsListHeadings[index],
                  style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 14.0
                            : 14.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //left: 20.0,
                  right: 20.0,
                  //top: 16.0,
                  // bottom: 16.0,
                ),
                child: index <= 1
                    ? Switch(
                        value: isSwitched,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.grey[300],
                        inactiveTrackColor: Colors.grey[300],
                        inactiveThumbColor: WidgetColors.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      )
                    : index == 2
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 16.0,
                              left: 20.0,
                            ),
                            child: Text(
                              'XS   S   M   L   XL',
                              style: TextStyle(
                                  fontSize: mediaQueryData.orientation ==
                                              Orientation.landscape &&
                                          data.size.shortestSide < 600
                                      ? 14.0
                                      : 14.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios)),
                // child: Text(
                //   settingsListOutputs[index],
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black,
                //   ),
                // ),
              ),
            ],
          ),
          index == settingsListHeadings.length - 1
              ? Container()
              : Divider(
                  thickness: 1.6,
                  color: Colors.grey[300],
                )
        ],
      ),
    ));
  }

  Widget notificationListTwo() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: settingsListHeadingstwo.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  settingsListHeadingstwo[index],
                  style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 14.0
                            : 14.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //left: 20.0,
                  right: 20.0,
                  //top: 16.0,
                  // bottom: 16.0,
                ),
                child: index <= 0
                    ? Switch(
                        value: isSwitched,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.grey[300],
                        inactiveTrackColor: Colors.grey[300],
                        inactiveThumbColor: WidgetColors.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      )
                    : IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                // child: Text(
                //   settingsListOutputs[index],
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black,
                //   ),
                // ),
              ),
            ],
          ),
          index == settingsListHeadingstwo.length - 1
              ? Container()
              : Divider(
                  thickness: 1.6,
                  color: Colors.grey[300],
                )
        ],
      ),
    ));
  }

  Widget legalList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: legalListItems.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  legalListItems[index],
                  style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 14.0
                            : 14.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //left: 20.0,
                  right: 20.0,
                  //top: 16.0,
                  // bottom: 16.0,
                ),
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                // child: Text(
                //   settingsListOutputs[index],
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black,
                //   ),
                // ),
              ),
            ],
          ),
          index == legalListItems.length - 1
              ? Container()
              : Divider(
                  thickness: 1.6,
                  color: Colors.grey[300],
                )
        ],
      ),
    ));
  }

  Widget preferencesList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: prefsListHeadings.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  prefsListHeadings[index],
                  style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape &&
                                data.size.shortestSide < 600
                            ? 14.0
                            : 14.0.ssp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[300],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.6,
            color: Colors.grey[300],
          )
        ],
      ),
    ));
  }

  Widget saveButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: WidgetColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'SAVE',
          style: TextStyle(
            fontSize: mediaQueryData.orientation == Orientation.landscape &&
                    data.size.shortestSide < 600
                ? 14.0
                : 14.0.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
