import 'dart:async';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/search/search.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  bool isFav = false;
  int count = 0;
  bool showCancle = false;
  bool focusText = false;
  TextEditingController searchController = TextEditingController();
  final _searchFocus = FocusNode();
  String productId = "";
  String productVariantId = "";
  int cartCount = 0;
  int offerPrice = 0;
  int totalCartCount = 0;

  bool showAlertDialog = true;
  String productName = "";
  int favTap = 0;

  bool _isDialogVisible = false;

  removeSearch() {
    if (searchController.text.trim().length > 0) {
      if (mounted) {
        setState(() {
          showCancle = true;
          _searchFocus.hasFocus;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          showCancle = false;
          _searchFocus.hasFocus;
        });
      }
    }
  }

  _searchTextController() {
    int textLength = searchController.text.length;
    if (textLength > 0 || textLength != 0) {
      AllCommonApis().getAllSearchingProductsApi(searchController.text.trim());
    } else if (textLength == 0) {
      _searchFocus.unfocus();
    }
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));

    var result = AllCommonApis()
        .getAllSearchingProductsApi(searchController.text.trim());

    result.then((value) {
      setState(() {});
    });

    return null;
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(_searchTextController);
    searchController.addListener(removeSearch);
    if (mounted) {
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
  }

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
                color: CommonColor.APP_BAR_COLOR,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 7,
                      spreadRadius: 3,
                      offset: const Offset(2, 2.0))
                ],
              ),
              child:
                  getTopText(SizeConfig.screenHeight, SizeConfig.screenWidth)),
          Container(
              height: SizeConfig.screenHeight * 0.1,
              decoration: const BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: getSearchLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
          Container(
              height: SizeConfig.screenHeight * 0.8,
              child: getSearchingDataLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth)),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CommonColor.APP_BAR_COLOR)),
                        TextSpan(
                            text: favTap == 0
                                ? " remove this product from favorite list."
                                : " add this product from favorite list.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: CommonColor.BLACK_COLOR)),
                      ],
                    ),
                  )),
            )
          : null,
    );
  }

  Widget getTopText(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios_new_rounded,
          color: Colors.white,),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Text(
              "Search Product",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6.0,
                  fontFamily: "Roboto_Medium",
                  fontWeight: FontWeight.w500,
                  color: CommonColor.WHITE_COLOR),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * 0.02),
            child: GestureDetector(
              onDoubleTap: (){},
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())).then((value){
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
              },
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.0),
                      child: Container(
                        height: SizeConfig.screenHeight*0.05,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage("assets/images/trolly.png"),
                            color: Colors.white,
                            height: SizeConfig.screenHeight*0.03,),
                        ),
                      ),
                    ),
                   Visibility(
                     visible: totalCartCount == 0 ? false : true,
                       child:  Padding(
                     padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.025,
                         right: SizeConfig.screenWidth*0.005),
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
                   )
                   )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSearchLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.04,
          left: parentWidth * 0.04,
          right: parentWidth * 0.04),
      child: Container(
          width: parentWidth * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CommonColor.CIRCLE_COLOR, width: 3.0),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: searchController,
            focusNode: _searchFocus,
            onTap: () {
              if (mounted) {
                setState(() {
                  focusText = true;
                });
              }
            },
            onFieldSubmitted: (term) {
              print("searchuser");
              if (mounted) {
                setState(() {
                  showCancle = false;
                });
              }
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: CommonColor.APP_BAR_COLOR,
                ),
                suffixIcon: Visibility(
                    visible: showCancle || _searchFocus.hasFocus,
                    child: GestureDetector(
                      
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            searchController.clear();
                            if (mounted) {
                              setState(() {
                                focusText = false;
                                _searchFocus.unfocus();
                              });
                            }
                          });
                        }
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          )),
                    )),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: focusText == true ? "" : "Search by Product Name",
                hintStyle: TextStyle(
                    color: CommonColor.RS_COLOR,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.2)),
            style: TextStyle(
                color: CommonColor.BLACK_COLOR,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.blockSizeHorizontal * 4.2),
          )),
    );
  }

  Widget getSearchingDataLayout(double parentHeight, double parentWidth) {
    return RefreshIndicator(
      color: CommonColor.REFRESH_INDICATOR_COLOR,
      onRefresh: () async {
        await refreshList();
      },
      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.01),
        child: FutureBuilder<GetSearchProductResponseModel>(
          future: AllCommonApis()
              .getAllSearchingProductsApi(searchController.text.trim()),
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

            print("${snap.data?.data.length}");

            if (snap.data?.data.length == 0) {
              return Center(
                child: Text(
                  "No products available",
                  style: TextStyle(
                      color: CommonColor.BLACK_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto_Bold'),
                ),
              );
            }

            return GridView.builder(
                padding: EdgeInsets.only(
                  bottom: parentHeight * 0.05,
                  top: parentHeight * 0.03,
                  left: parentWidth * 0.0,
                  right: parentWidth * 0.03,
                ),
                shrinkWrap: true,
                itemCount: snap.data?.data.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        height: parentHeight * 0.33),
                itemBuilder: (context, index) {
                  final img = data.data[index].image.isNotEmpty
                      ? Image.network(
                          "${data.data[index].image}",
                        )
                      : Image.network("");

                  offerPrice = int.parse("${snap.data?.data[index].price}") -
                      int.parse(
                          "${snap.data?.data[index].variants[0].discountedPrice}");

                  return Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        bottom: parentHeight * 0.01,
                        left: parentWidth * 0.05),
                    child: GestureDetector(
                      
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductInfoScreen(
                                      productId: "${snap.data?.data[index].id}",
                                      catId: '',
                                    ))).then((value){
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
                      },
                      child: Container(
                        height: parentHeight * 0.17,
                        width: parentWidth * 0.47,
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
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    height: parentHeight * 0.18,
                                    width: parentWidth * 0.47,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: img,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.015),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: parentWidth * 0.15,
                                        height: parentHeight * 0.027,
                                        decoration: const BoxDecoration(
                                            color: CommonColor.APP_BAR_COLOR,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "$offerPrice \u{20B9} off",
                                              style: TextStyle(
                                                  color:
                                                      CommonColor.WHITE_COLOR,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3.5,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      snap.data?.data[index].isFavorite == true
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentWidth * 0.02),
                                              child: GestureDetector(
                                                
                                                onTap: () {
                                                  productId =
                                                      "${snap.data?.data[index].variants[0].productId}";

                                                  productName =
                                                      "${snap.data?.data[index].name}";

                                                  favTap = 0;

                                                  var result = AllCommonApis()
                                                      .removeToFavorite(
                                                          productId);

                                                  result.then((value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        _isDialogVisible = true;

                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          setState(() {
                                                            _isDialogVisible =
                                                                false;
                                                          });
                                                        });
                                                      });
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: const Icon(
                                                    Icons.favorite_rounded,
                                                    color:
                                                        CommonColor.LIKE_COLOR,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentWidth * 0.02),
                                              child: GestureDetector(
                                                
                                                onTap: () {
                                                  productId =
                                                      "${snap.data?.data[index].variants[0].productId}";

                                                  productName =
                                                      "${snap.data?.data[index].name}";

                                                  favTap = 1;

                                                  var result = AllCommonApis()
                                                      .addToFavorite(productId);

                                                  result.then((value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        _isDialogVisible = true;

                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          setState(() {
                                                            _isDialogVisible =
                                                                false;
                                                          });
                                                        });
                                                      });
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: const Icon(
                                                    Icons
                                                        .favorite_outline_rounded,
                                                    color:
                                                        CommonColor.LIKE_COLOR,
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
                                  height: parentHeight * 0.13,
                                  width: parentWidth * 0.47,
                                  decoration: const BoxDecoration(
                                      color:
                                          CommonColor.LAYOUT_BACKGROUND_COLOR,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.01,
                                            left: parentWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: parentWidth * 0.4,
                                              color: Colors.transparent,
                                              child: Text(
                                                "${snap.data?.data[index].name}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3.5,
                                                    fontFamily: 'Roboto_Normal',
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.01,
                                            left: parentWidth * 0.02),
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
                                                  fontFamily: 'Roboto_Normal',
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: parentWidth * 0.02),
                                              child: Text(
                                                "Rs ${snap.data?.data[index].price}",
                                                style: TextStyle(
                                                    color: CommonColor
                                                        .DISCOUNT_COLOR,
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3.0,
                                                    fontFamily: 'Roboto_Normal',
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.015,
                                            left: parentWidth * 0.02,
                                            right: parentWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: parentHeight * 0.035,
                                              width: parentWidth * 0.13,
                                              decoration: BoxDecoration(
                                                  color: CommonColor
                                                      .REVIEW_CONTAINER_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            parentWidth * 0.02),
                                                    child: Text(
                                                      "${snap.data?.data[index].ratings}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Roboto_Medium'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: parentWidth *
                                                            0.015),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: CommonColor
                                                          .REVIEW_COLOR,
                                                      size:
                                                          parentHeight * 0.018,
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
                                                          cartCount.toString();
                                                      AllCommonApis()
                                                          .addToCartApi(
                                                              productId,
                                                              productVariantId,
                                                              cartCount
                                                                  .toString()).then((value){
                                                        if (mounted) {
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

                                                      if (mounted) {
                                                        setState(() {
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height:
                                                          parentHeight * 0.035,
                                                      width: parentWidth * 0.07,
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
                                                      "${snap.data?.data[index].variants[0].cartCount}",
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
                                                          cartCount.toString();
                                                      AllCommonApis()
                                                          .addToCartApi(
                                                              productId,
                                                              productVariantId,
                                                              cartCount
                                                                  .toString()).then((value){
                                                        if (mounted) {
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

                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      height:
                                                          parentHeight * 0.035,
                                                      width: parentWidth * 0.07,
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
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: snap.data?.data[index].variants[0]
                                              .cartCount ==
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
                                          .cartCount = cartCount.toString();
                                      AllCommonApis().addToCartApi(
                                          productId,
                                          productVariantId,
                                          cartCount.toString()).then((value){
                                        if (mounted) {
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

                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      height: parentHeight * 0.06,
                                      width: parentWidth * 0.13,
                                      decoration: const BoxDecoration(
                                          color: CommonColor.APP_BAR_COLOR,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
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
                });
          },
        ),
      ),
    );
  }
}
