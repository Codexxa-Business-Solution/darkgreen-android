import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/order/get_all_orders_status_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/track_order_parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoorStepOrder extends StatefulWidget {
  final GetOredersStatusResponseModel model;
  final int index;

  const DoorStepOrder({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<DoorStepOrder> createState() => _DoorStepOrderState();
}

class _DoorStepOrderState extends State<DoorStepOrder> {
  String placeDate = "";
  String deliveryDate = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
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
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  height: SizeConfig.screenHeight * 0.9,
                  child: allDetailsLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth)),
              Container(
                height: SizeConfig.screenHeight * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.03,
                      right: SizeConfig.screenWidth * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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
                                      Text('Re-Order!'),
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
                                        style: TextStyle(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You want to re-order?',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.screenHeight * 0.005),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'All products will be added to cart.',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto-Light'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto-Light'),
                                        )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onDoubleTap: () {},
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: SizeConfig.screenHeight * 0.055,
                                        width: SizeConfig.screenWidth * 0.37,
                                        decoration: BoxDecoration(
                                            color: CommonColor.APP_BAR_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          "Proceed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5.0,
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
                            height: SizeConfig.screenHeight * 0.06,
                            width: SizeConfig.screenWidth * 0.45,
                            decoration: BoxDecoration(
                                color: CommonColor.APP_BAR_COLOR,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Re-Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          AllCommonApis().getInvoiceOrder(
                              widget.model.data[widget.index].id);
                        },
                        child: Container(
                            height: SizeConfig.screenHeight * 0.06,
                            width: SizeConfig.screenWidth * 0.45,
                            decoration: BoxDecoration(
                                color: CommonColor.APP_BAR_COLOR,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Get Invoice",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
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
              "Order Details",
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
                    color: Colors.black,
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
                        color: Colors.black,
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

  Widget allDetailsLayout(double parentHeight, double parentWidth) {
    placeDate = DateFormat.yMd()
        .add_jm()
        .format(widget.model.data[widget.index].orderTime);
    // deliveryDate =  DateFormat.yMd().add_jms().format(widget.model.data[widget.index].deliveryTime);

    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.03,
          left: parentWidth * 0.03,
          right: parentWidth * 0.03),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: parentWidth * 0.22,
                      child: Text(
                        "Order OTP : ",
                        style: TextStyle(
                            color: CommonColor.APP_BAR_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      widget.model.data[widget.index].otp,
                      style: TextStyle(
                          color: CommonColor.APP_BAR_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontFamily: "Roboto_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: parentWidth * 0.22,
                        child: Text(
                          "Ordered Id : ",
                          style: TextStyle(
                              color: CommonColor.BLACK_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        widget.model.data[widget.index].id,
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontFamily: "Roboto_Medium",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: parentWidth * 0.22,
                        child: Text(
                          "Order Date : ",
                          style: TextStyle(
                              color: CommonColor.BLACK_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "$placeDate",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontFamily: "Roboto_Medium",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: parentHeight * 0.01),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: widget.model.data[widget.index].items.length,
              (context, index1) {
                final img = widget
                        .model.data[widget.index].items[index1].image.isNotEmpty
                    ? Image.network(
                        widget.model.data[widget.index].items[index1].image,
                      )
                    : Image.network("");

                return Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.0),
                  child: Container(
                    height: parentHeight * 0.23,
                    color: CommonColor.REVIEW_CONTAINER_COLOR,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: parentWidth * 0.035,
                            right: parentWidth * 0.035),
                        child: Container(
                          height: parentHeight * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: parentWidth * 0.03),
                                child: Container(
                                  height: parentHeight * 0.17,
                                  width: parentWidth * 0.3,
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: img,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: parentHeight * 0.023,
                                    left: parentWidth * 0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: parentWidth * 0.47,
                                      child: Text(
                                        widget.model.data[widget.index]
                                            .items[index1].name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.005),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Qty : ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.0,
                                                fontFamily: 'Roboto_Regular',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            widget.model.data[widget.index]
                                                .items[index1].quantity,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.0,
                                                fontFamily: 'Roboto_Medium',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.007),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "\u20B9${widget.model.data[widget.index].items[index1].subTotal}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.0,
                                                fontFamily: 'Roboto_Medium',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.007),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.model.data[widget.index]
                                                        .paymentMethod ==
                                                    "Cash Method"
                                                ? "Via C.O.D."
                                                : "Online Payment",
                                            style: TextStyle(
                                                color:
                                                    CommonColor.APP_BAR_COLOR,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.0,
                                                fontFamily: 'Roboto_Medium',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.model.data[widget.index]
                                                .items[index1].tillStatus
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.0,
                                                fontFamily: 'Roboto_Regular',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: parentHeight * 0.1),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.005,
                      width: SizeConfig.screenWidth * 1.5,
                      color: CommonColor.CIRCLE_COLOR,
                      child: Text(
                        "Hii",
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto_Medium'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.01),
                          child: Container(
                            color: Colors.transparent,
                            width: parentWidth * 0.95,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Items",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                    ),
                                    Text(
                                      "\u20B9 ${widget.model.data[widget.index].finalTotal}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Delivery Charge :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        "+ \u20B9 ${widget.model.data[widget.index].deliveryCharge}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Discount(0%) :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        "- \u20B9 ${widget.model.data[widget.index].discount}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        "\u20B9 ${widget.model.data[widget.index].finalTotal}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PromoCode Discount :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        "- \u20B9 ${widget.model.data[widget.index].promoDiscount}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Wallet :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        "- \u20B9 ${widget.model.data[widget.index].walletBalance}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.005),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Final Total :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto_Medium'),
                                      ),
                                      Text(
                                        "\u20B9 ${widget.model.data[widget.index].finalTotal}",
                                        style: TextStyle(
                                            color: CommonColor.APP_BAR_COLOR,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.005,
                      width: SizeConfig.screenWidth * 1.5,
                      color: CommonColor.CIRCLE_COLOR,
                      child: Text(
                        "Hii",
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto_Medium'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.01),
                          child: Container(
                            color: Colors.transparent,
                            width: parentWidth * 0.95,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                    ),
                                    Text(
                                      widget.model.data[widget.index].userName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile No. : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Text(
                                        widget.model.data[widget.index].mobile,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.003),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        width: parentWidth * 0.75,
                                        child: Text(
                                          widget
                                              .model.data[widget.index].address,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto_Regular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.005,
                      width: SizeConfig.screenWidth * 1.5,
                      color: CommonColor.CIRCLE_COLOR,
                      child: Text(
                        "Hii",
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto_Medium'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.01),
                          child: Container(
                            // color: Colors.red,
                            width: parentWidth * 0.95,
                            height: parentHeight * 0.16,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  width: parentWidth * 0.17,
                                  child: Text(
                                    widget.model.data[widget.index]
                                                .activeStatus ==
                                            "awaiting_payment"
                                        ? "Order Awaiting Approval"
                                        : widget.model.data[widget.index]
                                                    .activeStatus ==
                                                "pending"
                                            ? "Order Pending"
                                            : widget.model.data[widget.index]
                                                        .activeStatus ==
                                                    "received"
                                                ? "Order Received"
                                                : widget
                                                            .model
                                                            .data[widget.index]
                                                            .activeStatus ==
                                                        "processed"
                                                    ? "Order Processed"
                                                    : widget
                                                                .model
                                                                .data[widget
                                                                    .index]
                                                                .activeStatus ==
                                                            "shipped"
                                                        ? "Order Shipped"
                                                        : widget
                                                                    .model
                                                                    .data[widget
                                                                        .index]
                                                                    .activeStatus ==
                                                                "delivered"
                                                            ? "Order Delivered"
                                                            : widget
                                                                        .model
                                                                        .data[widget
                                                                            .index]
                                                                        .activeStatus ==
                                                                    "cancelled"
                                                                ? "Order Cancelled"
                                                                : widget.model.data[widget.index]
                                                                            .activeStatus ==
                                                                        "returned"
                                                                    ? "Order Returned"
                                                                    : "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto_Regular'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.005),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle_outlined,
                                        color: CommonColor.APP_BAR_COLOR,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right:
                                                SizeConfig.screenWidth * 0.0027,
                                            bottom: parentHeight * .001),
                                        child: Icon(
                                          Icons.circle,
                                          color: CommonColor.APP_BAR_COLOR,
                                          size: SizeConfig.blockSizeHorizontal *
                                              4.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.001),
                                  child: Container(
                                    // color: Colors.blue,
                                    width: parentWidth * 0.22,
                                    child: Text(
                                      widget.model.data[widget.index]
                                          .deliveryTime,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                /* Padding(
                                  padding: EdgeInsets.only(top: parentHeight*0.001),
                                  child: Container(
                                    // color: Colors.blue,
                                    width: parentWidth*0.23,
                                    child: Text(
                                      "11:09:07 AM",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto_Regular'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.005,
                      width: SizeConfig.screenWidth * 1.5,
                      color: CommonColor.CIRCLE_COLOR,
                      child: Text(
                        "Hii",
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: parentHeight * 0.015,
                        right: parentWidth * 0.03,
                        top: parentHeight * 0.02,
                        left: parentWidth * 0.03),
                    child: GestureDetector(
                      onTap: () {
                        AllCommonApis()
                            .getOrderDelete(widget.model.data[widget.index].id)
                            .then((value) {
                          print(value.message);

                          if (value.message == "Order deleted successfully!") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TrackOrderParentScreen()));
                          }
                        });
                      },
                      child: Container(
                        height: parentHeight * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "CANCEL ORDER",
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
            ),
          ),
        ],
      ),

      /*ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [





          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                width: parentWidth*0.22,
                child: Text("Order OTP : ",
                style: TextStyle(
                  color: CommonColor.APP_BAR_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                  fontFamily: "Roboto_Regular",
                  fontWeight: FontWeight.w400
                ),),
              ),
              Text(widget.model.data[widget.index].otp,
              style: TextStyle(
                color: CommonColor.APP_BAR_COLOR,
                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                fontFamily: "Roboto_Medium",
                fontWeight: FontWeight.w500
              ),),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: parentWidth*0.22,
                  child: Text("Ordered Id : ",
                  style: TextStyle(
                      color: CommonColor.BLACK_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w400
                  ),),
                ),
                Text(widget.model.data[widget.index].id,
                style: TextStyle(
                    color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                  fontFamily: "Roboto_Medium",
                  fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: parentWidth*0.22,
                  child: Text("Order Date : ",
                  style: TextStyle(
                      color: CommonColor.BLACK_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w400
                  ),),
                ),
                Text("$placeDate",
                style: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                  fontFamily: "Roboto_Medium",
                  fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),


          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.01),
            child: Container(
              height: parentHeight*0.23,
              color: CommonColor.REVIEW_CONTAINER_COLOR,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: parentWidth*0.035, right: parentWidth*0.035),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: parentHeight*0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(left: parentWidth*0.03),
                              child: Container(
                                height: parentHeight*0.17,
                                width: parentWidth*0.3,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(image: AssetImage("assets/images/carosel_demo.png"),
                                    fit: BoxFit.cover,),
                                  ),

                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: parentHeight*0.023, left: parentWidth*0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    color: Colors.transparent,
                                    width: parentWidth*0.47,
                                    child: Text("MOONG DAL DHULI LOOSE",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400
                                    ),),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: parentHeight*0.005),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Qty : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontFamily: 'Roboto_Regular',
                                              fontWeight: FontWeight.w400
                                          ),),
                                        Text("4",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontFamily: 'Roboto_Medium',
                                              fontWeight: FontWeight.w500
                                          ),),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: parentHeight*0.007),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("\u20B955.00",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontFamily: 'Roboto_Medium',
                                              fontWeight: FontWeight.w500
                                          ),),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: parentHeight*0.007),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Via C.O.D.",
                                          style: TextStyle(
                                              color: CommonColor.APP_BAR_COLOR,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontFamily: 'Roboto_Medium',
                                              fontWeight: FontWeight.w500
                                          ),),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: parentHeight*0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Received",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontFamily: 'Roboto_Regular',
                                              fontWeight: FontWeight.w400
                                          ),),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: parentHeight*0.015, right: parentWidth*0.03),
                        child: Container(
                          height: parentHeight*0.035,
                          width: parentWidth*0.22,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5
                              )
                          ),
                          child: Center(
                            child: Text("Cancel Item",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                  fontFamily: 'Roboto_Medium',
                                  fontWeight: FontWeight.w500
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Container(
              height: SizeConfig.screenHeight * 0.005,
              width: SizeConfig.screenWidth * 1.5,
              color: CommonColor.CIRCLE_COLOR,
              child: Text(
                "Hii",
                style:
                TextStyle(color: Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price Details",
                  style: TextStyle(
                      color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto_Medium'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight*0.01),
                  child: Container(
                    color: Colors.transparent,
                    width: parentWidth*0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Items",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                            ),
                            Text(
                              "\u20B9220.00",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "+ \u20B920.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount(0%) :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "- \u20B90.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "\u20B9240.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PromoCode Discount :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "- \u20B90.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Wallet :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "- \u20B90.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.005),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Final Total :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                              Text(
                                "\u20B9240.00",
                                style: TextStyle(
                                    color: CommonColor.APP_BAR_COLOR,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Container(
              height: SizeConfig.screenHeight * 0.005,
              width: SizeConfig.screenWidth * 1.5,
              color: CommonColor.CIRCLE_COLOR,
              child: Text(
                "Hii",
                style:
                TextStyle(color: Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Other Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto_Medium'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight*0.01),
                  child: Container(
                    color: Colors.transparent,
                    width: parentWidth*0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                            ),
                            Text(
                              "Ash",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Mobile No. : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                "1234567890",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.003),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Container(
                                color: Colors.transparent,
                                width: parentWidth*0.75,
                                child: Text(
                                  "City Avenue, Wakad, Office No. 217, Pune, Maharashtra.",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto_Regular'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Container(
              height: SizeConfig.screenHeight * 0.005,
              width: SizeConfig.screenWidth * 1.5,
              color: CommonColor.CIRCLE_COLOR,
              child: Text(
                "Hii",
                style:
                TextStyle(color: Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Status",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto_Medium'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight*0.01),
                  child: Container(
                    // color: Colors.red,
                    width: parentWidth*0.95,
                    height: parentHeight*0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.blue,
                          width: parentWidth*0.17,
                          child: Text(
                            "Order Received",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto_Regular'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.005),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.circle_outlined,
                                color: CommonColor.APP_BAR_COLOR,),
                              Padding(
                                padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027, bottom: parentHeight*.001),
                                child: Icon(Icons.circle,
                                  color: CommonColor.APP_BAR_COLOR,
                                  size: SizeConfig.blockSizeHorizontal*4.0,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.001),
                          child: Container(
                            // color: Colors.blue,
                            width: parentWidth*0.21,
                            child: Text(
                              "27-02-2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.001),
                          child: Container(
                            // color: Colors.blue,
                            width: parentWidth*0.23,
                            child: Text(
                              "11:09:07 AM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_Regular'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02),
            child: Container(
              height: SizeConfig.screenHeight * 0.005,
              width: SizeConfig.screenWidth * 1.5,
              color: CommonColor.CIRCLE_COLOR,
              child: Text(
                "Hii",
                style:
                TextStyle(color: Colors.transparent),
              ),
            ),
          ),
          SizedBox(
            height: parentHeight*0.06,
          )
        ],
      )*/
    );
  }
}
