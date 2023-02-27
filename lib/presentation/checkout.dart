import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int currentIndex = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CommonColor.LAYOUT_BACKGROUND_COLOR,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.03,
                              left: SizeConfig.screenWidth * 0.025,
                              right: SizeConfig.screenWidth * 0.025,
                            ),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: CommonColor.WHITE_COLOR,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.03,
                                        top: SizeConfig.screenHeight * 0.015),
                                    child: Text(
                                      "Order Summery",
                                      style: TextStyle(
                                          color: CommonColor.BLACK_COLOR,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto_Medium'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      childCount: 3,
                      (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.025,
                            right: SizeConfig.screenWidth * 0.025,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: SizeConfig.screenWidth * 0.20,
                                          width: SizeConfig.screenWidth * 0.19,
                                          decoration: BoxDecoration(
                                              color: CommonColor.GRAY_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/dark.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.03,
                                                    right:
                                                        SizeConfig.screenWidth *
                                                            0.01,
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.01),
                                                child: Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.57,
                                                  color: Colors.transparent,
                                                  child: Text(
                                                    "Fortune Sunlite Refined Sunflower Oil ( 1 L)",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Roboto_Regular",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            3.5,
                                                        color: CommonColor
                                                            .BLACK_COLOR),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .screenHeight *
                                                        0.02),
                                                child: Container(
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.03,
                                                    child: Image(
                                                      image: AssetImage(
                                                        'assets/images/delete.png',
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.02,
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.02),
                                                child: Text(
                                                  "Rs.154",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.7,
                                                      fontFamily:
                                                          'Roboto_Medium',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.02,
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.02),
                                                child: Text(
                                                  "Rs.189",
                                                  style: TextStyle(
                                                      color:
                                                          CommonColor.RS_COLOR,
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.7,
                                                      fontFamily:
                                                          'Roboto_Normal',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.02,
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.13),
                                                child: Column(
                                                  children: [
                                                    Visibility(
                                                      visible: count != 0
                                                          ? true
                                                          : true,
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onDoubleTap: () {},
                                                            onTap: () {
                                                              if (mounted) {
                                                                setState(() {
                                                                  count--;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.035,
                                                              width: SizeConfig
                                                                      .screenWidth *
                                                                  0.067,
                                                              decoration: BoxDecoration(
                                                                  color: CommonColor
                                                                      .APP_BAR_COLOR,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Center(
                                                                  child: Text(
                                                                "-",
                                                                style: TextStyle(
                                                                    color: CommonColor
                                                                        .WHITE_COLOR,
                                                                    fontSize:
                                                                        SizeConfig.blockSizeHorizontal *
                                                                            5.6),
                                                                textScaleFactor:
                                                                    1.0,
                                                              )),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: SizeConfig
                                                                    .screenHeight *
                                                                0.035,
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.07,
                                                            decoration: BoxDecoration(
                                                                color: CommonColor
                                                                    .WHITE_COLOR,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Center(
                                                                child: Text(
                                                              "$count",
                                                              style: TextStyle(
                                                                  color: CommonColor
                                                                      .BLACK_COLOR,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          3.5),
                                                              textScaleFactor:
                                                                  1.0,
                                                            )),
                                                          ),
                                                          GestureDetector(
                                                            onDoubleTap: () {},
                                                            onTap: () {
                                                              if (mounted) {
                                                                setState(() {
                                                                  count++;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.035,
                                                              width: SizeConfig
                                                                      .screenWidth *
                                                                  0.067,
                                                              decoration: BoxDecoration(
                                                                  color: CommonColor
                                                                      .APP_BAR_COLOR,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Center(
                                                                  child: Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    color: CommonColor
                                                                        .WHITE_COLOR,
                                                                    fontSize:
                                                                        SizeConfig.blockSizeHorizontal *
                                                                            5.0),
                                                                textScaleFactor:
                                                                    1.0,
                                                              )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 0.02),
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.001,
                                    width: SizeConfig.screenWidth * 0.9,
                                    color: CommonColor.CIRCLE_COLOR,
                                    child: Text(
                                      "Hii",
                                      style:
                                          TextStyle(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          getCoupanCode(
                              SizeConfig.screenHeight, SizeConfig.screenWidth),
                          getBillDetails(
                              SizeConfig.screenHeight, SizeConfig.screenWidth),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.03,
                                left: SizeConfig.screenWidth * 0.03,
                                right: SizeConfig.screenWidth * 0.03,
                                bottom: SizeConfig.screenHeight * 0.17),
                            child: Container(
                              color: CommonColor.WHITE_COLOR,
                              height: SizeConfig.screenHeight * 0.05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.03,
                                    ),
                                    child: Text(
                                      "Cancel Policy",
                                      style: TextStyle(
                                          color: CommonColor.BLACK_COLOR,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto_Medium'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                getBuyButton(SizeConfig.screenHeight, SizeConfig.screenWidth)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Container(
      height: parentHeight * 0.1,
      color: CommonColor.APP_BAR_COLOR,
      child: Padding(
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
                    Icons.arrow_back_ios,
                    size: parentHeight * .025,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.02),
              child: Text(
                "Checkout",
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
                  Icons.arrow_back_ios,
                  size: parentHeight * .03,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOrderSummery(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: parentHeight * 0.02,
        left: parentWidth * 0.03,
        right: parentWidth * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.01, left: parentWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Order Summery",
                    style: TextStyle(
                        fontFamily: "Roboto_Bold",
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        color: CommonColor.BLACK_COLOR),
                  ),
                ],
              ),
            ),
            ListTile(
              title: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: parentWidth * 0.20,
                                width: parentWidth * 0.19,
                                decoration: BoxDecoration(
                                    color: CommonColor.GRAY_COLOR,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/dark.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: parentWidth * 0.03,
                                            right: parentWidth * 0.01,
                                            top: parentHeight * 0.01),
                                        child: Container(
                                          width: parentWidth * 0.57,
                                          color: Colors.transparent,
                                          child: Text(
                                            "Fortune Sunlite Refined Sunflower Oil ( 1 L)",
                                            style: TextStyle(
                                                fontFamily: "Roboto_Regular",
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.5,
                                                color: CommonColor.BLACK_COLOR),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: parentHeight * 0.02),
                                        child: Container(
                                            height: parentHeight * 0.03,
                                            child: Image(
                                              image: AssetImage(
                                                'assets/images/delete.png',
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.02,
                                            left: parentWidth * 0.02),
                                        child: Text(
                                          "Rs.154",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.7,
                                              fontFamily: 'Roboto_Medium',
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: parentWidth * 0.02,
                                            top: parentHeight * 0.02),
                                        child: Text(
                                          "Rs.189",
                                          style: TextStyle(
                                              color: CommonColor.RS_COLOR,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.7,
                                              fontFamily: 'Roboto_Normal',
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.02,
                                            left: parentWidth * 0.13),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: count != 0 ? true : true,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      if (mounted) {
                                                        setState(() {
                                                          count--;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height:
                                                          parentHeight * 0.035,
                                                      width:
                                                          parentWidth * 0.067,
                                                      decoration: BoxDecoration(
                                                          color: CommonColor
                                                              .APP_BAR_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Center(
                                                          child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .WHITE_COLOR,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                5.6),
                                                        textScaleFactor: 1.0,
                                                      )),
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                        parentHeight * 0.035,
                                                    width: parentWidth * 0.07,
                                                    decoration: BoxDecoration(
                                                        color: CommonColor
                                                            .WHITE_COLOR,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                        child: Text(
                                                      "$count",
                                                      style: TextStyle(
                                                          color: CommonColor
                                                              .BLACK_COLOR,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.5),
                                                      textScaleFactor: 1.0,
                                                    )),
                                                  ),
                                                  GestureDetector(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      if (mounted) {
                                                        setState(() {
                                                          count++;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height:
                                                          parentHeight * 0.035,
                                                      width:
                                                          parentWidth * 0.067,
                                                      decoration: BoxDecoration(
                                                          color: CommonColor
                                                              .APP_BAR_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Center(
                                                          child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .WHITE_COLOR,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                5.0),
                                                        textScaleFactor: 1.0,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.02),
                          child: Container(
                            height: parentHeight * 0.001,
                            width: parentWidth * 0.9,
                            color: CommonColor.CIRCLE_COLOR,
                            child: Text(
                              "Hii",
                              style: TextStyle(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCoupanCode(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: parentHeight * 0.03,
        left: parentWidth * 0.03,
        right: parentWidth * 0.03,
      ),
      child: Container(
        height: parentHeight * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.02),
                  child: Container(
                    height: parentHeight * 0.07,
                    width: parentWidth * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CommonColor.OFFER_COLOR,
                    ),
                    child: Text(
                      "Hii",
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.03),
                  child: Text(
                    "Use Coupons",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto_Medium'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: parentWidth * 0.03),
              child: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenHeight * 0.02,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getBillDetails(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: parentHeight * 0.03,
        left: parentWidth * 0.03,
        right: parentWidth * 0.03,
      ),
      child: Container(
        height: parentHeight * 0.27,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03, top: parentHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bill Details",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto_Medium'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.03, top: parentHeight * 0.02),
                  child: Text(
                    "Items Total",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: parentWidth * 0.05, top: parentHeight * 0.02),
                  child: Text(
                    "Rs.245",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.03, top: parentHeight * 0.01),
                  child: Text(
                    "Delivery Charges",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: parentWidth * 0.05, top: parentHeight * 0.01),
                  child: Text(
                    "Free",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.03, top: parentHeight * 0.01),
                  child: Text(
                    "Grand Total",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto_Medium'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: parentWidth * 0.05, top: parentHeight * 0.01),
                  child: Text(
                    "Rs.245",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.03),
              child: Container(
                color: CommonColor.SAVING_AMOUNT_COLOR,
                height: parentHeight * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.03),
                      child: Text(
                        "Your Total Saving",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto_Medium'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Text(
                        "45",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto_Regular'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBuyButton(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: parentHeight * 0.08),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCheckPayParentScreen(index: 2,)));
        },
        child: Container(
          height: parentHeight * 0.06,
          width: parentWidth * 0.8,
          decoration: BoxDecoration(
              color: CommonColor.APP_BAR_COLOR,
              borderRadius: BorderRadius.circular(7)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Proceed to Buy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto_Medium'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
