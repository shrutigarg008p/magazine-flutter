import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Settings/Account.dart';

import 'Refer_friend.dart';
import 'Subsciption.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  int activeIndex = 2;
  List settingsTile = [
    'My Account',
    'My Subscription',
    'My Downloads',
    'Refer a Friend',
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
  dynamic mediaQueryData;
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30.0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: WidgetColors.primaryColor,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: mediaQueryData.orientation == Orientation.landscape &&
                    data.size.shortestSide < 600
                ? 17.0
                : 17.0.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Divider(
                      thickness: 1.6,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    settingsListTile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    myDownloadsText(),
                    SizedBox(
                      height: 10.0,
                    ),
                    magazineList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsListTile() {
    return Container(
      margin: EdgeInsets.only(left: 17.0),
      height: 38.0,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Account()));
                            break;
                          case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Subscription()));
                            break;
                          case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Downloads()));
                            break;
                          case 3:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Refer_friend()));
                            break;
                        }
                        // activeIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 36.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: activeIndex == index
                              ? WidgetColors.primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          settingsTile[index],
                          style: TextStyle(
                              fontSize: 13.0,
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

  Widget myDownloadsText() {
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
                    'My Downloads',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget magazineList() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: magazineImages.length,
            itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            width: 134.0,
                            height: 164.0,
                            image: AssetImage(magazineImages[index]),
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Foreign hawks lands',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$15.00',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 13.0,
                                ),
                                readButton(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.6,
                        color: Colors.grey[300],
                      )
                    ],
                  ),
                )));
  }

  Widget readButton() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Account()));
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
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
}
