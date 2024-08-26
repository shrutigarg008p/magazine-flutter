import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphics_news/Assets/d_o_b_icon_icons.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:graphics_news/screens/Auth/Login.dart';
import 'package:graphics_news/screens/Home/Home_page.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _key1 = GlobalKey();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobText.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        print(dob);
      });
  }

  var fullName, email, phone, dob, password, country;
  var fullNameText = TextEditingController();
  var emailText = TextEditingController();
  var phoneText = TextEditingController();
  var dobText = TextEditingController();
  var passwordText = TextEditingController();
  var registerationUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                  height: 24.0,
                ),
                nextButton(),
                SizedBox(
                  height: 10.0,
                ),
                loginButton(),
                SizedBox(
                  height: 10.0,
                ),
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
      'Create NewsPlus account',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
    ));
  }

  Widget loginForm() {
    return Container(
        child: Form(
      key: _key1,
      child: Column(
        children: [
          fullNameTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          emailTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          phoneTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          dobTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          passwordTextFormField(),
          SizedBox(
            height: 10.0,
          ),
          countryTextFormField()
        ],
      ),
    ));
  }

  Widget fullNameTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          controller: fullNameText,
          keyboardType: TextInputType.name,
          cursorColor: WidgetColors.primaryColor,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (input) => input!.isEmpty ? 'Enter FullName' : null,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: "Full Name",
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => fullName = input,
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          controller: emailText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          cursorColor: WidgetColors.primaryColor,
          validator: (input) => input!.isEmpty
              ? 'Enter email'
              : EmailValidator.validate(input)
                  ? null
                  : 'Invalid Email',
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => email = input,
        ),
      ),
    );
  }

  Widget phoneTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          controller: phoneText,
          inputFormatters: [new LengthLimitingTextInputFormatter(12)],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.phone,
          cursorColor: WidgetColors.primaryColor,
          validator: (input) => input!.isEmpty
              ? 'Enter Phone'
              : (input.length < 3 && input.isNotEmpty)
                  ? 'Phone too short'
                  : (input.length < 10 && input.isNotEmpty)
                      ? 'Invalid Phone'
                      : null,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: "Phone",
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => phone = input,
        ),
      ),
    );
  }

  Widget dobTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
          keyboardType: TextInputType.datetime,
          cursorColor: WidgetColors.primaryColor,
          controller: dobText,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //errorStyle: TextAlignVertical.center,
            //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
            hintText: "Date of Birth",
            suffixIcon: IconButton(
              icon: Icon(
                DOBIcon.date_of_birth_calender,
                color: Colors.grey,
              ),
              onPressed: () {
                //_selectDate(context);
              },
            ),

            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => dob = input,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              obscureText: true,
              cursorColor: WidgetColors.primaryColor,
              validator: (input) {
                if (input!.isEmpty) {
                  return 'Enter Password';
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: WidgetColors.primaryColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // onSaved: (input) => password = input),
              ),
              onSaved: (input) => password = input,
            )));
  }

  Widget countryTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: TextFormField(
          //inputFormatters: [new LengthLimitingTextInputFormatter(10)],
          keyboardType: TextInputType.name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: WidgetColors.primaryColor,
          validator: (input) => input!.isEmpty
              ? 'Enter Country'
              // : (input.length < 3 && input.isNotEmpty)
              //     ? 'Username too short'
              //     : (input.length < 10 && input.isNotEmpty)
              //         ? 'Invalid Username'
              : null,
          // if (input == null || input.length < ) {
          //   return 'Enter Phone';
          // }

          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            suffixIcon: IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                CountryListPick(
                  theme: CountryTheme(
                    isShowFlag: false,
                    isShowTitle: true,
                    isShowCode: false,
                  ),
                );
              },
            ),
            //errorStyle: TextAlignVertical.center,
            //prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 20),
            hintText: "Select Country",
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WidgetColors.primaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (input) => country = input,
        ),
      ),
    );
  }

  Widget nextButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {
          showAlertDialog(context);
          sendToNextScreen(context);
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            primary: WidgetColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          'ENJOY',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.black, width: 2.0),
            padding: EdgeInsets.all(12.0),
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        child: Text(
          "Existing User? Login",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future sendToNextScreen(BuildContext context) async {
    if (_key1.currentState!.validate()) {
      _key1.currentState!.save();

      String baseurl = "http://gcgl.dci.in/public/api/";
      String parameterurl = "auth/registerCustomer";
      var response = await http.post(Uri.parse(baseurl + parameterurl),
          body: json.encode({
            "name": fullName,
            "email": email,
            "password": password,
            "phone": phone,
            "dob": dob,
            "country": country
          }),
          headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvYXBpXC9hdXRoXC9yZWdpc3RlckN1c3RvbWVyIiwiaWF0IjoxNjMwNTAyNTAyLCJleHAiOjE2MzMxMzA1MDIsIm5iZiI6MTYzMDUwMjUwMiwianRpIjoiM0VQRnVhOUh2NGcwc0ozdiIsInN1YiI6NCwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.9tWCWmd2gf_F7FlUPskuxUgnmLWHKeHXuWyGrsESqog',
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      registerationUserData = json.decode(response.body);

      if (registerationUserData['STATUS'] == 200) {
        print(registerationUserData['MESSAGE']);
        final SharedPreferences sharedPreference =
            await SharedPreferences.getInstance();
        sharedPreference.setString('access_token',
            (registerationUserData['DATA']['access_token'].toString()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (registerationUserData['STATUS'] == 422) {
        print(registerationUserData['MESSAGE']);
      } else {
        print('Network Error');
      }
    } else {}
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: CircularProgressIndicator(
              color: WidgetColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
              child:
                  Text('Please wait while we are validating your credentials'))
        ],
      ),
      actions: [
        //okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
