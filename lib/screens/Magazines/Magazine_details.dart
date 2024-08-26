import 'dart:convert';
import 'dart:io';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:graphics_news/Assets/about_icon_icons.dart';
import 'package:graphics_news/Assets/bookmark_icon_icons.dart';
import 'package:graphics_news/common_widget/detailProvider.dart';
import 'package:graphics_news/screens/Magazines/pdf_view.dart';
import 'package:http/http.dart' as http;
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
import 'package:graphics_news/Assets/about_icon_icons.dart';
import 'package:graphics_news/Assets/contact_icon_icons.dart';
import 'package:graphics_news/Assets/f_a_q_icon_icons.dart';
import 'package:graphics_news/Assets/home_calander_icon_icons.dart';
import 'package:graphics_news/Assets/setting_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/common_widget/common_app_bar.dart';
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
import 'package:graphics_news/screens/Settings/Settings.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'epub_view.dart';

class Magazine_details extends StatefulWidget {
  final int? magazineId;

  const Magazine_details({Key? key, this.magazineId}) : super(key: key);

  @override
  _Magazine_detailsState createState() => _Magazine_detailsState();
}

class _Magazine_detailsState extends State<Magazine_details> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List carouselImages = [
    'images/clip_one.png',
    'images/clip_two.png',
    'images/clip_three.png',
    'images/clip_four.png',
    'images/clip_five.png',
    'images/clip_six.png',
  ];
  var token;
  dynamic mediaQueryData;
  int bottomNavigationSelectedIndex = 0;
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  Future? myFuture;
  Future? myFuturePdf;

  Future getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = Future.wait([_getDataForMagazineDetailPage(), getSharedPref()]);
    myFuturePdf =
        Future.wait([_getDataForNewspaperPDPEPUBPage(), getSharedPref()]);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    debugPrint("${widget.magazineId}");
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
      body: Consumer<DetailsProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return FutureBuilder(
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
                                      magazineCard(),
                                      SizedBox(
                                        height: 18.0,
                                      ),
                                      textContainer(),
                                      SizedBox(
                                        height: 26.0,
                                      ),
                                      if (magazinePDFResponse['DATA']
                                              ['file_type'] ==
                                          "pdf")
                                        Column(
                                          children: [
                                            readButton(),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            downloadButton(),
                                            SizedBox(
                                              height: 34.0,
                                            ),
                                          ],
                                        ),
                                      if (magazinePDFResponse['DATA']
                                              ['file_type'] ==
                                          "epub")
                                        Column(
                                          children: [
                                            _buildDownloadReadButton(
                                                value, context),
                                            SizedBox(
                                              height: 34.0,
                                            ),
                                          ],
                                        ),
                                      relatedNewsSection(),
                                      SizedBox(
                                        height: 24.0,
                                      ),
                                      // topStoriesSection(),
                                      // SizedBox(
                                      //   height: 34.0,
                                      // ),
                                      imageSection(),
                                      SizedBox(
                                        height: 34.0,
                                      ),
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
            });
      }),
    );
  }

  openBook(DetailsProvider provider) async {
    List dlList = await provider.getDownload();
    if (dlList.isNotEmpty) {
      // dlList is a list of the downloads relating to this Book's id.
      // The list will only contain one item since we can only
      // download a book once. Then we use `dlList[0]` to choose the
      // first value from the string as out local book path
      Map dl = dlList[0];
      String path = dl['path'];

      //  List locators = await LocatorDB().getLocator("1");

      EpubViewer.setConfig(
          identifier: 'androidBook',
          themeColor: Colors.grey,
          scrollDirection: EpubScrollDirection.HORIZONTAL,
          enableTts: false,
          allowSharing: true,
          nightMode: false);
      EpubViewer.open(
        path,
        // lastLocation:
        //     locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null
      );
      EpubViewer.locatorStream.listen((event) async {
        // Get locator here
        Map json = jsonDecode(event);
        json['bookId'] = widget.magazineId;
        // Save locator to your database
        // await LocatorDB().update(json);
      });
    }
  }

  _buildDownloadReadButton(DetailsProvider provider, BuildContext context) {
    if (provider.downloaded) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 26.0),
        child: ElevatedButton(
          onPressed: () => openBook(provider),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12.0),
              primary: WidgetColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          child: Text(
            'READ THIS NOW',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 26.0),
        child: ElevatedButton(
          onPressed: () => provider.downloadFile(
            context,
            magazinePDFResponse['DATA']['file'],
            magazineDetailResponse['DATA']['post']['title'],
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12.0),
              primary: WidgetColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          child: Text(
            'DOWNLOAD',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
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

  Widget magazineCard() {
    return Container(
      // height:data.size.shortestSide < 600 ? 950.0 : 600,
      height: mediaQueryData.orientation == Orientation.landscape &&
              data.size.shortestSide < 600
          ? 600
          : data.size.shortestSide > 600 &&
                  mediaQueryData.orientation == Orientation.portrait
              ? 800
              : mediaQueryData.orientation == Orientation.landscape &&
                      data.size.shortestSide > 600
                  ? 800
                  : 400,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: AspectRatio(
                aspectRatio: mediaQueryData.orientation == Orientation.landscape
                    ? 803 / 600
                    : data.size.shortestSide > 600 &&
                            mediaQueryData.orientation == Orientation.portrait
                        ? 223 / 228
                        : 223 / 228,
                //  aspectRatio: data.size.shortestSide < 600 ? 323 / 428: 323 / 320,
                child: Image(
                  image: NetworkImage(
                      magazineDetailResponse['DATA']['post']['cover_image']),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textContainer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              magazineDetailResponse['DATA']['post']['title'],
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              magazineDetailResponse['DATA']['post']
                                  ['short_description'],
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$15.00',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          magazineDetailResponse['DATA']['post']
                              ['published_date'],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Divider(
            thickness: 1.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 26.0),
          child: Text(
            magazineDetailResponse['DATA']['post']['short_description'],
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Widget readButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: ElevatedButton(
        onPressed: () async {
          if (magazinePDFResponse['DATA']['file_type'] == "pdf") {
            _pdfViewerKey.currentState?.openBookmarkView();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfPage(
                          url: magazinePDFResponse['DATA']['file'],
                        )));
          }
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: WidgetColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'READ THIS NOW',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget downloadButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Login()));
        },
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.black, width: 2.0),
            padding: EdgeInsets.all(12.0),
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          "DOWNLOAD",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget relatedNewsSection() {
    return Container(
      padding: EdgeInsets.only(left: 22.0),
      height: 250.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Related Magazines',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                  children: List.generate(
                      magazineDetailResponse['DATA']['related'].length,
                      (index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image(
                                width: 132.0,
                                height: 158.0,
                                image: NetworkImage(
                                    magazineDetailResponse['DATA']['related']
                                        [index]['cover_image']),
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              magazineDetailResponse['DATA']['related'][index]
                                  ['title'],
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w400),
                            )
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

  Widget topStoriesSection() {
    return Container(
      padding: EdgeInsets.only(left: 22.0),
      height: 250.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Top Stories',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                  children: List.generate(
                      magazineDetailResponse['DATA']['top_stories'].length,
                      (index) {
                    return Container(
                      width: 234.0,
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
                                      magazineDetailResponse['DATA']
                                          ['top_stories'][index]['image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      magazineDetailResponse['DATA']
                                          ['top_stories'][index]['category'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.0,
                                          color: WidgetColors.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      magazineDetailResponse['DATA']
                                          ['top_stories'][index]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.0,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            HomeCalanderIcon.home_calender,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            magazineDetailResponse['DATA']
                                                ['top_stories'][index]['date'],
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w400,
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

  Widget imageSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 46.0),
      child: Image(
        image: AssetImage('images/clip_four.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Map<String, dynamic> magazineDetailResponse = Map();
  Map<String, dynamic> magazinePDFResponse = Map();

  Future _getDataForMagazineDetailPage() async {
    String baseurl = "http://gcgl.dci.in/public/api/";
    String parameterurl = "customer/magazines/${widget.magazineId}/view";

    var response = await http.get(Uri.parse(baseurl + parameterurl), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9nY2dsLmRjaS5pblwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjM0NzA0MzQ0LCJleHAiOjE2MzczMzIzNDQsIm5iZiI6MTYzNDcwNDM0NCwianRpIjoiWG1ZcEZIVTZZc0ZLZ1JySSIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.RmgRt_HtakUMMKI4Rj2-b2bcKiYGMdyBNEtJXDzD4hc',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    magazineDetailResponse = json.decode(response.body);
    if (magazineDetailResponse['STATUS'] == 200) {
      print('data fetched successfully');
      //   print(magazineDetailResponse.toString());
    } else
      print(magazineDetailResponse['MESSAGE']);
  }

  Future _getDataForNewspaperPDPEPUBPage() async {
    String baseurl = "http://gcgl.dci.in/public/api/";
    String parameterurl = "customer/magazines/${widget.magazineId}/pdf";

    var response = await http.get(Uri.parse(baseurl + parameterurl), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9nY2dsLmRjaS5pblwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjM0NzA0MzQ0LCJleHAiOjE2MzczMzIzNDQsIm5iZiI6MTYzNDcwNDM0NCwianRpIjoiWG1ZcEZIVTZZc0ZLZ1JySSIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.RmgRt_HtakUMMKI4Rj2-b2bcKiYGMdyBNEtJXDzD4hc',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    magazinePDFResponse = json.decode(response.body);
    if (magazinePDFResponse['STATUS'] == 200) {
      print('data fetched successfully');
      //   print(magazineDetailResponse.toString());
    } else
      print(magazinePDFResponse['MESSAGE']);
  }
}
