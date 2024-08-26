import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          // Positioned(
          //   bottom: 0.0,
          //   child: Container(
          //     decoration: BoxDecoration(color: Colors.green),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Padding(
          //           padding: EdgeInsets.only(bottom: 30.0),
          //           child: new Text("Graphic NewsPlus"),
          //           // child: new Image.asset(
          //           //   'assets/images/powered_by.png',
          //           //   height: 25.0,
          //           //   fit: BoxFit.scaleDown,
          //           // )
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/splashscreenbackground.png'),
                    fit: BoxFit.fill)),
            //color: WidgetColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'images/logo.png',
                  width: 150.0,
                  height: 150.0,
                  //width: animation.value * 250,
                  //height: animation.value * 250,
                ),
              ],
            ),
          ),

          Positioned(
            //bottom: 0.0,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Graphic NewsPlus',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// return Scaffold(
//     body: Container(
//   decoration: BoxDecoration(
//       image: DecorationImage(
//           image: AssetImage('images/splashscreenbackground.png'))),
//   //color: WidgetColors.primaryColor,
//   child:
//       Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
//     //   Container(
//     //     width: double.infinity,
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         new Image.asset(
//     //           'images/logo.png',
//     //           //width: animation.value * 250,
//     //           //height: animation.value * 250,
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     //   Positioned(
//     //     //bottom: 0.0,
//     //     child: Container(
//     //       margin: EdgeInsets.all(8.0),
//     //       child: Column(
//     //         mainAxisAlignment: MainAxisAlignment.end,
//     //         children: [
//     //           Padding(
//     //             padding: const EdgeInsets.only(bottom: 30.0),
//     //             child: Text(
//     //               'Graphic NewsPlus',
//     //               style: TextStyle(
//     //                   fontWeight: FontWeight.w500,
//     //                   color: Colors.white,
//     //                   fontSize: 20.0),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   )
//     // ],
//   ]),

// body: Stack(
//   alignment: Alignment.center,
//   fit: StackFit.expand,
//   children: <Widget>[
//     // Positioned(
//     //   bottom: 0.0,
//     //   child: Container(
//     //     decoration: BoxDecoration(color: Colors.green),
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.end,
//     //       mainAxisSize: MainAxisSize.min,
//     //       children: <Widget>[
//     //         Padding(
//     //           padding: EdgeInsets.only(bottom: 30.0),
//     //           child: new Text("Graphic NewsPlus"),
//     //           // child: new Image.asset(
//     //           //   'assets/images/powered_by.png',
//     //           //   height: 25.0,
//     //           //   fit: BoxFit.scaleDown,
//     //           // )
//     //         )
//     //       ],
//     //     ),
//     //   ),
//     // ),
//     Container(
//       color: WidgetColors.primaryColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         //crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           new Image.asset(
//             'assets/images/logo.png',
//             width: animation.value * 250,
//             height: animation.value * 250,
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
