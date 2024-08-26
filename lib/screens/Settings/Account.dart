import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Settings/Downloads.dart';
import 'package:graphics_news/screens/Settings/Refer_friend.dart';
import 'package:graphics_news/screens/Settings/Subsciption.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int activeIndex = 0;
  List settingsTile = [
    'My Account',
    'My Subscription',
    'My Downloads',
    'Refer a Friend',
  ];
  List accountListHeadings = [
    'Name',
    'Email',
    'Night Mode',
    'Font Size',
    'Change Password',
  ];

  List accountListOutputs = [
    'Chris',
    'chris@gmail.com',
    'Light',
    'M',
    '*********',
  ];

  List prefsListHeadings = [
    'Education',
    'Health',
    'Entertainment',
    'Lifestyle',
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
                      height: 12.0,
                    ),
                    myAccountText(),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    myAccountList(),
                    myPreferencesText(),
                    myPreferencesList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    downloadButton(),
                    SizedBox(
                      height: 15.0,
                    ),

                    // magazineList(),
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
                        height: 46.0,
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

  Widget myAccountText() {
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
                    'My Account',
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

  Widget myAccountList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: accountListOutputs.length,
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
                  accountListHeadings[index],
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
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  accountListOutputs[index],
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

  Widget myPreferencesText() {
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
                    'Preferences',
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

  Widget myPreferencesList() {
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
                            : 14.0.sp,
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
                    Icons.check_box_outlined,
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

  Widget downloadButton() {
    return Container(
      width: double.infinity,
      height: 50.0,
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
          "LOG OUT",
          style: TextStyle(
            fontSize: mediaQueryData.orientation == Orientation.landscape &&
                    data.size.shortestSide < 600
                ? 14.0
                : 14.0.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
