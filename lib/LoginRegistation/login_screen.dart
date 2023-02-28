import 'package:darkgreen/LoginRegistation/otp_base_register.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:flutter/material.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _oldPasswordFocus = FocusNode();

  bool oldPaswordShow = true;

  void _toggle() {
    setState(() {
      oldPaswordShow = !oldPaswordShow;
    });
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
              // Navigator.pop(context);
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

  Widget getNumberLayout(double parentHeight, double parentWidth){
    return Padding(
      padding: EdgeInsets.only(top: parentHeight*0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Text("Welcome to Darkgreen",
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal*5.0,
                fontFamily: 'Roboto_Medium',
                fontWeight: FontWeight.w500
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.03, left: parentWidth*0.1, right: parentWidth*0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
             decoration: InputDecoration(
               labelText: "Mobile No.",
               labelStyle: TextStyle(
                   color: Colors.black,
                   fontSize: SizeConfig.blockSizeHorizontal*4.0,
                   fontFamily: 'Roboto_Regular',
                   fontWeight: FontWeight.w500,
               ),
               prefixIcon: Icon(Icons.phone_android_rounded,
               color: Colors.black,),
               focusedBorder: UnderlineInputBorder(
                 borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
               ),
             ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.01, left: parentWidth*0.1, right: parentWidth*0.1),
            child: TextFormField(
              cursorColor: CommonColor.APP_BAR_COLOR,
              decoration:  InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w500,
                  ),                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CommonColor.APP_BAR_COLOR),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.black,),
                  suffixIcon:oldPaswordShow ? GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      _toggle();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.remove_red_eye,
                        color: Colors.black,),
                    ),
                  ):
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.01),
                    child:  GestureDetector(
                      onDoubleTap: (){},
                      onTap: (){
                        _toggle();
                      },
                      child: Container(
                        // color: Colors.red,
                        child: Image(image: AssetImage("assets/images/close-eye.png"),
                          color: Colors.black,),
                      ),
                    ),
                  )
              ),
              obscureText: oldPaswordShow,
              focusNode: _oldPasswordFocus,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.05, left: parentWidth*0.07, right: parentWidth*0.07),
            child: GestureDetector(
              onDoubleTap: (){},
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              child: Container(
                height: parentHeight*0.06,
                width: parentWidth*0.7,
                decoration: BoxDecoration(
                    color: CommonColor.APP_BAR_COLOR,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal*5.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.05, left: parentWidth*0.07, right: parentWidth*0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onDoubleTap: (){},
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text("Forgot Password ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal*3.5,
                          fontFamily: 'Roboto_Regular',
                          fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.05, left: parentWidth*0.07, right: parentWidth*0.07),
            child: GestureDetector(
              onDoubleTap: (){},
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              },
              child: Container(
                height: parentHeight*0.06,
                width: parentWidth*0.7,
                decoration: BoxDecoration(
                    color: CommonColor.CIRCLE_COLOR,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Sign Up",
                    style: TextStyle(
                        color: CommonColor.APP_BAR_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal*5.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500
                    ),
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
