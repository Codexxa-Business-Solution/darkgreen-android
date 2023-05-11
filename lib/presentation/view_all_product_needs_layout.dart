import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/categories/get_similar_product_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:darkgreen/presentation/search_screen.dart';
import 'package:flutter/material.dart';

class ViewAllProductsAndNeeds extends StatefulWidget {
  final String proId;
  final String catId;

  const ViewAllProductsAndNeeds({Key? key, required this.proId, required this.catId})
      : super(key: key);

  @override
  State<ViewAllProductsAndNeeds> createState() => _ViewAllProductsAndNeeds();
}

class _ViewAllProductsAndNeeds extends State<ViewAllProductsAndNeeds> {


  int price = 0;
  int discountPrice = 0;
  int savingPrice = 0;
  int cartCount = 0;

  String productId = "";
  String productVariantId = "";
  String productName = "";
  int favTap = 0;

  bool _isDialogVisible = false;




  @override
  void initState() {
    super.initState();
    AllCommonApis().getSimilarProductByIdApi(widget.proId, widget.catId);
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
              child: getAddMainHeadingLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
          Container(
            color: CommonColor.WHITE_COLOR,
            height: SizeConfig.screenHeight * 0.88,
            child: /*GetAllProducts(getSubCatId: widget.subCatId,),*/
            FutureBuilder<GetSimilarProductResponseModel>(
              future: AllCommonApis().getSimilarProductByIdApi(widget.proId, widget.catId),
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
                                      )));
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
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
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
                                                                  setState(() {});
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
                                                                  setState(() {});
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
                                              setState(() {});
                                            });
                                          },
                                          child: Container(
                                            height: SizeConfig.screenHeight *
                                                0.06,
                                            width:
                                            SizeConfig.screenWidth * 0.13,
                                            decoration: const BoxDecoration(
                                                color:
                                                CommonColor.APP_BAR_COLOR,
                                                borderRadius:
                                                BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10),
                                                )),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
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
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .025,
                color: CommonColor.WHITE_COLOR,
              ),
            ),
          ),
          Text(
            "",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
              fontFamily: 'Roboto_Medium',
              fontWeight: FontWeight.w400,
              color: CommonColor.WHITE_COLOR,
            ),
          ),
          Container(
            width: SizeConfig.screenWidth*0.18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const SearchProduct()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.search_outlined,
                      color: CommonColor.WHITE_COLOR,
                      size: SizeConfig.screenHeight*0.035,
                    ),
                  ),
                ),
                GestureDetector(
                  
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const Cart()));
                  },
                  child: Container(
                      color: Colors.transparent,
                      child: Image(
                        image: const AssetImage("assets/images/trolly.png"),
                        height: parentHeight * 0.03,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget getCategoryProductGridLayout(double parentHeight, double parentWidth) {
  //   return FutureBuilder<GetSimilarProductResponseModel>(
  //     future: AllCommonApis().getSimilarProductByIdApi(widget.proId, widget.catId),
  //     builder: (context, snap) {
  //       if (!snap.hasData && !snap.hasError) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //
  //       final data = snap.data;
  //
  //       if (data == null) {
  //         return const Center(
  //           child: Text("Something Went Wrong!"),
  //         );
  //       }
  //
  //       return GridView.builder(
  //           padding: EdgeInsets.only(
  //             bottom: parentHeight * 0.05,
  //             top: parentHeight * 0.03,
  //             left: parentWidth * 0.03,
  //             right: parentWidth * 0.03,
  //           ),
  //           shrinkWrap: true,
  //           itemCount: snap.data?.data.length,
  //           gridDelegate:
  //           SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
  //               crossAxisCount: 2,
  //               mainAxisSpacing: 5,
  //               height: parentHeight * 0.27),
  //           itemBuilder: (context, index) {
  //             final img = data.data[index].image.isNotEmpty
  //                 ? Image.network(
  //               "${data.data[index].image}",
  //             )
  //                 : Image.network("");
  //
  //             return Padding(
  //               padding: EdgeInsets.only(
  //                   top: parentHeight * 0.01,
  //                   bottom: parentHeight * 0.01,
  //                   left: parentWidth * 0.05),
  //               child: GestureDetector(
  //                 
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => ProductInfoScreen(
  //                             productId:
  //                             "${snap.data?.data[index].id}",
  //                             catId: "",
  //                           )));
  //                 },
  //                 child: Container(
  //                   height: parentHeight * 0.17,
  //                   width: parentWidth * 0.47,
  //                   decoration: BoxDecoration(
  //                     color: CommonColor.WHITE_COLOR,
  //                     borderRadius: BorderRadius.circular(10),
  //                     boxShadow: <BoxShadow>[
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.17),
  //                         spreadRadius: 3,
  //                         blurRadius: 5,
  //                         offset: const Offset(2, 1),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Stack(
  //                         children: [
  //                           Container(
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 color: Colors.white,
  //                               ),
  //                               height: parentHeight * 0.17,
  //                               width: parentWidth * 0.47,
  //                               child: ClipRRect(
  //                                 borderRadius: const BorderRadius.only(
  //                                   topLeft: Radius.circular(10),
  //                                   topRight: Radius.circular(10),
  //                                 ),
  //                                 child: img,
  //                               )),
  //                           Padding(
  //                             padding:
  //                             EdgeInsets.only(top: parentHeight * 0.015),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                               MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   width: parentWidth * 0.15,
  //                                   height: parentHeight * 0.027,
  //                                   decoration: const BoxDecoration(
  //                                       color: CommonColor.APP_BAR_COLOR,
  //                                       borderRadius: BorderRadius.only(
  //                                           topRight: Radius.circular(5),
  //                                           bottomRight: Radius.circular(5))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         "$savingPrice \u{20B9} off",
  //                                         style: TextStyle(
  //                                             color: CommonColor.WHITE_COLOR,
  //                                             fontSize: SizeConfig
  //                                                 .blockSizeHorizontal *
  //                                                 3.5,
  //                                             fontWeight: FontWeight.w400,
  //                                             fontFamily: 'Roboto_Regular'),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 snap.data?.data[index]
  //                                     .isFavorite ==
  //                                     true
  //                                     ? Padding(
  //                                   padding: EdgeInsets.only(
  //                                       right: SizeConfig
  //                                           .screenWidth *
  //                                           0.02),
  //                                   child: GestureDetector(
  //                                     
  //                                     onTap: () {
  //                                       productId =
  //                                       "${snap.data?.data[index].variants[0].productId}";
  //
  //                                       productName = "${snap.data?.data[0].name}";
  //
  //                                       favTap = 0;
  //
  //                                       var result =
  //                                       AllCommonApis()
  //                                           .removeToFavorite(
  //                                           productId);
  //
  //                                       result.then((value) {
  //                                         if (mounted) {
  //                                           setState(() {
  //                                             _isDialogVisible = true;
  //
  //                                             Future.delayed(const Duration(seconds: 2), () {
  //                                               setState(() {
  //                                                 _isDialogVisible = false;
  //                                               });
  //                                             });
  //                                           });
  //                                         }
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       color: Colors
  //                                           .transparent,
  //                                       child: const Icon(
  //                                         Icons
  //                                             .favorite_rounded,
  //                                         color: CommonColor
  //                                             .LIKE_COLOR,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 )
  //                                     : Padding(
  //                                   padding: EdgeInsets.only(
  //                                       right: SizeConfig
  //                                           .screenWidth *
  //                                           0.02),
  //                                   child: GestureDetector(
  //                                     
  //                                     onTap: () {
  //                                       productId =
  //                                       "${snap.data?.data[index].variants[0].productId}";
  //
  //                                       productName = "${snap.data?.data[0].name}";
  //
  //                                       favTap = 1;
  //
  //                                       var result =
  //                                       AllCommonApis()
  //                                           .addToFavorite(
  //                                           productId);
  //
  //                                       result.then((value) {
  //                                         if (mounted) {
  //                                           setState(() {
  //                                             _isDialogVisible = true;
  //
  //                                             Future.delayed(const Duration(seconds: 2), () {
  //                                               setState(() {
  //                                                 _isDialogVisible = false;
  //                                               });
  //                                             });
  //                                           });
  //                                         }
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       color: Colors
  //                                           .transparent,
  //                                       child: const Icon(
  //                                         Icons
  //                                             .favorite_outline_rounded,
  //                                         color: CommonColor
  //                                             .LIKE_COLOR,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       Stack(
  //                         alignment: Alignment.bottomRight,
  //                         children: [
  //                           Container(
  //                             height: parentHeight * 0.13,
  //                             width: parentWidth * 0.47,
  //                             decoration: const BoxDecoration(
  //                                 color: CommonColor
  //                                     .LAYOUT_BACKGROUND_COLOR,
  //                                 borderRadius: BorderRadius.only(
  //                                   bottomLeft: Radius.circular(10),
  //                                   bottomRight: Radius.circular(10),
  //                                 )),
  //                             child: Column(
  //                               children: [
  //                                 Padding(
  //                                   padding: EdgeInsets.only(
  //                                       top: SizeConfig
  //                                           .screenHeight *
  //                                           0.01,
  //                                       left:
  //                                       SizeConfig.screenWidth *
  //                                           0.02),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment.start,
  //                                     children: [
  //                                       Container(
  //                                         width: SizeConfig
  //                                             .screenWidth *
  //                                             0.4,
  //                                         color: Colors.transparent,
  //                                         child: Text(
  //                                           "${snap.data?.data[index].name}",
  //                                           style: TextStyle(
  //                                               color: Colors.black,
  //                                               fontSize: SizeConfig
  //                                                   .blockSizeHorizontal *
  //                                                   3.5,
  //                                               fontFamily:
  //                                               'Roboto_Normal',
  //                                               fontWeight:
  //                                               FontWeight
  //                                                   .w400),
  //                                           textAlign:
  //                                           TextAlign.start,
  //                                           maxLines: 2,
  //                                           overflow: TextOverflow
  //                                               .ellipsis,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.only(
  //                                       top: parentHeight * 0.01,
  //                                       left: parentWidth * 0.02),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         "Rs ${snap.data?.data[index].variants[0].price}",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: SizeConfig
  //                                                 .blockSizeHorizontal *
  //                                                 3.5,
  //                                             fontFamily: 'Roboto_Normal',
  //                                             fontWeight: FontWeight.w500),
  //                                         textAlign: TextAlign.center,
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                             left: parentWidth * 0.02),
  //                                         child: Text(
  //                                           "Rs ${snap.data?.data[index].variants[0].discountedPrice}",
  //                                           style: TextStyle(
  //                                               color: CommonColor
  //                                                   .DISCOUNT_COLOR,
  //                                               fontSize: SizeConfig
  //                                                   .blockSizeHorizontal *
  //                                                   3.0,
  //                                               fontFamily: 'Roboto_Normal',
  //                                               fontWeight: FontWeight.w500,
  //                                               decoration: TextDecoration
  //                                                   .lineThrough),
  //                                           textAlign: TextAlign.center,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.only(
  //                                       top: parentHeight * 0.015,
  //                                       left: parentWidth * 0.02,
  //                                       right: parentWidth * 0.02),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Container(
  //                                         height: parentHeight * 0.033,
  //                                         width: parentWidth * 0.13,
  //                                         decoration: BoxDecoration(
  //                                             color: CommonColor
  //                                                 .REVIEW_CONTAINER_COLOR,
  //                                             borderRadius:
  //                                             BorderRadius.circular(7)),
  //                                         child: Row(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.center,
  //                                           children: [
  //                                             Text(
  //                                               "${snap.data?.data[index].ratings}",
  //                                               style: TextStyle(
  //                                                   color: Colors.black,
  //                                                   fontSize: SizeConfig
  //                                                       .blockSizeHorizontal *
  //                                                       3.5,
  //                                                   fontWeight:
  //                                                   FontWeight.w400,
  //                                                   fontFamily:
  //                                                   'Roboto_Medium'),
  //                                             ),
  //                                             Icon(
  //                                               Icons.star,
  //                                               color:
  //                                               CommonColor.REVIEW_COLOR,
  //                                               size: parentHeight * 0.02,
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       Visibility(
  //                                         visible: snap
  //                                             .data
  //                                             ?.data[index]
  //                                             .variants[0]
  //                                             .cartCount !=
  //                                             "0"
  //                                             ? true
  //                                             : false,
  //                                         child: Row(
  //                                           children: [
  //                                             GestureDetector(
  //                                               
  //                                               onTap: () {
  //                                                 productId =
  //                                                 "${snap.data?.data[index].variants[0].productId}";
  //
  //                                                 productVariantId =
  //                                                 "${snap.data?.data[index].variants[0].id}";
  //
  //                                                 cartCount = int.parse(
  //                                                     "${snap.data?.data[index].variants[0].cartCount}");
  //
  //                                                 cartCount--;
  //
  //                                                 snap
  //                                                     .data
  //                                                     ?.data[index]
  //                                                     .variants[0]
  //                                                     .cartCount =
  //                                                     cartCount
  //                                                         .toString();
  //
  //                                                 AllCommonApis()
  //                                                     .addToCartApi(
  //                                                     productId,
  //                                                     productVariantId,
  //                                                     cartCount
  //                                                         .toString())
  //                                                     .then(
  //                                                         (value) {
  //                                                       setState(() {});
  //                                                     });
  //                                               },
  //                                               child: Container(
  //                                                 height: SizeConfig
  //                                                     .screenHeight *
  //                                                     0.035,
  //                                                 width: SizeConfig
  //                                                     .screenWidth *
  //                                                     0.07,
  //                                                 decoration: BoxDecoration(
  //                                                     color: CommonColor
  //                                                         .APP_BAR_COLOR,
  //                                                     borderRadius:
  //                                                     BorderRadius
  //                                                         .circular(
  //                                                         5)),
  //                                                 child: Center(
  //                                                     child: Text(
  //                                                       "-",
  //                                                       style: TextStyle(
  //                                                           color: CommonColor
  //                                                               .WHITE_COLOR,
  //                                                           fontSize:
  //                                                           SizeConfig.blockSizeHorizontal *
  //                                                               5.6),
  //                                                       textScaleFactor:
  //                                                       1.0,
  //                                                     )),
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               height: SizeConfig
  //                                                   .screenHeight *
  //                                                   0.035,
  //                                               width: SizeConfig
  //                                                   .screenWidth *
  //                                                   0.07,
  //                                               decoration: BoxDecoration(
  //                                                   color: CommonColor
  //                                                       .WHITE_COLOR,
  //                                                   borderRadius:
  //                                                   BorderRadius
  //                                                       .circular(
  //                                                       5)),
  //                                               child: Center(
  //                                                   child: Text(
  //                                                     "${snap.data?.data[index].variants[0].cartCount}",
  //                                                     style: TextStyle(
  //                                                         color: CommonColor
  //                                                             .BLACK_COLOR,
  //                                                         fontSize:
  //                                                         SizeConfig
  //                                                             .blockSizeHorizontal *
  //                                                             3.5),
  //                                                     textScaleFactor:
  //                                                     1.0,
  //                                                   )),
  //                                             ),
  //                                             GestureDetector(
  //                                               
  //                                               onTap: () {
  //                                                 productId =
  //                                                 "${snap.data?.data[index].variants[0].productId}";
  //                                                 productVariantId =
  //                                                 "${snap.data?.data[index].variants[0].id}";
  //
  //                                                 cartCount = int.parse(
  //                                                     "${snap.data?.data[index].variants[0].cartCount}");
  //
  //                                                 cartCount++;
  //
  //                                                 snap
  //                                                     .data
  //                                                     ?.data[index]
  //                                                     .variants[0]
  //                                                     .cartCount =
  //                                                     cartCount
  //                                                         .toString();
  //
  //                                                 AllCommonApis()
  //                                                     .addToCartApi(
  //                                                     productId,
  //                                                     productVariantId,
  //                                                     cartCount
  //                                                         .toString())
  //                                                     .then(
  //                                                         (value) {
  //                                                       setState(() {});
  //                                                     });
  //                                               },
  //                                               child: Container(
  //                                                 height: SizeConfig
  //                                                     .screenHeight *
  //                                                     0.035,
  //                                                 width: SizeConfig
  //                                                     .screenWidth *
  //                                                     0.07,
  //                                                 decoration: BoxDecoration(
  //                                                     color: CommonColor
  //                                                         .APP_BAR_COLOR,
  //                                                     borderRadius:
  //                                                     BorderRadius
  //                                                         .circular(
  //                                                         5)),
  //                                                 child: Center(
  //                                                     child: Text(
  //                                                       "+",
  //                                                       style: TextStyle(
  //                                                           color: CommonColor
  //                                                               .WHITE_COLOR,
  //                                                           fontSize:
  //                                                           SizeConfig.blockSizeHorizontal *
  //                                                               5.0),
  //                                                       textScaleFactor:
  //                                                       1.0,
  //                                                     )),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                           Visibility(
  //                             visible: snap.data?.data[index]
  //                                 .variants[0].cartCount ==
  //                                 "0"
  //                                 ? true
  //                                 : false,
  //                             child: GestureDetector(
  //                               
  //                               onTap: () {
  //                                 productId =
  //                                 "${snap.data?.data[index].variants[0].productId}";
  //
  //                                 productVariantId =
  //                                 "${snap.data?.data[index].variants[0].id}";
  //
  //                                 cartCount = int.parse(
  //                                     "${snap.data?.data[index].variants[0].cartCount}");
  //
  //                                 cartCount++;
  //
  //                                 snap.data?.data[index].variants[0]
  //                                     .cartCount =
  //                                     cartCount.toString();
  //
  //                                 AllCommonApis()
  //                                     .addToCartApi(
  //                                     productId,
  //                                     productVariantId,
  //                                     cartCount.toString())
  //                                     .then((value) {
  //                                   setState(() {});
  //                                 });
  //                               },
  //                               child: Container(
  //                                 height: SizeConfig.screenHeight *
  //                                     0.06,
  //                                 width:
  //                                 SizeConfig.screenWidth * 0.13,
  //                                 decoration: const BoxDecoration(
  //                                     color:
  //                                     CommonColor.APP_BAR_COLOR,
  //                                     borderRadius:
  //                                     BorderRadius.only(
  //                                       bottomRight:
  //                                       Radius.circular(10),
  //                                       topLeft:
  //                                       Radius.circular(10),
  //                                     )),
  //                                 child: const Icon(
  //                                   Icons.add,
  //                                   color: Colors.white,
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           });
  //     },
  //   );
  // }

}
