import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:flutter/material.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {


  TextEditingController _amount = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: SizeConfig.screenHeight * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 7,
                      spreadRadius: 3,
                      offset: Offset(2, 2.0))
                ],
              ),
              child:
                  getTopText(SizeConfig.screenHeight, SizeConfig.screenWidth)),
          Container(
              height: SizeConfig.screenHeight * 0.27,
              child: getWalletHistory(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
        ],
      ),
    );
  }

  Widget getTopText(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onDoubleTap: () {},
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Text(
              "Wallet History",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6.0,
                  fontFamily: "Roboto_Medium",
                  fontWeight: FontWeight.w500,
                  color: CommonColor.BLACK_COLOR),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * 0.035),
            child: Container(
              width: parentWidth * 0.18,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.transparent,
                    size: parentHeight * 0.035,
                  ),
                  GestureDetector(
                    onDoubleTap: () {},
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Image(
                        image: AssetImage("assets/images/trolly.png"),
                        height: parentHeight * 0.03,
                        color: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getWalletHistory(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.03,
          left: parentWidth * 0.03,
          right: parentWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: Text(
                "Your Balance",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 7.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: Text(
                "\u20B90",
                style: TextStyle(
                    color: CommonColor.APP_BAR_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal * 12.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: GestureDetector(
                onDoubleTap: () {},
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Wallet Recharge'),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.015),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.001,
                              width: SizeConfig.screenWidth * 0.9,
                              color: CommonColor.CIRCLE_COLOR,
                              child: Text(
                                "Hii",
                                style: TextStyle(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            // color: Colors.red,
                            height: parentHeight*0.04,
                            child: TextFormField(
                              controller: _amount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle:
                                      TextStyle(color: Colors.black26)),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.02),
                            child: Container(
                              // color: Colors.red,
                              height: parentHeight*0.05,
                              child: TextFormField(
                                controller: _notes,
                                decoration: InputDecoration(
                                    hintText: 'Message(Optional)',
                                    hintStyle:
                                    TextStyle(color: Colors.black26)),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.03),
                            child: Row(
                              children: [
                                Text("Payment Method",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                      fontFamily: 'Roboto_Medium',
                                      fontWeight: FontWeight.w500
                                  ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/razorpay-icon.png",
                                ),
                                  height: parentHeight*0.03,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.circle_outlined,
                                      color: CommonColor.APP_BAR_COLOR,),
                                    Padding(
                                      padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027, bottom: parentHeight*0.001),
                                      child: Icon(Icons.circle,
                                        color: CommonColor.APP_BAR_COLOR,
                                        size: SizeConfig.blockSizeHorizontal*4.0,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onDoubleTap: () {},
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight * 0.055,
                                width: SizeConfig.screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onDoubleTap: () {},
                              onTap: () {},
                              child: Container(
                                height: SizeConfig.screenHeight * 0.055,
                                width: SizeConfig.screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    color: CommonColor.APP_BAR_COLOR,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(
                                  "Recharge",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'),
                                )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                  width: parentWidth * 0.84,
                  height: parentHeight * 0.05,
                  decoration: BoxDecoration(
                      color: CommonColor.APP_BAR_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Recharge Your Wallet",
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
      ),
    );
  }
}
