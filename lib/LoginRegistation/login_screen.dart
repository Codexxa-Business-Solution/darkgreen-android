import 'dart:convert';
import 'package:darkgreen/LoginRegistation/otp_base_register.dart';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/login/login_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _oldPasswordFocus = FocusNode();

  bool oldPaswordShow = true;

  int cartCount = 0;

  void _toggle() {
    setState(() {
      oldPaswordShow = !oldPaswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: SizeConfig.screenHeight * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),),
          Container(
              height: SizeConfig.screenHeight * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              //  color: Colors.white,
              child: getNumberLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
        ],
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
            },
            
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * .04),
              child: Container(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: parentHeight * .030,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.07),
            child: Text(
              "Aayshaaa",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.transparent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * .04),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.arrow_back_outlined,
                size: parentHeight * .03,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getNumberLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Welcome to Darkgreen",
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                fontFamily: 'Roboto_Medium',
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.03,
                left: parentWidth * 0.1,
                right: parentWidth * 0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              controller: numberController,
              decoration: InputDecoration(
                labelText: "Mobile No.",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: const Icon(
                  Icons.phone_android_rounded,
                  color: Colors.black,
                ),
                focusedBorder: const UnderlineInputBorder(
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
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  suffixIcon: oldPaswordShow
                      ? GestureDetector(
                          
                          onTap: () {
                            _toggle();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: const Icon(
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
                              child: const Image(
                                image:
                                    AssetImage("assets/images/close-eye.png"),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
              obscureText: oldPaswordShow,
              focusNode: _oldPasswordFocus,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.03,
                left: parentWidth * 0.07,
                right: parentWidth * 0.07),
            child: GestureDetector(
              
              onTap: () {
                userLogin();
              },
              child: Container(
                height: parentHeight * 0.06,
                width: parentWidth * 0.7,
                decoration: BoxDecoration(
                    color: CommonColor.APP_BAR_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Log In",
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
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.03,
                left: parentWidth * 0.07,
                right: parentWidth * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          fontFamily: 'Roboto_Regular',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.03,
                left: parentWidth * 0.07,
                right: parentWidth * 0.07),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));

                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: true,
                    builder: (BuildContext bc) {
                      return const RegisterScreen();
                    });
              },
              child: Container(
                height: parentHeight * 0.06,
                width: parentWidth * 0.7,
                decoration: BoxDecoration(
                    color: CommonColor.CIRCLE_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: CommonColor.APP_BAR_COLOR,
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

  Future<UserLoginResponseModel> userLogin() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().usersLogin),
        body: {
          "accesskey": ApiConstants().accessKey,
          "mobile": numberController.text.trim(),
          "password": passwordController.text,
          "login":"1"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("loginResponse -->  ${body}");

      if (jsonData["message"] == "Successfully logged in!") {

        AppPreferences.setIds(jsonData["user_id"]);

        AppPreferences.setUserName(jsonData["name"]);

        print(AppPreferences.setUserName(jsonData["name"]));
        print( AppPreferences.setIds(jsonData["user_id"]));

        if(mounted){
          setState(() {
            AllCommonApis().getAllCarts().then((value){
              cartCount = value.data.length;
              print(cartCount);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard(cartCount: cartCount, comeFrom: "1",)));
            });
          });
        }



      }



      return userLoginResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
