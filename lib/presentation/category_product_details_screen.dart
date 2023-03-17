import 'dart:convert';
import 'package:darkgreen/api_model/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/categories/get_product_by_cat_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/constant/top_header_layout.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
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

  int cartCount = 0;
  int addCartValue = 0;

  @override
  void initState() {
    super.initState();
    AllCommonApis().productByCategoriesApi(widget.subCatId);
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));

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
              child: ToHeadLayout(
                title: widget.subProName,
              )),
          RefreshIndicator(
            color: CommonColor.REFRESH_INDICATOR_COLOR,
            onRefresh: () async {
              await refreshList();
            },
            child: Container(
                color: CommonColor.WHITE_COLOR,
                height: SizeConfig.screenHeight * 0.88,
                child: GetAllProducts(getSubCatId: widget.subCatId,),
          ),
          ),
        ],
      ),
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
            onDoubleTap: () {},
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



















class GetAllProducts extends StatefulWidget {
  final String getSubCatId;

  const GetAllProducts({Key? key, required this.getSubCatId}) : super(key: key);

  @override
  State<GetAllProducts> createState() => _GetAllProductsState();
}

class _GetAllProductsState extends State<GetAllProducts> {


  String productId = "";
  String productVariantId = "";
  int cartCount = 0;
  int addCartValue = 0;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  FutureBuilder<GetProductsByCategoriesResponseModel>(
      future: AllCommonApis().productByCategoriesApi(widget.getSubCatId),
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
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
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

                return Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight * 0.01,
                      bottom: SizeConfig.screenHeight * 0.01,
                      left: SizeConfig.screenWidth * 0.05),
                  child: GestureDetector(
                    onDoubleTap: () {},
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductInfoScreen()));
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: SizeConfig.screenHeight * 0.18,
                                  width: SizeConfig.screenWidth * 0.47,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: img,
                                  )),
                              Padding(
                                padding:
                                EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.15,
                                      height: SizeConfig.screenHeight * 0.027,
                                      decoration: const BoxDecoration(
                                          color: CommonColor.APP_BAR_COLOR,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "30% off",
                                            style: TextStyle(
                                                color: CommonColor.WHITE_COLOR,
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
                                          right: SizeConfig.screenWidth * 0.02),
                                      child: GestureDetector(
                                        onDoubleTap: () {},
                                        onTap: () {
                                          productId =
                                          "${snap.data?.data[index].variants[0].productId}";

                                          var result = AllCommonApis()
                                              .removeToFavorite(
                                              productId);

                                          result.then((value) {
                                            if (mounted) {
                                              setState(() {
                                                // productId =
                                                // "${snap.data?.data[index].variants[0].productId}";
                                                //
                                                // var result = AllCommonApis()
                                                //     .removeToFavorite(productId);
                                                //
                                                // result.then((value) {
                                                //   if (mounted) {
                                                //     setState(() {
                                                //     });
                                                //   }
                                                // });
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Icon(
                                            Icons.favorite_rounded,
                                            color: CommonColor.LIKE_COLOR,
                                          ),
                                        ),
                                      ),
                                    )
                                        : Padding(
                                      padding: EdgeInsets.only(
                                          right: SizeConfig.screenWidth * 0.02),
                                      child: GestureDetector(
                                        onDoubleTap: () {},
                                        onTap: () {
                                          productId =
                                          "${snap.data?.data[index].variants[0].productId}";

                                          var result = AllCommonApis()
                                              .addToFavorite(
                                              productId);

                                          result.then((value) {
                                            if (mounted) {
                                              setState(() {

                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Icon(
                                            Icons
                                                .favorite_outline_rounded,
                                            color: CommonColor.LIKE_COLOR,
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
                                height: SizeConfig.screenHeight * 0.13,
                                width: SizeConfig.screenWidth * 0.47,
                                decoration: const BoxDecoration(
                                    color: CommonColor.LAYOUT_BACKGROUND_COLOR,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.01,
                                          left: SizeConfig.screenWidth * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.4,
                                            color: Colors.transparent,
                                            child: Text(
                                              "${snap.data?.data[index].name}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.5,
                                                  fontFamily: 'Roboto_Normal',
                                                  fontWeight: FontWeight.w400),
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
                                          top: SizeConfig.screenHeight * 0.01,
                                          left: SizeConfig.screenWidth * 0.02),
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
                                                left: SizeConfig.screenWidth * 0.02),
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
                                          top: SizeConfig.screenHeight * 0.015,
                                          left: SizeConfig.screenWidth * 0.02,
                                          right: SizeConfig.screenWidth * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: SizeConfig.screenHeight * 0.035,
                                            width: SizeConfig.screenWidth * 0.13,
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
                                                      left: SizeConfig.screenWidth * 0.02),
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
                                                      right:
                                                      SizeConfig.screenWidth * 0.015),
                                                  child: Icon(
                                                    Icons.star,
                                                    color: CommonColor
                                                        .REVIEW_COLOR,
                                                    size: SizeConfig.screenHeight * 0.018,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: snap.data?.data[index]
                                                .variants[0]
                                                .cartCount !=
                                                "0"
                                                ? true
                                                : false,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onDoubleTap: () {},
                                                  onTap: () {
                                                    productId = "${snap.data?.data[index].variants[0].productId}";

                                                    productVariantId = "${snap.data?.data[index].variants[0].id}";

                                                    cartCount = int.parse("${snap.data?.data[index].variants[0].cartCount}");

                                                    cartCount--;

                                                    snap.data
                                                        ?.data[index]
                                                        .variants[0]
                                                        .cartCount =
                                                        cartCount.toString();

                                                    AllCommonApis().addToCartApi(
                                                        productId,
                                                        productVariantId,
                                                        cartCount.toString()).then((value) {
                                                          setState(() {

                                                          });
                                                    });



                                                  },
                                                  child: Container(
                                                    height:
                                                    SizeConfig.screenHeight * 0.035,
                                                    width: SizeConfig.screenWidth * 0.07,
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
                                                  height: SizeConfig.screenHeight * 0.035,
                                                  width: SizeConfig.screenWidth * 0.07,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor
                                                          .WHITE_COLOR,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
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
                                                  onDoubleTap: () {},
                                                  onTap: () {
                                                    productId = "${snap.data?.data[index].variants[0].productId}";
                                                    productVariantId = "${snap.data?.data[index].variants[0].id}";

                                                    cartCount = int.parse("${snap.data?.data[index].variants[0].cartCount}");

                                                    cartCount++;

                                                    snap.data
                                                        ?.data[index]
                                                        .variants[0]
                                                        .cartCount =
                                                        cartCount.toString();

                                                    AllCommonApis().addToCartApi(
                                                        productId,
                                                        productVariantId,
                                                        cartCount.toString()).then((value) {
                                                      setState(() {

                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    height:
                                                    SizeConfig.screenHeight * 0.035,
                                                    width: SizeConfig.screenWidth * 0.07,
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
                                  onDoubleTap: () {},
                                  onTap: () {

                                    productId = "${snap.data?.data[index].variants[0].productId}";

                                    productVariantId = "${snap.data?.data[index].variants[0].id}";

                                    cartCount = int.parse("${snap.data?.data[index].variants[0].cartCount}");

                                    cartCount++;

                                    snap.data?.data[index].variants[0].cartCount = cartCount.toString();

                                    AllCommonApis().addToCartApi(
                                        productId,
                                        productVariantId,
                                        cartCount.toString()).then((value) {
                                      setState(() {

                                      });
                                    });
                                  },
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.06,
                                    width: SizeConfig.screenWidth * 0.13,
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
              }),
        );
      },
    );
  }
}
