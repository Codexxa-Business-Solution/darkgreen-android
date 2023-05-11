import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _oldPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  double height = 300.0;

  bool oldPaswordShow = true;
  bool newPaswordShow = true;
  bool confirmPaswordShow = true;

  void _toggle() {
    setState(() {
      oldPaswordShow = !oldPaswordShow;
    });
  }

  void _newToggle() {
    setState(() {
      newPaswordShow = !newPaswordShow;
    });
  }

  void _confirmToggle() {
    setState(() {
      confirmPaswordShow = !confirmPaswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          height: SizeConfig.screenHeight * 0.45,
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.03,
                  left: SizeConfig.screenWidth * 0.07,
                  right: SizeConfig.screenWidth * 0.07,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 6.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Old Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: oldPaswordShow
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
                                          image: AssetImage(
                                              "assets/images/close-eye.png"),
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
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'New Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: newPaswordShow
                                ? GestureDetector(
                                    
                                    onTap: () {
                                      _newToggle();
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
                                        _newToggle();
                                      },
                                      child: Container(
                                        // color: Colors.red,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/close-eye.png"),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                        obscureText: newPaswordShow,
                        focusNode: _newPasswordFocus,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: confirmPaswordShow
                                ? GestureDetector(
                                    
                                    onTap: () {
                                      _confirmToggle();
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
                                        _confirmToggle();
                                      },
                                      child: Container(
                                        // color: Colors.red,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/close-eye.png"),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                        obscureText: confirmPaswordShow,
                        focusNode: _confirmPasswordFocus,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
                      child: Container(
                        height: SizeConfig.screenHeight * 0.06,
                        width: SizeConfig.screenWidth * 0.9,
                        decoration: BoxDecoration(
                            color: CommonColor.APP_BAR_COLOR,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto_Medium'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
