import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/checkout.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
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
  final _addressFocus = FocusNode();
  final _landMarkFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _selectAreaFocus = FocusNode();
  final pinCodeFocus = FocusNode();
  final stateFocus = FocusNode();
  final areaFocs = FocusNode();

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

  // Widget currentLocation(double parentHeight, double parentWidth) {
  //   return ;
  // }

  Widget getAddressField(double parentHeight, double parentWidth) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.03,
              left: parentHeight * 0.07,
              right: parentWidth * 0.14),
          child: Container(
            height: parentHeight * 0.06,
            width: parentWidth * 0.8,
            decoration: BoxDecoration(
              border:
              Border.all(width: 1, color: CommonColor.APP_BAR_COLOR), //Border.
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
                    // focusNode: _area,
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
                    controller: city,
                    focusNode: _cityFocus,
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
                    controller: selectArea,
                    focusNode: _selectAreaFocus,
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
        GestureDetector(
          onTap: () {
            // index == 1 ?
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const TenderDrawerScreen())) :
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AuctionDrawerScreen()));
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.09,
                left: parentWidth * 0.04,
                right: parentWidth * 0.04),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));
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
                    "Add",
                    style: TextStyle(
                        color: CommonColor.WHITE_COLOR,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto-Regular',
                        fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                  ))),
            ),
          ),
        ),
      ],
    );
  }
}
