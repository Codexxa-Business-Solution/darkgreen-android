import 'dart:convert';

import 'package:darkgreen/api_model/register/personal_details_response_model.dart';
import 'package:darkgreen/api_model/register/register_request_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonalInfo extends StatefulWidget {

  final String userNumber;

  const PersonalInfo({Key? key, required this.userNumber}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {



  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();



  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool paswordShow = true;
  bool confirmPasswordShow = true;
  bool isChecked = false;

  void _toggle() {
    setState(() {
      paswordShow = !paswordShow;
    });
  }

  void _toggles() {
    setState(() {
      confirmPasswordShow = !confirmPasswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: CommonColor.APP_BAR_COLOR,
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.36),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                    height: SizeConfig.screenHeight * 0.64,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    //  color: Colors.white,
                    child: getDetailsLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth))
              ],
              //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
            ),
          ),
        ),
      ],
    );
  }

  Widget getDetailsLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: parentWidth * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Personal Info",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.1, top: parentHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "+91 ${widget.userNumber}",
                  style: TextStyle(
                      color: CommonColor.APP_BAR_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.005,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w500,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  suffixIcon: paswordShow
                      ? GestureDetector(
                          
                          onTap: () {
                            _toggle();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.01),
                          child: GestureDetector(
                            
                            onTap: () {
                              _toggle();
                            },
                            child: Container(
                              // color: Colors.red,
                              child: Image(
                                image:
                                    AssetImage("assets/images/close-eye.png"),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
              obscureText: paswordShow,
              focusNode: _passwordFocus,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: conPasswordController,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w500,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  suffixIcon: confirmPasswordShow
                      ? GestureDetector(
                          
                          onTap: () {
                            _toggles();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.01),
                          child: GestureDetector(
                            
                            onTap: () {
                              _toggles();
                            },
                            child: Container(
                              // color: Colors.red,
                              child: Image(
                                image:
                                    AssetImage("assets/images/close-eye.png"),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
              obscureText: confirmPasswordShow,
              focusNode: _confirmPasswordFocus,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: referralCodeController,
              decoration: InputDecoration(
                labelText: "Referral Code (optional)",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.04, top: parentHeight * 0.02),
            child: Row(
              children: [
                Container(
                  height: parentHeight * 0.07,
                  width: parentWidth * 0.069,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 0,
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        activeColor: CommonColor.APP_BAR_COLOR,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            print(isChecked);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.03),
                      child: RichText(
                          text: const TextSpan(
                              text: "I have read and agree to the",
                              style: TextStyle(
                                  color: CommonColor.BLACK_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 14),
                              children: [
                            TextSpan(
                                text: " Privacy Policy ",
                                style: TextStyle(
                                    color: CommonColor.APP_BAR_COLOR,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 14)),
                            TextSpan(
                                text: "and\n",
                                style: TextStyle(
                                    color: CommonColor.BLACK_COLOR,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 13)),
                            TextSpan(
                              text: "Terms of Conditions.\n",
                              style: TextStyle(
                                  color: CommonColor.APP_BAR_COLOR,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 14),
                            )
                          ])),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.0,
                left: parentWidth * 0.07,
                right: parentWidth * 0.07),
            child: GestureDetector(
              
              onTap: () {

                if(nameController.text.isNotEmpty){
                  if(emailController.text.isNotEmpty){
                    if(passwordController.text.isNotEmpty && conPasswordController.text.length > 6){
                      if(conPasswordController.text.isNotEmpty && conPasswordController.text.length > 6){
                        if(isChecked == true){
                          userDetailsRegister();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              content: Text("Please Check Privacy Policy and Terms & Conditions")));
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text("Please Enter 6 digit Password")));
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          content: Text("Please Enter 6 digit Password")));
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                        content: Text("Please Enter Valid Email")));
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                      content: Text("Please Enter Name")));
                }


              },
              child: Container(
                height: parentHeight * 0.06,
                width: parentWidth * 0.7,
                decoration: BoxDecoration(
                    color: CommonColor.APP_BAR_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<UserPersonalDetailsResponseModel> userDetailsRegister() async {
  //
  //   var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};
  //
  //   print(nameController.text.trim());
  //   print(emailController.text.trim());
  //   print(passwordController.text.trim());
  //
  //   var response = await http.post(
  //       Uri.parse(ApiConstants().baseUrl+ApiConstants().usersRegister),
  //       body: {
  //         "accesskey" : ApiConstants().accessKey,
  //         "type" : "register",
  //         "name" :  nameController.text,
  //         "email" : emailController.text,
  //         "password" : passwordController.text,
  //         "referral_code" : referralCodeController.text.trim()??"",
  //       },
  //       headers: headersList
  //   );
  //
  //
  //
  //   if (response.statusCode == 200) {
  //
  //     print("Yess.. ${response.body}");
  //
  //     // if(mounted){
  //     //   setState(() {
  //     //     ScaffoldMessenger.of(context).showSnackBar( SnackBar(
  //     //         content: Text("${response.body}")));
  //     //   });
  //     // }
  //
  //     print("Hiii");
  //
  //     return userPersonalDetailsResponseModelFromJson(response.body);
  //   } else {
  //     throw Exception('Failed to create album.');
  //   }
  // }


  Future<UserPersonalDetailsResponseModel> userDetailsRegister() async {

    try {

      print(nameController.text.trim());
      print(emailController.text.trim());
      print(passwordController.text.trim());

      var headers = {
        'Authorization': 'Bearer ${ApiConstants().token}'
      };


      final result = await http.post(
        Uri.parse(ApiConstants().baseUrl+ApiConstants().usersRegister),
        headers: headers,
        body: {
          "accesskey" : ApiConstants().accessKey,
          "type" : "register",
          "name" :  nameController.text.trim(),
          "email" : emailController.text.trim(),
          "password" : passwordController.text.trim(),
          "referral_code" : referralCodeController.text.trim()??"",
        },
      );

      if (result.statusCode == 200) {
        print(result.body);
        setState(() {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("Notice Successfully Deleted.")));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(come: "1",)));
        });
      }

      return userPersonalDetailsResponseModelFromJson(json.decode(result.body));
      } catch (e) {
      throw e;
    }
  }
}
