import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confrimPassword = TextEditingController();
  TextEditingController _ReferralCode = TextEditingController();

  // So all this four controller's is for th_passe textfield we're creating
  var _formKey = GlobalKey<ScaffoldState>(); // a scaffold Globalkey
  bool hidePass = true;
  bool isChecked = false;

  @override
  void initState() {
   _name = TextEditingController();
    _email = TextEditingController();
   _password = TextEditingController();
   _confrimPassword = TextEditingController();
   _ReferralCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confrimPassword.dispose();
    _ReferralCode.dispose();
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
                        "assets/images/appLogo.png",
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
              child: getBottomCode(
                  SizeConfig.screenHeight, SizeConfig.screenWidth))
        ],
        //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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

  Widget getBottomCode(double parentHeight, double parentWidth) {
    return Row(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Padding(
              //   padding: EdgeInsets.only(left: parentHeight * 0.02,top: parentHeight*0.04),
              //   child: Text(
              //     "Personal Info",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.w500,
              //         fontFamily: 'Roboto-bold',
              //         fontSize: 18),
              //   ),
              // ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15,top: 12),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email Field Is Required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only( left: 15, right: 15),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email Field Is Required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          icon: Icon(Icons.local_mall_outlined),
                          labelText: 'Password',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email Field Is Required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: _confrimPassword,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.local_mall_outlined),
                          labelText: 'Confirm password',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email Field Is Required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: _ReferralCode,
                        decoration: InputDecoration(
                          icon: Icon(Icons.radar),
                          labelText: 'Referral Code(optional)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email Field Is Required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),

                  ],

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
                          const SizedBox(height: 0,),
                          Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ],),
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
              GestureDetector(
                onTap: () {

                  // index == 1 ?
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const TenderDrawerScreen())) :
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                },
                
                child: Padding(
                  padding:  EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.04,right: parentWidth*0.04),
                  child: Container(
                      width: parentWidth * 0.77,
                      height: parentHeight * 0.065,
                      decoration: BoxDecoration(
                        color: CommonColor.APP_BAR_COLOR,
                        border: Border.all(
                            width: 1, color: CommonColor.APP_BAR_COLOR), //Border.
                        borderRadius: const BorderRadius.all(
                          Radius.circular(11),
                        ),
                      ),
                      child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto-Regular',
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                          ))),
                ),
              ),// textfield for the name session and so on
              //  SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );

  }





}
