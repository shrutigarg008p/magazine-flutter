import 'package:flutter/material.dart';
import 'package:graphics_news/Assets/f_a_q_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:graphics_news/screens/Information%20Screens/About_us.dart';
import 'package:graphics_news/screens/Information%20Screens/Contact.dart';
import 'package:graphics_news/screens/Information%20Screens/Faq.dart';
import 'package:graphics_news/screens/Settings/Subscription_renewal.dart';

import 'Account.dart';
import 'Downloads.dart';
import 'Refer_friend.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int activeIndex = 1;
  int bottomNavigationSelectedIndex = 0;
  int _groupValue = 0;
  List settingsTile = [
    'My Account',
    'My Subscription',
    'My Downloads',
    'Refer a Friend',
  ];

  List subscriptionListItems = [
    'Subscription Date',
    'Expiry Date',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationDrawer(),
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
            fontSize: 17.0,
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
                      height: 18.0,
                    ),
                    settingsListTile(),
                    SizedBox(
                      height: 18.0,
                    ),
                    yourPlanText(),
                    SizedBox(
                      height: 24.0,
                    ),
                    daySelectionField(),
                    // friendForm(),
                    SizedBox(
                      height: 24.0,
                    ),
                    epaperPackageText(),
                    // submitButton(),

                    SizedBox(
                      height: 26.0,
                    ),
                    radioListButtons(),
                    // socialMediaInviteText(),
                    SizedBox(
                      height: 33.0,
                    ),
                    subscriptionContent(),
                    SizedBox(
                      height: 24.0,
                    ),
                    referalCodeField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    applyButton(),
                    SizedBox(
                      height: 40.0,
                    ),
                    paymentColumn(),
                    SizedBox(
                      height: 24.0,
                    ),
                    payButton(),
                    SizedBox(
                      height: 10.0,
                    ),
                    logoutButton(),
                    SizedBox(
                      height: 20.0,
                    ),

                    notificationText('My Subscription'),
                    dailyGraphicText('Daily Graphic'),
                    Divider(
                      thickness: 1.6,
                      color: Colors.grey[300],
                    ),
                    subscriptionList(),
                    SizedBox(
                      height: 32.0,
                    ),
                    renewButton(),
                    SizedBox(
                      height: 32.0,
                    ),
                    dailyGraphicText('Graphic Sports'),
                    Divider(
                      thickness: 1.6,
                      color: Colors.grey[300],
                    ),
                    subscriptionList(),
                    SizedBox(
                      height: 32.0,
                    ),
                    renewButton(),
                    SizedBox(
                      height: 32.0,
                    ),
                    dailyGraphicText('Graphic Business'),
                    Divider(
                      thickness: 1.6,
                      color: Colors.grey[300],
                    ),
                    subscriptionList(),
                    SizedBox(
                      height: 32.0,
                    ),
                    renewButton(),
                    SizedBox(
                      height: 32.0,
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
              Icons.add_box,
              //color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "SETTINGS",
          icon: InkWell(
            // onTap: () => Navigator.push(
            //     context,
            //     PageRouteBuilder(
            //         pageBuilder: (context, animation1, animation2) =>
            //             Magazine_details())),
            child: Icon(
              Icons.settings,
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
              Icons.contact_page,
            ),
          ),
        ),
      ],
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

  Widget yourPlanText() {
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
                    'YOUR PLAN',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget daySelectionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
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
            suffixIcon: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
            //errorStyle: TextAlignVertical.center,
            //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
            hintText: "1 Day",
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

  Widget epaperPackageText() {
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
                    'Select Epaper Package',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget radioListButtons() {
    return Container(
      //width: double.infinity,
      padding: EdgeInsets.only(left: 35.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200.0,
            child: ListTile(
              minLeadingWidth: 0.0,
              title: Align(
                child: Text(
                  'Bundle',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                alignment: Alignment(-1.5, 0),
              ),
              leading: Radio(
                  value: 0,
                  groupValue: _groupValue,
                  activeColor: WidgetColors.primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _groupValue = val as int;
                    });
                  }),
            ),
          ),
          Container(
            width: 150.0,
            child: ListTile(
              minLeadingWidth: 0.0,
              title: Align(
                child: Text(
                  'Custom',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                alignment: Alignment(-6, 0),
              ),
              leading: Radio(
                  value: 1,
                  groupValue: _groupValue,
                  activeColor: WidgetColors.primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _groupValue = val as int;
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget subscriptionContent() {
    return Container(
      margin: EdgeInsets.only(left: 35.0, right: 35.0),
      //padding: EdgeInsets.symmetric(horizontal: 20.0),

      child: Text(
        "In a milieu that likes to box people and companies into short descriptions,one can define us as a ‘Digital Data Analytics and Consulting Company’. Our fortes include helping brands achieve goals like campaign optimization.",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget referalCodeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
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
            // suffixIcon: IconButton(
            //   icon: Icon(Icons.arrow_drop_down),
            //   onPressed: () {},
            // ),
            //errorStyle: TextAlignVertical.center,
            //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
            hintText: "Referal Code",
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

  Widget applyButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: Colors.grey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'APPLY',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget paymentColumn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Payment Due',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'USD 15.00',
            style: TextStyle(
              color: WidgetColors.primaryColor,
              fontSize: 34.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget payButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Subscription_Renewal()));
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: WidgetColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'PAY NOW',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
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
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
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
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget dailyGraphicText(String name) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: 14.0,
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget subscriptionList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: subscriptionListItems.length,
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
                  subscriptionListItems[index],
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  '19-09-2021',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
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

  Widget renewButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            primary: WidgetColors.renewButtonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'RENEW SUBSCRIPTION',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
