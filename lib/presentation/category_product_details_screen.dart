import 'dart:convert';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/categories/get_product_by_cat_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:darkgreen/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPriceDetails extends StatefulWidget {
  final String subProName;
  final String subCatId;

  const ProductPriceDetails(
      {Key? key, required this.subProName, required this.subCatId})
      : super(key: key);

  @override
  State<ProductPriceDetails> createState() => _ProductPriceDetailsState();
}

class _ProductPriceDetailsState extends State<ProductPriceDetails> {
  bool isFav = false;
  int count = 0;
  int currentIndex = 0;
  String productId = "";
  String productVariantId = "";
  int price = 0;
  int discountPrice = 0;
  int savingPrice = 0;

  int cartCount = 0;
  int totalCartCount = 0;
  int addCartValue = 0;

  int favTap = 0;
  bool _isDialogVisible = false;
  String productName = "";

  @override
  void initState() {
    super.initState();
    AllCommonApis().productByCategoriesApi(widget.subCatId);
    if(mounted){
      setState(() {
        AllCommonApis().getAllCarts().then((value){
          if(mounted){
            setState(() {
              totalCartCount = value.data.length;
              print(totalCartCount);
            });
          }
        });
      });
    }
  }

  Future<Null> refreshList() async {
    await Future.delayed(const Duration(seconds: 1));

    var result = AllCommonApis().productByCategoriesApi(widget.subCatId);

    result.then((value) {
      setState(() {});
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: CommonColor.APP_BAR_COLOR,
              height: SizeConfig.screenHeight * 0.12,
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05, left: SizeConfig.screenWidth*0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth*0.12,
                      decoration: BoxDecoration(
                        color: CommonColor.CIRCLE_COLOR,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/images/appLogo.jpeg",),
                          fit: BoxFit.contain,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.screenHeight * 0.01),
                      child: Container(
                        color: Colors.transparent,
                        width: SizeConfig.screenWidth*0.6,
                        child: Center(
                          child: Text(widget.subProName,
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                fontFamily: "Roboto_Medium",
                                fontWeight: FontWeight.w500,
                                color: CommonColor.WHITE_COLOR
                            ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.01),
                      child: Container(
                        width: SizeConfig.screenWidth*0.2,
                        // color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct())).then((value){
                                  setState(() {
                                    if(mounted){
                                      setState(() {
                                        AllCommonApis().getAllCarts().then((value) {
                                          if (mounted) {
                                            setState(() {
                                              totalCartCount = value.data.length;
                                              print(cartCount);
                                            });
                                          }
                                        });
                                      });
                                    }
                                  });
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Icon(Icons.search,
                                  color: Colors.white,
                                  size: SizeConfig.screenHeight*0.035,),
                              ),
                            ),
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())).then((value){
                                  if(mounted){
                                    setState(() {
                                      AllCommonApis().productByCategoriesApi(widget.subCatId);
                                      AllCommonApis().getAllCarts().then((value) {
                                        if (mounted) {
                                          setState(() {
                                            totalCartCount = value.data.length;
                                            print(cartCount);
                                          });
                                        }
                                      });
                                    });
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01),
                                      child: Container(
                                        height: SizeConfig.screenHeight*0.05,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(image: AssetImage("assets/images/trolly.png"),
                                            height: SizeConfig.screenHeight*0.03,),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: totalCartCount == 0 ? false : true,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.04, right: SizeConfig.screenWidth*0.005),
                                        child: Container(
                                          height: SizeConfig.screenHeight*0.05,
                                          width: SizeConfig.screenWidth*0.05,
                                          decoration: BoxDecoration(
                                              color: CommonColor.WHITE_COLOR,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: CommonColor.APP_BAR_COLOR)
                                          ),
                                          child: Center(
                                            child: Text("$totalCartCount",
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),),
          RefreshIndicator(
            color: CommonColor.REFRESH_INDICATOR_COLOR,
            onRefresh: () async {
              await refreshList();
            },
            child: Container(
              color: CommonColor.WHITE_COLOR,
              height: SizeConfig.screenHeight * 0.88,
              child: /*GetAllProducts(getSubCatId: widget.subCatId,),*/
                  FutureBuilder<GetProductsByCategoriesResponseModel>(
                future: AllCommonApis().productByCategoriesApi(widget.subCatId),
                builder: (context, snap) {
                  if (!snap.hasData && !snap.hasError) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final data = snap.data;

                  if (data == null) {
                    return const Center(
                      child: Text("Something Went Wrong!"),
                    );
                  }

                  return Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                    child: GridView.builder(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.screenHeight * 0.05,
                          top: SizeConfig.screenHeight * 0.03,
                          left: SizeConfig.screenWidth * 0.0,
                          right: SizeConfig.screenWidth * 0.03,
                        ),
                        shrinkWrap: true,
                        itemCount: snap.data?.data.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                height: SizeConfig.screenHeight * 0.33),
                        itemBuilder: (context, index) {
                          final img = snap.data?.data[index].image != null
                              ? Image.network(
                                  "${snap.data?.data[index].image}",
                            fit: BoxFit.fill,
                                )
                              : Image.network("");

                          price = int.parse("${snap.data?.data[index].variants[0].price}");
                          discountPrice = int.parse("${snap.data?.data[index].variants[0].discountedPrice}");
                          savingPrice = price - discountPrice;

                          return Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.01,
                                bottom: SizeConfig.screenHeight * 0.01,
                                left: SizeConfig.screenWidth * 0.05),
                            child: GestureDetector(
                              
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductInfoScreen(
                                              productId:
                                                  "${snap.data?.data[index].id}",
                                              catId: "",
                                            ))).then((value){
                                  if(mounted){
                                    setState(() {
                                      AllCommonApis().productByCategoriesApi(widget.subCatId);
                                      AllCommonApis().getAllCarts().then((value) {
                                        if (mounted) {
                                          setState(() {
                                            totalCartCount = value.data.length;
                                            print(cartCount);
                                          });
                                        }
                                      });
                                    });
                                  }
                                });
                              },
                              child: Container(
                                height: SizeConfig.screenHeight * 0.17,
                                width: SizeConfig.screenWidth * 0.47,
                                decoration: BoxDecoration(
                                  color: CommonColor.WHITE_COLOR,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.17),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(2, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            height:
                                                SizeConfig.screenHeight * 0.18,
                                            width:
                                                SizeConfig.screenWidth * 0.47,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: img,
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: SizeConfig.screenHeight *
                                                  0.015),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: SizeConfig.screenWidth *
                                                    0.15,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.027,
                                                decoration: const BoxDecoration(
                                                    color: CommonColor
                                                        .APP_BAR_COLOR,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "$savingPrice \u{20B9} off",
                                                      style: TextStyle(
                                                          color: CommonColor
                                                              .WHITE_COLOR,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Roboto_Regular'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              snap.data?.data[index]
                                                          .isFavorite ==
                                                      true
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .screenWidth *
                                                              0.02),
                                                      child: GestureDetector(
                                                        
                                                        onTap: () {
                                                          productId =
                                                              "${snap.data?.data[index].variants[0].productId}";

                                                          productName = "${snap.data?.data[0].name}";

                                                          favTap = 0;

                                                          var result =
                                                              AllCommonApis()
                                                                  .removeToFavorite(
                                                                      productId);

                                                          result.then((value) {
                                                            if (mounted) {
                                                              setState(() {
                                                                _isDialogVisible = true;

                                                                Future.delayed(const Duration(seconds: 2), () {
                                                                  setState(() {
                                                                    _isDialogVisible = false;
                                                                  });
                                                                });
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: const Icon(
                                                            Icons
                                                                .favorite_rounded,
                                                            color: CommonColor
                                                                .LIKE_COLOR,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .screenWidth *
                                                              0.02),
                                                      child: GestureDetector(
                                                        
                                                        onTap: () {
                                                          productId =
                                                              "${snap.data?.data[index].variants[0].productId}";

                                                          productName = "${snap.data?.data[0].name}";

                                                          favTap = 1;

                                                          var result =
                                                              AllCommonApis()
                                                                  .addToFavorite(
                                                                      productId);

                                                          result.then((value) {
                                                            if (mounted) {
                                                              setState(() {
                                                                _isDialogVisible = true;

                                                                Future.delayed(const Duration(seconds: 2), () {
                                                                  setState(() {
                                                                    _isDialogVisible = false;
                                                                  });
                                                                });
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: const Icon(
                                                            Icons
                                                                .favorite_outline_rounded,
                                                            color: CommonColor
                                                                .LIKE_COLOR,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.screenHeight * 0.13,
                                          width: SizeConfig.screenWidth * 0.47,
                                          decoration: const BoxDecoration(
                                              color: CommonColor
                                                  .LAYOUT_BACKGROUND_COLOR,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.01,
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.4,
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        "${snap.data?.data[index].name}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.5,
                                                            fontFamily:
                                                                'Roboto_Normal',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.01,
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Rs ${snap.data?.data[index].variants[0].discountedPrice}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.5,
                                                          fontFamily:
                                                              'Roboto_Normal',
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .screenWidth *
                                                              0.02),
                                                      child: Text(
                                                        "Rs ${snap.data?.data[index].price}",
                                                        style: TextStyle(
                                                            color: CommonColor
                                                                .DISCOUNT_COLOR,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.0,
                                                            fontFamily:
                                                                'Roboto_Normal',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.015,
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.02,
                                                    right:
                                                        SizeConfig.screenWidth *
                                                            0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.035,
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.13,
                                                      decoration: BoxDecoration(
                                                          color: CommonColor
                                                              .REVIEW_CONTAINER_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: SizeConfig
                                                                        .screenWidth *
                                                                    0.02),
                                                            child: Text(
                                                              "${snap.data?.data[index].ratings}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          3.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Roboto_Medium'),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                right: SizeConfig
                                                                        .screenWidth *
                                                                    0.015),
                                                            child: Icon(
                                                              Icons.star,
                                                              color: CommonColor
                                                                  .REVIEW_COLOR,
                                                              size: SizeConfig
                                                                      .screenHeight *
                                                                  0.018,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: snap
                                                                  .data
                                                                  ?.data[index]
                                                                  .variants[0]
                                                                  .cartCount !=
                                                              "0"
                                                          ? true
                                                          : false,
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            
                                                            onTap: () {
                                                              productId =
                                                                  "${snap.data?.data[index].variants[0].productId}";

                                                              productVariantId =
                                                                  "${snap.data?.data[index].variants[0].id}";

                                                              cartCount = int.parse(
                                                                  "${snap.data?.data[index].variants[0].cartCount}");

                                                              cartCount--;

                                                              snap
                                                                      .data
                                                                      ?.data[index]
                                                                      .variants[0]
                                                                      .cartCount =
                                                                  cartCount
                                                                      .toString();

                                                              AllCommonApis()
                                                                  .addToCartApi(
                                                                      productId,
                                                                      productVariantId,
                                                                      cartCount
                                                                          .toString())
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  if(mounted){
                                                                    setState(() {
                                                                      AllCommonApis().getAllCarts().then((value) {
                                                                        if (mounted) {
                                                                          setState(() {
                                                                            totalCartCount = value.data.length;
                                                                            print(totalCartCount);
                                                                          });
                                                                        }
                                                                      });
                                                                    });
                                                                  }
                                                                });
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
                                                              "${snap.data?.data[index].variants[0].cartCount}",
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
                                                            
                                                            onTap: () {
                                                              productId =
                                                                  "${snap.data?.data[index].variants[0].productId}";
                                                              productVariantId =
                                                                  "${snap.data?.data[index].variants[0].id}";

                                                              cartCount = int.parse(
                                                                  "${snap.data?.data[index].variants[0].cartCount}");

                                                              cartCount++;

                                                              snap
                                                                      .data
                                                                      ?.data[index]
                                                                      .variants[0]
                                                                      .cartCount =
                                                                  cartCount
                                                                      .toString();

                                                              AllCommonApis()
                                                                  .addToCartApi(
                                                                      productId,
                                                                      productVariantId,
                                                                      cartCount
                                                                          .toString())
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  if(mounted){
                                                                    setState(() {
                                                                      AllCommonApis().getAllCarts().then((value) {
                                                                        if (mounted) {
                                                                          setState(() {
                                                                            totalCartCount = value.data.length;
                                                                            print(cartCount);
                                                                          });
                                                                        }
                                                                      });
                                                                    });
                                                                  }
                                                                });
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
                                              )
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: snap.data?.data[index]
                                                      .variants[0].cartCount ==
                                                  "0"
                                              ? true
                                              : false,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.03,
                                            bottom: SizeConfig.screenHeight*0.01),
                                            child: GestureDetector(
                                              onTap: () {
                                                productId =
                                                    "${snap.data?.data[index].variants[0].productId}";

                                                productVariantId =
                                                    "${snap.data?.data[index].variants[0].id}";

                                                cartCount = int.parse(
                                                    "${snap.data?.data[index].variants[0].cartCount}");

                                                cartCount++;

                                                snap.data?.data[index].variants[0]
                                                        .cartCount =
                                                    cartCount.toString();

                                                AllCommonApis()
                                                    .addToCartApi(
                                                        productId,
                                                        productVariantId,
                                                        cartCount.toString())
                                                    .then((value) {
                                                  setState(() {
                                                    AllCommonApis().getAllCarts().then((value) {
                                                      if (mounted) {
                                                        setState(() {
                                                          totalCartCount = value.data.length;
                                                          print(totalCartCount);
                                                        });
                                                      }
                                                    });
                                                  });
                                                });
                                              },
                                              child: Container(
                                                height: SizeConfig.screenHeight *
                                                    0.04,
                                                width:
                                                    SizeConfig.screenWidth * 0.09,
                                                decoration: BoxDecoration(
                                                    color:
                                                        CommonColor.APP_BAR_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child:  Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: SizeConfig.screenHeight*0.025,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ),
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
                  title: Text(favTap == 0
                      ? "Removed From Favorites"
                      : "Added To Favorites"),
                  content: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: productName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CommonColor.APP_BAR_COLOR)),
                        TextSpan(
                            text: favTap == 0
                                ? " remove this product from favorite list."
                                : " add this product from favorite list.",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: CommonColor.BLACK_COLOR)),
                      ],
                    ),
                  )),
            )
          : null,
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * .05,
          left: parentWidth * 0.05,
          right: parentWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            
            child: Container(
              color: Colors.transparent,
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .025,
                color: CommonColor.WHITE_COLOR,
              ),
            ),
          ),
          Text(
            "Edible Oil",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
              fontFamily: 'Roboto_Medium',
              fontWeight: FontWeight.w400,
              color: CommonColor.WHITE_COLOR,
            ),
          ),
          Container(
            color: Colors.transparent,
            child: const Icon(
              Icons.search_outlined,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
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

      print("$pdfText");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }
}
