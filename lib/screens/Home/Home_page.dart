import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:graphics_news/screens/Information%20Screens/About_us.dart';
import 'package:graphics_news/screens/Information%20Screens/Bookmarks.dart';
import 'package:graphics_news/screens/Information%20Screens/Contact.dart';
import 'package:graphics_news/screens/Information%20Screens/Faq.dart';
import 'package:graphics_news/screens/Information%20Screens/Graphics_services.dart';
import 'package:graphics_news/screens/Magazines/Magazine_details.dart';
import 'package:graphics_news/screens/Magazines/Magazine_listing.dart';
import 'package:graphics_news/screens/Magazines/News_listing.dart';
import 'package:graphics_news/screens/Magazines/categories_details.dart';
import 'package:graphics_news/screens/Magazines/categories_listing.dart';
import 'package:graphics_news/screens/Magazines/gallery_listing.dart';
import 'package:graphics_news/screens/Magazines/news_details.dart';
import 'package:graphics_news/screens/Magazines/pod_cast_listing.dart';
import 'package:graphics_news/screens/Magazines/promoted_content_details.dart';
import 'package:graphics_news/screens/Magazines/promoted_content_listing.dart';
import 'package:graphics_news/screens/Magazines/top_stories_details.dart';
import 'package:graphics_news/screens/Magazines/top_stories_listing.dart';
import 'package:graphics_news/screens/Magazines/topic_follow_details.dart';
import 'package:graphics_news/screens/Magazines/topic_follow_listing.dart';
import 'package:graphics_news/screens/Magazines/videos_listing.dart';
import 'package:graphics_news/screens/Settings/Account.dart';
import 'package:graphics_news/screens/Settings/Downloads.dart';
import 'package:graphics_news/screens/Settings/Refer_friend.dart';
import 'package:graphics_news/screens/Settings/Settings.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';
import 'package:graphics_news/screens/video_items.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavigationSelectedIndex = 0;
  var token;
  Map<String, dynamic> homePageResponse = Map();

  AudioPlayer audioPlayer = AudioPlayer();

  //AudioPlayer audioPlayer = new AudioPlayer();

  bool isPlaying = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List popularCategoryTextCardColors = [
    Colors.red[400],
    Colors.green[200],
    Colors.blue[300],
    Colors.amber[300],
    Colors.deepPurple[400],
    Colors.blueGrey,
    Colors.deepPurple[400],
    Colors.green[200],
    Colors.red[400],
    Colors.amber[300],
    Colors.deepPurple[400],
    Colors.amber[300],
    Colors.green[200],
    Colors.deepPurple[400],
    Colors.blueGrey,
  ];

  List bannerImages = [
    'images/b1.png',
    'images/b2.png',
    'images/b3.png',
    'images/b4.png',
    'images/b5.png',
  ];
  List topFollows = [
    'Sed ut pers',
    'Nemo enim ex',
    'Quis aute',
    'Quits autem vei eu',
    'Sed ut pers',
    'Quits autem vei eu',
    'Nemo enim ex',
    'Quis aute',
    'Sed ut pers',
  ];
  List carouselImages = [
    'images/gal1.png',
    'images/gal2.png',
    'images/gal3.png',
  ];

  List newsImages = [
    'images/news1.png',
    'images/news2.png',
    'images/news3.png',
  ];

  List magazineImages = [
    'images/mag1.png',
    'images/mag2.png',
    'images/mag3.png',
  ];
  List promoImages = [
    'images/promo1.png',
    'images/promo2.png',
  ];
  List topStoriesImages = [
    'images/Ts1.png',
    'images/ts2.png',
  ];
  List videoImages = [
    'images/vid1.png',
    'images/vid2.png',
    'images/vid3.png',
  ];
  List instaImages = [
    'images/insta1.png',
    'images/insta2.png',
  ];
  double _currentIndexSlider = 0;

  Future? myFuture;

  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  dynamic mediaQueryData;

  Future getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
  }

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = Future.wait([_getDataForHomePage(), getSharedPref()]);
  }

  bool playVideo = false;
  late String videoId;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    if (playVideo)
      return Scaffold(
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: true,
                ),
              ),
              showVideoProgressIndicator: true,
              // videoProgressIndicatorColor: Colors.amber,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    playVideo = false;
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]),
      );
    else
      return Scaffold(
          appBar: CommonAppBar.getAppBar(
              context, () => scaffoldKey.currentState!.openDrawer()),
          key: scaffoldKey,
          backgroundColor: Colors.white,
          bottomNavigationBar: bottomNavigationDrawer(),
          drawer: homePageDrawer(),
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
                    child: Stack(children: [
                      Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                trendingNewsBox(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                newsImageSlider(),
                                SizedBox(
                                  height: 28.0,
                                ),
                                newsPaperSection(),
                                // SizedBox(
                                //   height: 18.0,
                                // ),
                                popularMagazinesSection(),
                                // SizedBox(
                                //   height: 18.0,
                                // ),
                                promotedContentSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                topStoriesSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                videoSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                gallerySection(),
                                SizedBox(
                                  height: 15.0,
                                ),
                                podcastSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                instaSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                popularSection(),
                                SizedBox(
                                  height: 24.0,
                                ),
                                topFollow(),
                                SizedBox(
                                  height: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
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

  Widget homePageDrawer() {
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

  Widget trendingNewsBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18.0),
      child: Container(
        //height: 52.0,
        child: Card(
          borderOnForeground: true,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  SpeakerIcon.loudspeaker_icon,
                  color: Colors.grey,
                  size: 16.w,
                ),
                SizedBox(
                  width: 15.0.w,
                ),
                Expanded(
                  child: RichText(
                      text: TextSpan(
                          text: ("Trending News: "),
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 12
                                  : 12.0.sp,
                              color: WidgetColors.primaryColor,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text:
                                ("This is a test Text news to be shown as announcement"),
                            style: TextStyle(
                                fontSize: mediaQueryData.orientation ==
                                            Orientation.landscape &&
                                        data.size.shortestSide < 600
                                    ? 12
                                    : 12.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newsImageSlider() {
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 18.0),
      //padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
      //width:   MediaQuery.of(context).devicePixelRatio,
      // height: 400 / MediaQuery.of(context).devicePixelRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(
              itemCount: bannerImages.length,
              itemBuilder: (BuildContext context, int itemIndex, int item) =>
                  InkWell(
                    child: Image(
                      image: AssetImage(bannerImages[itemIndex]),
                      fit: BoxFit.fill,
                      //  height: data.size.shortestSide < 600 ? 180 : 400.0,
                      height:
                          mediaQueryData.orientation == Orientation.landscape
                              ? 300
                              : data.size.shortestSide > 600 &&
                                      mediaQueryData.orientation ==
                                          Orientation.portrait
                                  ? 400
                                  : 180,
                      width: double.infinity,
                    ),
                  ),
              options: CarouselOptions(
                  height: mediaQueryData.orientation == Orientation.landscape
                      ? 300
                      : data.size.shortestSide > 600 &&
                              mediaQueryData.orientation == Orientation.portrait
                          ? 400
                          : 180,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndexSlider = index.toDouble();
                    });
                  })),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: 30.0,
              child: new DotsIndicator(
                dotsCount: bannerImages.length,
                position: _currentIndexSlider,
                decorator: DotsDecorator(
                  color: Colors.grey,
                  activeColor: Colors.white,
                  size: const Size.square(6.0),
                  activeSize: const Size(10.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget newsPaperSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      //height: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                        thickness: 2.0.w, color: WidgetColors.primaryColor)),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Newspapers',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => News_listing())),
                        icon: Icon(Icons.arrow_forward,
                            color: WidgetColors.primaryColor),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    homePageResponse['DATA']['newspapers'].length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                    newsId: homePageResponse['DATA']
                                        ['newspapers'][index]['id'],
                                  )));
                    },
                    child: Container(
                      width: 140,
                      // height: 240,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  width: 132.0,
                                  height: 158.0,
                                  image: NetworkImage(homePageResponse['DATA']
                                      ['newspapers'][index]['cover_image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: Image(
                                  width: 26,
                                  height: 26,
                                  image: AssetImage(
                                    'images/bookmark.png',
                                  ),
                                ),
                              )
                            ]),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: data.size.shortestSide < 600 ? 38 : 58,
                              child: Text(
                                homePageResponse['DATA']['newspapers'][index]
                                    ['title'],
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 13
                                        : 13.0.sp,
                                    fontWeight: FontWeight.w400),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topFollow() {
    return Container(
      //  padding: EdgeInsets.only(left: 8.0),
      height: 250.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      width: 3.0.w,
                      height: 20.0.h,
                      child: VerticalDivider(
                        thickness: 2.0.w,
                        color: WidgetColors.primaryColor,
                      )),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Topics to Follow',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Topiclisting())),
                          icon: Icon(Icons.arrow_forward,
                              color: WidgetColors.primaryColor)),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.0),
              child: SingleChildScrollView(
                //  scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: List.generate(
                      homePageResponse['DATA']['topics'].length, (index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopicFollowDetails(
                                    topicId: homePageResponse['DATA']['topics']
                                        [index]['id'],
                                    topicName: homePageResponse['DATA']
                                        ['topics'][index]['name'],
                                  ))),
                      child: Container(
                        height: 46.0,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          homePageResponse['DATA']['topics'][index]['name'],
                          style: TextStyle(
                            fontSize: mediaQueryData.orientation ==
                                        Orientation.landscape &&
                                    data.size.shortestSide < 600
                                ? 13
                                : 13.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularMagazinesSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      //  height: 280.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                        thickness: 2.0.w, color: WidgetColors.primaryColor)),
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
                                  ? 16
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Magazine_listing())),
                        icon: Icon(Icons.arrow_forward,
                            color: WidgetColors.primaryColor),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    homePageResponse['DATA']['magazines'].length, (index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Magazine_details(
                                  magazineId: homePageResponse['DATA']
                                      ['magazines'][index]['id'],
                                ))),
                    child: Container(
                      width: 140,
                      // height: 220,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  width: 132.0,
                                  height: 158.0,
                                  image: NetworkImage(homePageResponse['DATA']
                                      ['magazines'][index]['cover_image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: Image(
                                  width: 26,
                                  height: 26,
                                  image: AssetImage(
                                    'images/bookmark.png',
                                  ),
                                ),
                              )
                            ]),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide > 600
                                  ? 38
                                  : 58,
                              child: Text(
                                homePageResponse['DATA']['magazines'][index]
                                    ['title'],
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 13
                                        : 13.0.sp,
                                    fontWeight: FontWeight.w400),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget promotedContentSection() {
    return data.size.shortestSide < 600
        ? Container(
            padding: EdgeInsets.only(left: 18.0),
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          width: 3.0.w,
                          height: 20.0.h,
                          child: VerticalDivider(
                            thickness: 2.0.w,
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
                                'Promoted Content',
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 16.0
                                        : 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PromotedContentlisting())),
                              child: Icon(
                                Icons.arrow_forward,
                                color: WidgetColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            homePageResponse['DATA']['popular_contents'].length,
                            (index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PromotedContentdetails(
                                          magazineId: homePageResponse['DATA']
                                              ['popular_contents'][index]['id'],
                                        ))),
                            child: Container(
                              width: 220.0,
                              height: 230.0,
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
                                              homePageResponse['DATA']
                                                      ['popular_contents']
                                                  [index]['content_image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              homePageResponse['DATA']
                                                      ['popular_contents']
                                                  [index]['slug'],
                                              style: TextStyle(
                                                  fontSize: mediaQueryData
                                                                  .orientation ==
                                                              Orientation
                                                                  .landscape &&
                                                          data.size
                                                                  .shortestSide <
                                                              600
                                                      ? 10.0
                                                      : 10.0.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: WidgetColors
                                                      .primaryColor),
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 2.0.h,
                                            ),
                                            Text(
                                              homePageResponse['DATA']
                                                      ['popular_contents']
                                                  [index]['title'],
                                              style: TextStyle(
                                                  fontSize: mediaQueryData
                                                                  .orientation ==
                                                              Orientation
                                                                  .landscape &&
                                                          data.size
                                                                  .shortestSide <
                                                              600
                                                      ? 10.0
                                                      : 10.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: 5.0.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    HomeCalanderIcon
                                                        .home_calender,
                                                    color: Colors.grey,
                                                    size: 10.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0.w,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    '25-06-2020',
                                                    // homePageResponse['DATA']
                                                    //         ['popular_contents']
                                                    //     [index]['date'],
                                                    style: TextStyle(
                                                        fontSize: mediaQueryData
                                                                        .orientation ==
                                                                    Orientation
                                                                        .landscape &&
                                                                data.size
                                                                        .shortestSide <
                                                                    600
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
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(left: 18.0),
            height: mediaQueryData.orientation == Orientation.landscape
                ? 210.h
                : 190.0.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          width: 3.0.w,
                          height: 20.0.h,
                          child: VerticalDivider(
                            thickness: 2.0.w,
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
                                'Promoted Content',
                                style: TextStyle(
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 16.0
                                        : 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PromotedContentlisting())),
                              child: Icon(
                                Icons.arrow_forward,
                                color: WidgetColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            homePageResponse['DATA']['popular_contents'].length,
                            (index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PromotedContentdetails())),
                            child: Container(
                              width: 220.0,
                              height: 270.0,
                              child: Card(
                                elevation: 2.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 220 / 128,
                                        child: Image(
                                          image: NetworkImage(
                                              homePageResponse['DATA']
                                                      ['popular_contents']
                                                  [index]['content_image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homePageResponse['DATA']
                                                        ['popular_contents']
                                                    [index]['slug'],
                                                style: TextStyle(
                                                    fontSize: mediaQueryData
                                                                    .orientation ==
                                                                Orientation
                                                                    .landscape &&
                                                            data.size
                                                                    .shortestSide <
                                                                600
                                                        ? 10.0
                                                        : 10.0.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: WidgetColors
                                                        .primaryColor),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Text(
                                                homePageResponse['DATA']
                                                        ['popular_contents']
                                                    [index]['title'],
                                                style: TextStyle(
                                                    fontSize: mediaQueryData
                                                                    .orientation ==
                                                                Orientation
                                                                    .landscape &&
                                                            data.size
                                                                    .shortestSide <
                                                                600
                                                        ? 10.0
                                                        : 10.0.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      HomeCalanderIcon
                                                          .home_calender,
                                                      color: Colors.grey,
                                                      size: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0.w,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      '25-06-2020',
                                                      // homePageResponse['DATA']
                                                      //         ['popular_contents']
                                                      //     [index]['date'],
                                                      style: TextStyle(
                                                          fontSize: mediaQueryData
                                                                          .orientation ==
                                                                      Orientation
                                                                          .landscape &&
                                                                  data.size
                                                                          .shortestSide <
                                                                      600
                                                              ? 10.0
                                                              : 10.0.sp,
                                                          color: Colors.grey),
                                                    ))
                                                  ],
                                                ),
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget topStoriesSection() {
    return data.size.shortestSide < 600
        ? Container(
            padding: EdgeInsets.only(left: 18.0),
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          width: 3.0.w,
                          height: 20.0.h,
                          child: VerticalDivider(
                            thickness: 2.0.w,
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
                                        ? 16.0
                                        : 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TopStorieslisting()));
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                color: WidgetColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            homePageResponse['DATA']['top_stories'].length,
                            (index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopStoriesdetails(
                                        magazineId: homePageResponse['DATA']
                                            ['top_stories'][index]['id']))),
                            child: Container(
                              width: 220.0,
                              height: 240.0,
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
                                              homePageResponse['DATA']
                                                      ['top_stories'][index]
                                                  ['content_image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              homePageResponse['DATA']
                                                      ['top_stories'][index]
                                                  ['slug'],
                                              style: TextStyle(
                                                  fontSize: mediaQueryData
                                                                  .orientation ==
                                                              Orientation
                                                                  .landscape &&
                                                          data.size
                                                                  .shortestSide <
                                                              600
                                                      ? 10.0
                                                      : 10.0.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: WidgetColors
                                                      .primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: 2.0.h,
                                            ),
                                            Text(
                                              homePageResponse['DATA']
                                                      ['top_stories'][index]
                                                  ['title'],
                                              style: TextStyle(
                                                  fontSize: mediaQueryData
                                                                  .orientation ==
                                                              Orientation
                                                                  .landscape &&
                                                          data.size
                                                                  .shortestSide <
                                                              600
                                                      ? 10.0
                                                      : 10.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: 5.0.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    HomeCalanderIcon
                                                        .home_calender,
                                                    color: Colors.grey,
                                                    size: 10.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0.w,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    '25-09-2020',
                                                    // homePageResponse['DATA']
                                                    //         ['top_stories'][index]
                                                    //     ['date'],
                                                    style: TextStyle(
                                                        fontSize: mediaQueryData
                                                                        .orientation ==
                                                                    Orientation
                                                                        .landscape &&
                                                                data.size
                                                                        .shortestSide <
                                                                    600
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
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(left: 18.0),
            height: mediaQueryData.orientation == Orientation.landscape
                ? 210.h
                : 190.0.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          width: 3.0.w,
                          height: 20.0.h,
                          child: VerticalDivider(
                            thickness: 2.0.w,
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
                                        ? 16.0
                                        : 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TopStorieslisting())),
                              child: Icon(
                                Icons.arrow_forward,
                                color: WidgetColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            homePageResponse['DATA']['top_stories'].length,
                            (index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopStoriesdetails(
                                          magazineId: homePageResponse['DATA']
                                              ['top_stories'][index]['id'],
                                        ))),
                            child: Container(
                              width: 220.0,
                              height: 260.0,
                              child: Card(
                                elevation: 2.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 220 / 128,
                                        child: Image(
                                          image: NetworkImage(
                                              homePageResponse['DATA']
                                                      ['top_stories'][index]
                                                  ['content_image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homePageResponse['DATA']
                                                        ['top_stories'][index]
                                                    ['slug'],
                                                style: TextStyle(
                                                    fontSize: mediaQueryData
                                                                    .orientation ==
                                                                Orientation
                                                                    .landscape &&
                                                            data.size
                                                                    .shortestSide <
                                                                600
                                                        ? 10.0
                                                        : 10.0.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: WidgetColors
                                                        .primaryColor),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Text(
                                                homePageResponse['DATA']
                                                        ['top_stories'][index]
                                                    ['title'],
                                                style: TextStyle(
                                                    fontSize: mediaQueryData
                                                                    .orientation ==
                                                                Orientation
                                                                    .landscape &&
                                                            data.size
                                                                    .shortestSide <
                                                                600
                                                        ? 10.0
                                                        : 10.0.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      HomeCalanderIcon
                                                          .home_calender,
                                                      color: Colors.grey,
                                                      size: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0.w,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      '25-05-2020',
                                                      // homePageResponse['DATA']
                                                      //         ['top_stories']
                                                      //     [index]['date'],
                                                      style: TextStyle(
                                                          fontSize: mediaQueryData
                                                                          .orientation ==
                                                                      Orientation
                                                                          .landscape &&
                                                                  data.size
                                                                          .shortestSide <
                                                                      600
                                                              ? 10.0
                                                              : 10.0.sp,
                                                          color: Colors.grey),
                                                    ))
                                                  ],
                                                ),
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget videoSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                        thickness: 2.0.w, color: WidgetColors.primaryColor)),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Videos',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16.0
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Videoslisting())),
                        child: Icon(
                          Icons.arrow_forward,
                          color: WidgetColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.only(left: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      homePageResponse['DATA']['videos'].length, (index) {
                    return Container(
                      height: 120.0,
                      width: 148.0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            playVideo = true;
                            videoId = homePageResponse['DATA']['videos'][index]
                                    ["video_link"]
                                .split("=")
                                .last;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image(
                                        //height: 112.0,
                                        width: 148.0,
                                        image: NetworkImage(
                                            homePageResponse['DATA']['videos']
                                                [index]["thumbnail_image"]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      //bottom: 0.0,
                                      child: Container(
                                          height: 30.0,
                                          child: new Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                homePageResponse['DATA']['videos'][index]
                                    ['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: mediaQueryData.orientation ==
                                                Orientation.landscape &&
                                            data.size.shortestSide < 600
                                        ? 10.0
                                        : 10.0.sp),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget gallerySection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                      thickness: 2.0.w,
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
                          'Gallery',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16.0
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Gallerylisting())),
                        child: Icon(
                          Icons.arrow_forward,
                          color: WidgetColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      homePageResponse['DATA']['galleries'].length, (index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  width: 106.0,
                                  height: 116.0,
                                  image: NetworkImage(homePageResponse['DATA']
                                      ['galleries'][index]['image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget podcastSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      height: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                      thickness: 2.0.w,
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
                          'Podcasts',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16.0
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Podcastlisting())),
                        child: Icon(
                          Icons.arrow_forward,
                          color: WidgetColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      homePageResponse['DATA']['podcasts'].length, (index) {
                    return Card(
                      child: Container(
                        width: 162.0,
                        //height: 62.0,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // child:   VideoItems(
                                //   autoplay: false,
                                //   looping: true,
                                //   videoPlayerController:
                                //       VideoPlayerController.network(
                                //           'https://www.youtube.com/watch?v=LXb3EKWsInQ'),
                                // ),
                                Container(
                                  width: 62.0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image(
                                          width: 62.0,
                                          height: 62.0,
                                          image: NetworkImage(
                                              homePageResponse['DATA']
                                                      ['podcasts'][index]
                                                  ['thumbnail_image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        //bottom: 0.0,
                                        child: Container(
                                            height: 30.0,
                                            child: new IconButton(
                                                icon: Icon(
                                                  _selectedIndex == index &&
                                                          isPlaying
                                                      ? Icons
                                                          .pause_circle_filled
                                                      : Icons.play_circle_fill,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  getAudio(index);
                                                })),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(
                                  child: Container(
                                    // width: 50.0,
                                    child: Text(
                                      homePageResponse['DATA']['podcasts']
                                          [index]['title'],
                                      style: TextStyle(
                                          fontSize: mediaQueryData
                                                          .orientation ==
                                                      Orientation.landscape &&
                                                  data.size.shortestSide < 600
                                              ? 8.0
                                              : 8.0.sp,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget instaSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                      thickness: 2.0.w,
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
                          'Instagram',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16.0
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: WidgetColors.primaryColor,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(instaImages.length, (index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  width: 106.0,
                                  height: 116.0,
                                  image: AssetImage(instaImages[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget popularSection() {
    return Container(
      padding: EdgeInsets.only(left: 18.0),
      // height: 220.0,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 3.0.w,
                    height: 20.0.h,
                    child: VerticalDivider(
                        thickness: 2.0.w, color: WidgetColors.primaryColor)),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Popular Categories',
                          style: TextStyle(
                              fontSize: mediaQueryData.orientation ==
                                          Orientation.landscape &&
                                      data.size.shortestSide < 600
                                  ? 16.0
                                  : 16.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categorieslisting())),
                        child: Icon(
                          Icons.arrow_forward,
                          color: WidgetColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 0.0, right: 8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homePageResponse['DATA']['categories'].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: data.size.shortestSide < 600 ? 3 : 4,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesDetails(
                                    categoryId: homePageResponse['DATA']
                                        ['categories'][index]['id'],
                                    categoryName: homePageResponse['DATA']
                                        ['categories'][index]['name'],
                                  ))),
                      child: Container(
                        height: 62.0,
                        width: 106.0,
                        child: Card(
                          elevation: 1.0,
                          color: popularCategoryTextCardColors[index],
                          child: Center(
                            child: Text(
                              homePageResponse['DATA']['categories'][index]
                                  ['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mediaQueryData.orientation ==
                                              Orientation.landscape &&
                                          data.size.shortestSide < 600
                                      ? 13.0
                                      : 13.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  getAudio(int index) async {
    _onSelected(index);
    var audioUrl = homePageResponse['DATA']['podcasts'][index]['podcast_file'];
    print(audioUrl);

    if (isPlaying) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else {
      var res = await audioPlayer.play(audioUrl);
      if (res == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

//API call
  Future _getDataForHomePage() async {
    String baseurl = "http://gcgl.dci.in/public/api/";
    String parameterurl = "customer/home";

    var response = await http.get(Uri.parse(baseurl + parameterurl), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9nY2dsLmRjaS5pblwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjM0NzA0MzQ0LCJleHAiOjE2MzczMzIzNDQsIm5iZiI6MTYzNDcwNDM0NCwianRpIjoiWG1ZcEZIVTZZc0ZLZ1JySSIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.RmgRt_HtakUMMKI4Rj2-b2bcKiYGMdyBNEtJXDzD4hc',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    homePageResponse = json.decode(response.body);

    if (homePageResponse['STATUS'] == 200) {
      print('data fetched successfully');
    } else
      print(homePageResponse['MESSAGE']);
  }
}
