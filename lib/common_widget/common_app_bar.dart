import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Assets/menu_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Auth/Login.dart';

class CommonAppBar {
  static getAppBar(BuildContext context, VoidCallback onTap) {
    return AppBar(
      leadingWidth: 35.0,
      centerTitle: false,
      toolbarHeight: 50.0,
      title: Text(
        'Graphic NewsPlus',
        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.sp),
      ),
      // automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          MenuIcon.hamburger_menu,
          color: Colors.white,
        ),
        onPressed: onTap,
      ),
      backgroundColor: WidgetColors.primaryColor,
      actions: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ))
      ],
    );
  }
}
