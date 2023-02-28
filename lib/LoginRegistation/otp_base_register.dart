import 'dart:async';

import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  final fillColor = Color.fromRGBO(243, 246, 249, 0);
  final borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  bool isLoading = false;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: CommonColor.BLACK_COLOR /* Color.fromRGBO(30, 60, 87, 1)*/,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      border: Border.all(color: CommonColor.RS_COLOR),
    ),
  );

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var code = "";

  bool showOtpField = false;
  bool showGetOtp = true;


  Timer? _timer;
  int _start = 120;


  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CommonColor.APP_BAR_COLOR,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.33,
            child: Column(
              children: [
                getAddMainHeadingLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/appLogo.jpg",
                      ),
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: SizeConfig.screenHeight * 0.64,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              //  color: Colors.white,
              child: getNumberLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth))
        ],
        //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
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
              Navigator.pop(context);
            },
            onDoubleTap: () {},
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
      padding: EdgeInsets.only(top: parentHeight * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Verify Your Mobile Number",
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
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
          ),
          Visibility(
            visible: showGetOtp,
            child: Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.03,
                  left: parentWidth * 0.07,
                  right: parentWidth * 0.07),
              child: GestureDetector(
                onTap: (){
                  if(mounted){
                    setState(() {
                      showGetOtp = !showGetOtp;
                      showOtpField = !showOtpField;
                      startTimer();
                    });
                  }
                },
                child: Container(
                  height: parentHeight * 0.06,
                  width: parentWidth * 0.5,
                  decoration: BoxDecoration(
                      color: CommonColor.APP_BAR_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Get OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: showOtpField,
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight*0.05, left: parentWidth*0.1, right: parentWidth*0.1),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        controller: pinController,
                        focusNode: focusNode,
                        onClipboardFound: (value) {
                          debugPrint('onClipboardFound: $value');
                          pinController.setText(value);
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                          code = value;
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 20,
                              height: parentHeight * 0.002,
                              color: CommonColor.RS_COLOR,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            //  borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: CommonColor.RS_COLOR),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            // color: fillColor,
                            //borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: CommonColor.RS_COLOR),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: CommonColor.RS_COLOR),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: showOtpField,
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight*0.03, left: parentWidth*0.1, right: parentWidth*0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Icon(Icons.message,
                      color: CommonColor.RS_COLOR,
                      size: parentHeight*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: parentHeight*0.005, left: parentWidth*0.01),
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  color: CommonColor.RS_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                  fontFamily: 'Roboto_Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Visibility(
                    visible: _start != 0 ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: parentHeight*0.005),
                      child: Text("$_start S",
                        style: TextStyle(
                            color: CommonColor.RS_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            fontFamily: 'Roboto_Regular',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Visibility(
            visible: showOtpField,
            child: Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.03,
                  left: parentWidth * 0.07,
                  right: parentWidth * 0.07),
              child: Container(
                height: parentHeight * 0.06,
                width: parentWidth * 0.5,
                decoration: BoxDecoration(
                    color: CommonColor.APP_BAR_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
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
}
