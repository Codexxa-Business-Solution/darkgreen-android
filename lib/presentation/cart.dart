import 'dart:convert';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/cart/get_users_cart_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:darkgreen/presentation/save_for_later_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/color.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 0;
  int cartCount = 0;
  int productPrice = 0;
  String productId = "";
  String productVariantId = "";
  int? totalCartsCount;
  int totalCartAmount = 0;
  int laterCartCount = 0;
  String isType = "0";

  @override
  void initState() {
    super.initState();

    refresh();

  }

  void refresh() {
    var result = getAllCarts();
    totalCartAmount = 0;
    result.then((value) {
      if (mounted) {
        setState(() {
          isType = "0";
          totalCartsCount = value.data.isNotEmpty ? value.data.length : 0;
          for (var element in value.data) {
            totalCartAmount +=
            (int.parse(element.discountedPrice) * int.parse(element.qty));
          }
        });
      }
    });

    AllCommonApis().getSaveForLater().then((value){
      if(mounted){
        setState(() {
          laterCartCount = value.data.length;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: getAddMainHeadingLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
          Column(
            children: [
              getAllCartsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ],
          )
        ],
        //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
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
                "Cart",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: parentWidth * .04),
              child: GestureDetector(
                onDoubleTap: (){},
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveForLater())).then((value){
                    if(mounted){
                      setState(() {
                        refresh();
                      });
                    }
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.03),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: parentWidth*0.1,
                          height: parentHeight*0.04,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Center(
                              child: Image(image: AssetImage("assets/images/save_later.png"),
                              height: parentHeight*0.03,
                              color: Colors.white,),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: laterCartCount == 0 ? false : true,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: parentHeight*0.027, right: parentWidth*0.005),
                            child: Container(
                              height: parentHeight*0.05,
                              width: parentWidth*0.05,
                              decoration: BoxDecoration(
                                  color: CommonColor.WHITE_COLOR,
                                  shape: BoxShape.circle,
                                border: Border.all(color: CommonColor.APP_BAR_COLOR)
                              ),
                              child: Center(
                                child: Text("$laterCartCount",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal*2.5,
                                  color: Colors.black
                                ),),
                              ),
                            ),
                          ),
                        )
                      ],
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

  Widget getAllCartsLayout(double parentHeight, double parentWidth) {
    return Container(
      height: parentHeight * 0.9,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<GetUserCartResponseModel>(
            future: getAllCarts(),
            builder: (context, snap) {
              if (!snap.hasData && !snap.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snap.data;

              if (data == null) {
                return const Center(
                  child: Text("No items found in user cart!"),
                );
              }
              return ListView.builder(
                  itemCount: snap.data?.data.length,
                  padding: EdgeInsets.only(bottom: parentHeight * 0.13),
                  itemBuilder: (context, index) {
                    print("lent ${snap.data?.data.length}");

                    totalCartsCount = snap.data?.data.length != 0
                        ? snap.data?.data.length
                        : 0;

                    print("aaaaaaaaa $totalCartAmount");

                    final img = data.data[index].image.isNotEmpty
                        ? Image.network(
                      "${data.data[index].image}",
                    )
                        : Image.network("");

                    return Padding(
                      padding: EdgeInsets.only(
                          top: parentHeight * 0.01,
                          bottom: parentHeight * 0.01,
                          left: parentWidth * 0.03,
                          right: parentWidth * 0.03),
                      child: Container(
                        height: parentHeight * 0.19,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade50,
                              offset: const Offset(-5, 0),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade50,
                              offset: const Offset(5, 0),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: parentHeight * 0.02, left: parentWidth*0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: parentWidth * 0.2,
                                    width: parentWidth * 0.2,
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                            offset: Offset(1, 2))
                                      ],
                                        color: CommonColor.WHITE_COLOR,
                                        borderRadius: BorderRadius.circular(8),
                                      // border: Border.all(color: Colors.black, width: parentWidth*0.0005)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: img,
                                    )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: parentWidth * 0.03,
                                                right: parentWidth * 0.01,),
                                            child: Container(
                                              width: parentWidth * 0.61,
                                              color: Colors.transparent,
                                              child: Text(
                                                "${snap.data?.data[index].name}",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Roboto_Regular",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.0,
                                                    color: CommonColor
                                                        .BLACK_COLOR),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: parentHeight * 0.02),
                                              child: GestureDetector(
                                                onTap: () {
                                                  productVariantId =
                                                      "${snap.data?.data[index].productVariantId}";

                                                  var result = removeToCartApi(
                                                      productVariantId);

                                                  result.then((value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        print("HIIIIIIII");
                                                        getAllCarts();
                                                      });
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: parentHeight * 0.03,
                                                  color: Colors.transparent,
                                                  child: Icon(Icons
                                                      .delete_forever_rounded),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        width: parentWidth*0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           Padding(
                                             padding: EdgeInsets.only(
                                                 left: parentWidth * 0.03),
                                             child: Container(
                                               color: Colors.transparent,
                                               width: parentWidth*0.45,
                                               child: Row(
                                                 children: [
                                                   Text(
                                                     "Rs.${snap.data?.data[index].discountedPrice}",
                                                     style: TextStyle(
                                                         color: Colors.black,
                                                         fontSize: SizeConfig
                                                             .blockSizeHorizontal *
                                                             4.5,
                                                         fontFamily: 'Roboto_Medium',
                                                         fontWeight:
                                                         FontWeight.w500),
                                                     textAlign: TextAlign.center,
                                                   ),
                                                   Padding(
                                                     padding: EdgeInsets.only(left: parentWidth*0.02),
                                                     child: Text(
                                                       "Rs.${snap.data?.data[index].price}",
                                                       style: TextStyle(
                                                           color: CommonColor
                                                               .DISCOUNT_COLOR,
                                                           fontSize: SizeConfig
                                                               .blockSizeHorizontal *
                                                               4.5,
                                                           fontFamily: 'Roboto_Medium',
                                                           fontWeight: FontWeight.w500,
                                                           decoration: TextDecoration
                                                               .lineThrough),
                                                       textAlign: TextAlign.center,
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight * 0.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        
                                                        onTap: () {
                                                          productId =
                                                              "${snap.data?.data[index].productId}";
                                                          productVariantId =
                                                              "${snap.data?.data[index].productVariantId}";

                                                          cartCount = int.parse(
                                                              "${snap.data?.data[index].qty}");

                                                          cartCount--;

                                                          snap.data?.data[index]
                                                                  .qty =
                                                              cartCount
                                                                  .toString();

                                                          AllCommonApis()
                                                              .addToCartApi(
                                                                  productId,
                                                                  productVariantId,
                                                                  cartCount
                                                                      .toString())
                                                              .then((value) {
                                                            if (mounted) {
                                                              setState(() {
                                                                print("hhuihuhuihhui");
                                                                refresh();
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          height: SizeConfig
                                                                  .screenHeight *
                                                              0.035,
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.07,
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
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    5.6),
                                                            textScaleFactor: 1.0,
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
                                                                    .circular(5)),
                                                        child: Center(
                                                            child: Text(
                                                          "${snap.data?.data[index].qty}",
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
                                                        
                                                        onTap: () {
                                                          productId =
                                                              "${snap.data?.data[index].productId}";
                                                          productVariantId =
                                                              "${snap.data?.data[index].productVariantId}";

                                                          cartCount = int.parse(
                                                              "${snap.data?.data[index].qty}");

                                                          cartCount++;

                                                          snap.data?.data[index]
                                                                  .qty =
                                                              cartCount
                                                                  .toString();

                                                          AllCommonApis()
                                                              .addToCartApi(
                                                                  productId,
                                                                  productVariantId,
                                                                  cartCount
                                                                      .toString())
                                                              .then((value) {
                                                            if (mounted) {
                                                              setState(() {
                                                                refresh();
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          height: SizeConfig
                                                                  .screenHeight *
                                                              0.035,
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.07,
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
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    5.0),
                                                            textScaleFactor: 1.0,
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: parentHeight * 0.016),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.05),
                                    child: Text(
                                      "Save for later",
                                      style: TextStyle(
                                          color: Colors.transparent,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto-Medium'),
                                    ),
                                  ),
                                  Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.transparent,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto-Medium'),
                                  ),
                                  GestureDetector(
                                    onDoubleTap: (){},
                                    onTap: (){
                                      AllCommonApis().addSaveForLater("${snap.data?.data[index].productVariantId}").then((value){
                                        if(mounted){
                                          setState(() {
                                            refresh();
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.05),
                                        child: Text(
                                          "Save for later",
                                          style: TextStyle(
                                              color: CommonColor.APP_BAR_COLOR,
                                              fontSize:
                                                  SizeConfig.blockSizeHorizontal *
                                                      4.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto-Medium'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
          Container(
            height: SizeConfig.screenHeight * 0.13,
            decoration: BoxDecoration(
              color: CommonColor.APP_BAR_COLOR,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 7,
                    spreadRadius: 3,
                    offset: Offset(2, 2.0)),
              ],
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                  topLeft: Radius.circular(15))
            ),
            child: Column(
              children: [
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
                              print(isType);
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
                                      color: CommonColor.WHITE_COLOR,
                                    ),
                                  ),
                                  Visibility(
                                    visible: isType == "1" ? true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: SizeConfig.screenWidth * 0.00277),
                                      child: Icon(
                                        Icons.circle,
                                        color: CommonColor.WHITE_COLOR,
                                        size: SizeConfig.blockSizeHorizontal * 3.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.02),
                                child: Text(
                                  "Door Step Delivery",
                                  style: TextStyle(
                                      color: Colors.white,
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
                              print(isType);
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
                                        color: CommonColor.WHITE_COLOR,
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
                                        color: CommonColor.WHITE_COLOR,
                                        size: SizeConfig.blockSizeHorizontal * 3.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.02),
                                child: Text(
                                  "PickUp From Store",
                                  style: TextStyle(
                                      color: Colors.white,
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
                Padding(
                  padding: EdgeInsets.only(top: parentHeight*0.013),
                  child: Container(
                    height: parentHeight*0.0001,
                    color: Colors.white,

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: parentHeight*0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.01,
                            left: SizeConfig.screenWidth * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rs.$totalCartAmount",
                              style: TextStyle(
                                  color: CommonColor.WHITE_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                  fontFamily: 'Roboto_Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.005),
                              child: Text(
                                totalCartsCount != null
                                    ? "$totalCartsCount Item"
                                    : "0 Items",
                                style: TextStyle(
                                    color: CommonColor.WHITE_COLOR,
                                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: SizeConfig.screenWidth * 0.05),
                        child: GestureDetector(
                          
                          onTap: () {
                            if(isType != "0"){
                              if(isType == "1"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCheckPayParentScreen(
                                          index: 0,
                                          totalAmount: totalCartAmount,
                                          itemCount: totalCartsCount ?? 0,
                                          orderFormat: isType, addressId: '',
                                        ))).then((value){
                                  if(mounted){
                                    setState(() {
                                      refresh();
                                    });
                                  }
                                });
                              }else if(isType == "2"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCheckPayParentScreen(
                                          index: 1,
                                          totalAmount: totalCartAmount,
                                          itemCount: totalCartsCount ?? 0,
                                          orderFormat: isType, addressId: '',
                                        ))).then((value){
                                  if(mounted){
                                    setState(() {
                                      refresh();
                                    });
                                  }
                                });
                              }

                            }else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("Please Select Your Order Format.")));
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: CommonColor.WHITE_COLOR,
                                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                                      fontFamily: 'Roboto_Bold',
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.01),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: CommonColor.WHITE_COLOR,
                                    size: SizeConfig.screenHeight * 0.02,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Future<GetUserCartResponseModel> getAllCarts() async {

    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    // var response = await http.post(
    //     Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
    //     body: {
    //       "accesskey": "90336",
    //       "get_user_cart": "1",
    //       "user_id": id,
    //       "offset": "0",
    //       "limit": "10"
    //     },
    //     headers: headersList);

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
      body: {
        "accesskey": "90336",
        "get_user_cart": "1",
        "user_id": id,
        "offset": "0",
        "limit": "10"
      },
        headers: headersList).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllCartsOfUser -->  $body");
      print("getAllCartsOfUsersssss -->  ${jsonData['message']}");

      if (jsonData['message'] == "No item(s) found in user cart!") {
        if (mounted) {
          setState(() {
            totalCartsCount = 0;
          });
        }
      }

      return getUserCartResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future addToCartApi(String pi, String pvi, String count) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
          body: {
            "accesskey": ApiConstants().accessKey,
            "add_to_cart": "1",
            "user_id": id,
            "product_id": pi,
            "product_variant_id": pvi,
            "qty": count
          },
          headers: headersList);
      var pdfText = await json.decode(json.encode(result.body));

      var jsonData = json.decode(result.body);

      if (jsonData['message'] == "Item removed user cart due to 0 quantity") {
        print("object");
        var result = getAllCarts();
        result.then((value) {
          if (mounted) {
            setState(() {
              totalCartsCount = value.data.length != 0 ? value.data.length : 0;
            });
          }
        });
      }

      print("yaahoooo $pdfText");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }

  Future removeToCartApi(String pvi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
          body: {
            "accesskey": ApiConstants().accessKey,
            "remove_from_cart": "1",
            "user_id": id,
            "product_variant_id": pvi
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body));
      var jsonData = json.decode(result.body);
      print("removeCart ${jsonData['message']}");

      if (jsonData['message'] == "Item removed from user cart successfully") {
        print("objects");
        var result = getAllCarts();
        result.then((value) {
          if (mounted) {
            setState(() {
              totalCartsCount = value.data.length != 0 ? value.data.length : 0;
            });
          }
        });
      }

      return pdfText;
    } catch (e) {
      throw e;
    }
  }
}
