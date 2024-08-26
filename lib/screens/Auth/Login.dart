import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphics_news/Assets/customicons_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Auth/ForgotPassword.dart';
import 'package:graphics_news/screens/Auth/Resigter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key1 = GlobalKey();
  bool checkBoxValue = false;

  var username, password;
  var loginOutput;
  bool _isPasswordVisible = false;

  var usernameText = TextEditingController();
  var passwordText = TextEditingController();
  dynamic mediaQueryData;
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            //   height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52.0,
                ),
                logoSection(),
                SizedBox(
                  height: 24.0,
                ),
                loginAccountText(),
                SizedBox(
                  height: 22.0,
                ),
                loginForm(),
                SizedBox(
                  height: 18.0,
                ),
                rememberMeSection(),
                SizedBox(
                  height: 18.0,
                ),
                loginButton(),
                SizedBox(
                  height: 24.0,
                ),
                loginOptionText(),
                SizedBox(
                  height: 10.0,
                ),
                loginOptionsIcons(),
                SizedBox(
                  height: 24.0,
                ),
                signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoSection() {
    return Container(
      width: 104.0,
      height: 104.0,
      child: Image(
        image: AssetImage('images/logo.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget loginAccountText() {
    return Container(
        child: Text(
      'Login to your account',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: mediaQueryData.orientation == Orientation.landscape
            && data.size.shortestSide < 600   ? 17.0
            : 17.0.sp,
      ),
    ));
  }

  Widget loginForm() {
    return Container(
        child: Form(
      key: _key1,
      child: Column(
        children: [
          userNameTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          passwordTextFormField(),
        ],
      ),
    ));
  }

  Widget userNameTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          controller: usernameText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          cursorColor: WidgetColors.primaryColor,
          validator: (input) => input!.isEmpty
              ? 'Enter Username'
              : EmailValidator.validate(input)
                  ? null
                  : 'Invalid Username',
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => username = input,
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 1.0,
            child: TextFormField(
              controller: passwordText,
              keyboardType: TextInputType.visiblePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: _isPasswordVisible ? false : true,
              cursorColor: WidgetColors.primaryColor,
              validator: (input) {
                if (input!.isEmpty) {
                  return 'Enter Password';
                }
                // else if (input.length < 8) {
                //   return 'Password should be atleast of 8 Characters';
                // }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //errorStyle: TextAlignVertical.center,
                //prefixIcon: Icon(Icons.lock, color: Colors.blue, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_isPasswordVisible == true)
                        _isPasswordVisible = false;
                      else {
                        _isPasswordVisible = true;
                      }
                    });
                  },
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: WidgetColors.primaryColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                //
              ),
              onSaved: (input) => password = input,
            )));
  }

  Widget rememberMeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 30.0,
                  padding: EdgeInsets.only(right: 8.0),
                  child: Theme(
                      data: ThemeData(
                        checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Checkbox(
                          activeColor: WidgetColors.primaryColor,
                          value: checkBoxValue,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkBoxValue = newValue!;
                            });
                          }))),
              SizedBox(
                width: 0.0,
              ),
              Text(
                'Remember me',
                style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape
                            && data.size.shortestSide < 600  ? 16.0
                            : 16.0.sp),
              )
            ],
          ),
          Container(
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword())),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    fontSize:
                        mediaQueryData.orientation == Orientation.landscape && data.size.shortestSide < 600
                            ? 16.0
                            : 16.0.sp),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget loginButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {
          _sendToNextScreen(context);
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: WidgetColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'LOGIN',
          style: TextStyle(
            fontSize: mediaQueryData.orientation == Orientation.landscape && data.size.shortestSide < 600
                ? 14.0
                : 14.0.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget loginOptionText() {
    return Container(
        child: Text(
      'Or Login using',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: mediaQueryData.orientation == Orientation.landscape && data.size.shortestSide < 600
            ? 17.0
            : 17.0.sp,
      ),
    ));
  }

  Widget loginOptionsIcons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage('images/Facebook.png'),
            ),
          ),
          SizedBox(
            width: 10.0.w,
          ),
          CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(
                image: AssetImage('images/Twitter.png'),
              )),
          SizedBox(
            width: 10.0.w,
          ),
          CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(
                image: AssetImage('images/Instagram.png'),
              )),
          SizedBox(
            width: 10.0.w,
          ),
          CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(
                image: AssetImage('images/Whatsapp.png'),
              )),
          SizedBox(
            width: 10.0.w,
          ),
        ],
      ),
    );
  }

  Widget signUpButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            padding: EdgeInsets.all(12.0),
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          "Don't have an account? Sign Up",
          style: TextStyle(
            fontSize: mediaQueryData.orientation == Orientation.landscape
                && data.size.shortestSide < 600  ? 14.0
                : 14.0.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _sendToNextScreen(BuildContext context) async {
    if (_key1.currentState!.validate()) {
      _key1.currentState!.save();
      String baseurl = "http://gcgl.dci.in/public/api/";
      String parameterurl = "auth/login";
      var response = await http.post(Uri.parse(baseurl + parameterurl),
          body: json.encode({
            "email": username,
            "password": password,
          }),
          headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvYXBpXC9hdXRoXC9yZWdpc3RlckN1c3RvbWVyIiwiaWF0IjoxNjMwNTAyNTAyLCJleHAiOjE2MzMxMzA1MDIsIm5iZiI6MTYzMDUwMjUwMiwianRpIjoiM0VQRnVhOUh2NGcwc0ozdiIsInN1YiI6NCwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.9tWCWmd2gf_F7FlUPskuxUgnmLWHKeHXuWyGrsESqog',
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      loginOutput = json.decode(response.body);

      if (loginOutput['STATUS'] == 200) {
        print(loginOutput['MESSAGE']);
        if (checkBoxValue == true) {
          final SharedPreferences sharedPreference =
              await SharedPreferences.getInstance();
          sharedPreference.setString(
              'access_token', (loginOutput['DATA']['access_token'].toString()));
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (loginOutput['STATUS'] == 422) {
        print(loginOutput['MESSAGE']);
      } else {
        print('Network Error');
      }
    } else {}
  }
}
