import 'dart:convert';

import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/current_location_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Address extends StatefulWidget {
  final String isCome;
  final String address;
  final String landMark;
  final String city;
  final String area;
  final String country;
  final String state;
  final String postalCode;
  final String fullName;
  final String phoneNumber;
  final String alterPhoneNumber;
  final String isType;
  final String isDefault;
  final String addressId;
  final double lat;
  final double long;

  const Address(
      {Key? key,
      required this.isCome,
      this.address = '',
      this.landMark = '',
      this.city = '',
      this.area = '',
      this.country = '',
      this.state = '',
      this.postalCode = '',
      required this.lat,
      required this.long,
      this.fullName = '',
      this.phoneNumber = '',
      this.alterPhoneNumber = '',
      this.isType = '',
      this.isDefault = '',
      this.addressId = ''})
      : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController alternatePhoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController selectArea = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  final _alternatePhoneNumberFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _landMarkFocus = FocusNode();
  final _cityFocus = FocusNode();
  final countryFocus = FocusNode();
  final pinCodeFocus = FocusNode();
  final stateFocus = FocusNode();
  final areaFocus = FocusNode();

  bool isChecked = false;
  String isType = "0";
  String isDefault = "0";
  bool _isDialogVisible = false;

  @override
  void initState() {
    super.initState();

    print("${widget.lat}, ${widget.long} ${widget.isCome}");


    if(mounted){
      setState(() {
        fullName.text = widget.fullName;
        phoneNumber.text = widget.phoneNumber;
        alternatePhoneNumber.text = widget.alterPhoneNumber;
        address.text = widget.address;
        landMark.text = widget.landMark;
        city.text = widget.city;
        area.text = widget.area;
        country.text = widget.country;
        state.text = widget.state;
        pinCode.text = widget.postalCode;
        isType = widget.isType;
        isDefault = widget.isDefault;
      });
    }

    isDefault == "1" ? isChecked = true : isChecked = false;


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
              color: CommonColor.APP_BAR_COLOR,
              height: SizeConfig.screenHeight * 0.1,
              child: getAddMainHeadingLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
          Container(
            height: SizeConfig.screenHeight * 0.9,
            child: getAddressField(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
        ],
      ),
      floatingActionButton: _isDialogVisible == true
          ? Padding(
              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
              child: AlertDialog(
                backgroundColor: Colors.white,
                elevation: 9,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text(
                  widget.isCome == "1" ? "Address Added Successfully." : "Address Updated Successfully.",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            )
          : null,
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
              Navigator.pop(context, AllCommonApis().getAddressOfUser());
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
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: Text(
              "Address",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
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

  Widget getAddressField(double parentHeight, double parentWidth) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.03,
              left: parentHeight * 0.07,
              right: parentWidth * 0.14),
          child: GestureDetector(
            
            onTap: () {
              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(seconds: 2),
                      child: CurrentLocationDialogue(
                        buttonText: widget.isCome,
                      ));
                },
              );
            },
            child: Container(
              height: parentHeight * 0.06,
              width: parentWidth * 0.8,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: CommonColor.APP_BAR_COLOR),
                //Border.
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.04),
                  child: Icon(
                    Icons.assistant_direction_rounded,
                    size: parentHeight * .030,
                    color: CommonColor.APP_BAR_COLOR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.07),
                  child: const Text(
                    "Use my current location",
                    style: TextStyle(
                        fontFamily: 'Regular-Roboto',
                        fontWeight: FontWeight.w700,
                        color: CommonColor.APP_BAR_COLOR,
                        fontSize: 15),
                  ),
                )
              ]),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.03,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: fullName,
            focusNode: _fullNameFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Full Name",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: phoneNumber,
            focusNode: _phoneNumberFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Phone No",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: alternatePhoneNumber,
            focusNode: _alternatePhoneNumberFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Alternate Phone No",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: address,
            focusNode: _addressFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Address",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: landMark,
            focusNode: _landMarkFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Land Mark",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: parentWidth * 0.05),
                  child: TextFormField(
                    controller: city,
                    focusNode: _cityFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "City",
                      contentPadding: const EdgeInsets.all(14),
                      hintStyle: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          fontFamily: 'Roboto_Regular'),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.05),
                  child: TextFormField(
                    controller: area,
                    focusNode: areaFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Select Area",
                      contentPadding: const EdgeInsets.all(14),
                      hintStyle: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          fontFamily: 'Roboto_Regular'),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: parentWidth * 0.05),
                  child: TextFormField(
                    controller: country,
                    focusNode: countryFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Country",
                      contentPadding: const EdgeInsets.all(14),
                      hintStyle: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          fontFamily: 'Roboto_Regular'),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.05),
                  child: TextFormField(
                    controller: state,
                    focusNode: stateFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "State",
                      contentPadding: const EdgeInsets.all(14),
                      hintStyle: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          fontFamily: 'Roboto_Regular'),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: TextFormField(
            controller: pinCode,
            focusNode: pinCodeFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "PinCode",
              contentPadding: const EdgeInsets.all(14),
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular'),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                
                onTap: () {
                  if (mounted) {
                    setState(() {
                      isType = "1";
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.circle_outlined,
                              color: CommonColor.APP_BAR_COLOR,
                            ),
                          ),
                          Visibility(
                            visible: isType == "1" ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.screenWidth * 0.00277),
                              child: Icon(
                                Icons.circle,
                                color: CommonColor.APP_BAR_COLOR,
                                size: SizeConfig.blockSizeHorizontal * 4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.02),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto_Regular'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                
                onTap: () {
                  if (mounted) {
                    setState(() {
                      isType = "2";
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  isType = "2";
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                Icons.circle_outlined,
                                color: CommonColor.APP_BAR_COLOR,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isType == "2" ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.screenWidth * 0.0027),
                              child: Icon(
                                Icons.circle,
                                color: CommonColor.APP_BAR_COLOR,
                                size: SizeConfig.blockSizeHorizontal * 4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.02),
                        child: Text(
                          "Office",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto_Regular'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.transparent,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.0027),
                        child: Icon(
                          Icons.circle,
                          color: Colors.transparent,
                          size: SizeConfig.blockSizeHorizontal * 4.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                    child: Text(
                      "Other",
                      style: TextStyle(
                          color: Colors.transparent,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto_Regular'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: parentWidth * 0.05, top: parentHeight * 0.01),
          child: Row(
            children: [
              Container(
                height: parentHeight * 0.07,
                width: parentWidth * 0.069,
                child: Column(
                  children: <Widget>[
                    Checkbox(
                      activeColor: CommonColor.APP_BAR_COLOR,
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          print(isChecked);
                          isChecked == true ? isDefault = "1" : isDefault = "0";
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
                    padding: EdgeInsets.only(
                        left: parentWidth * 0.02, bottom: parentHeight * 0.015),
                    child: Text("Set as default address"),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.01,
              left: parentWidth * 0.04,
              right: parentWidth * 0.04,
              bottom: parentHeight * 0.03),
          child: GestureDetector(
            onTap: () {
              if (fullName.text.isNotEmpty) {
                if (phoneNumber.text.isNotEmpty &&
                    phoneNumber.text.length == 10) {
                  if (alternatePhoneNumber.text.isNotEmpty &&
                      alternatePhoneNumber.text.length == 10) {
                    if (address.text.isNotEmpty) {
                      if (landMark.text.isNotEmpty) {
                        if (city.text.isNotEmpty) {
                          if (area.text.isNotEmpty) {
                            if (country.text.isNotEmpty) {
                              if (state.text.isNotEmpty) {
                                if (pinCode.text.isNotEmpty) {
                                  if (isType != "0") {
                                    if(widget.isCome == "1"){
                                      AddAddress(
                                          fullName.text.trim(),
                                          phoneNumber.text.trim(),
                                          alternatePhoneNumber.text.trim(),
                                          address.text.trim(),
                                          landMark.text.trim(),
                                          city.text.trim(),
                                          area.text.trim(),
                                          country.text.trim(),
                                          state.text.trim(),
                                          pinCode.text.trim(),
                                          widget.lat,
                                          widget.long);
                                    }else{
                                      updateAddress(
                                        fullName.text.trim(),
                                        phoneNumber.text.trim(),
                                        alternatePhoneNumber.text.trim(),
                                        address.text.trim(),
                                        landMark.text.trim(),
                                        city.text.trim(),
                                        area.text.trim(),
                                        country.text.trim(),
                                        state.text.trim(),
                                        pinCode.text.trim(),
                                        widget.addressId,
                                        widget.lat,
                                        widget.long,
                                      );
                                    }

                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Select Your Address Type.")));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Enter Your PinCode.")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Enter Your State.")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter Your Country.")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter Your Area.")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Enter Your City.")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Enter Your Land Mark.")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Enter Your Full Address.")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Enter Your Valid Number.")));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Enter Your Valid Number.")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter Your Full Name.")));
              }
            },
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
                  widget.isCome == "1" ? "Add" : "Update",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto-Regular',
                      fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                ))),
          ),
        ),
      ],
    );
  }

  void AddAddress(
      String name,
      String number,
      String alterNumber,
      String address,
      String landMark,
      String city,
      String area,
      String country,
      String state,
      String pinCode,
      double lat,
      double long) async {
    String? id = await AppPreferences.getIds();

    print(
        "$id \n$name \n$number \n$alterNumber \n$address \n$landMark \n$city \n$area \n$country \n$state \n$pinCode \n${lat.toString()} \n${long.toString()} \n$isType \n$isDefault");

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      Response response = await post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().getAddUserAddress),
          headers: headersList,
          body: {
            "accesskey": "90336",
            "add_address": "1",
            "user_id": id,
            "type": isType,
            "name": name,
            "mobile": number,
            "address": address,
            "landmark": landMark,
            "area_id": area,
            "city_id": city,
            "pincode": pinCode,
            "state": state,
            "country": country,
            "latitude": lat.toString(),
            "longitude": long.toString(),
            "is_default": "$isDefault",
            "country_code": "+91",
            "alternate_mobile": alterNumber
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        if (mounted) {
          setState(() {
            _isDialogVisible = true;

            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _isDialogVisible = false;
                  Navigator.pop(context);
                });
              }
            });
          });
        }
        // Navigator.pop(context);
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }


  void updateAddress(
      String name,
      String number,
      String alterNumber,
      String address,
      String landMark,
      String city,
      String area,
      String country,
      String state,
      String pinCode,
      String addressId,
      double lat,
      double long) async {
    String? id = await AppPreferences.getIds();

    print(
        "$id \n$name \n$number \n$alterNumber \n$address \n$landMark \n$city \n$area \n$country \n$state \n$pinCode \n${lat.toString()} \n${long.toString()} \n$isType \n$isDefault");

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      Response response = await post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().getAddUserAddress),
          headers: headersList,
          body: {
            "accesskey": "90336",
            "update_address": "1",
            "id":addressId,
            "user_id": id,
            "type": isType,
            "name": name,
            "mobile": number,
            "address": address,
            "landmark": landMark,
            "area_id": area,
            "city_id": city,
            "pincode": pinCode,
            "state": state,
            "country": country,
            "latitude": lat.toString(),
            "longitude": long.toString(),
            "is_default": isDefault,
            "country_code": "+91",
            "alternate_mobile": alterNumber
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        if (mounted) {
          setState(() {
            _isDialogVisible = true;

            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _isDialogVisible = false;
                  AllCommonApis().getAddressOfUser();
                  Navigator.pop(context);
                });
              }
            });
          });
        }
        // Navigator.pop(context);
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
