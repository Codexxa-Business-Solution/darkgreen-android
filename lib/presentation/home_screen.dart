import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/category_product_screen.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:darkgreen/presentation/section_product_details_screen.dart';
import 'package:darkgreen/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../allCommonApis/common_api.dart';
import '../api_model/home/all_data_model.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenInterface mListener;

  const HomeScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int count = 0;
  int totalCartCount = 0;

  late AllData _allData;
  bool _isLoading = false;
  bool _isDialogVisible = false;
  int favTap = 0;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // check loading
    if (!_isLoading) {
      final carouselSlider =
          getCarouselSlider(SizeConfig.screenHeight, SizeConfig.screenWidth);

      // category list
      final categoriesLayout =
          getCategoriesLayout(SizeConfig.screenHeight, SizeConfig.screenWidth);

      // sections
      final sectionWidgets = _allData.sections?.map((element) {
        return getSectionLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth, element);
      }).toList();

      return Scaffold(
        body: SizedBox(
          height: SizeConfig.screenHeight, // Set a specific height
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.05),
            children: [
              carouselSlider,
              categoriesLayout,
              ...sectionWidgets ?? []
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Widget getCarouselSlider(double parentHeight, double parentWidth) {
    // sliders
    var sliders = _allData.sliderImages;

    // return empty
    if (sliders == null) {
      print("empty container slider");
      return Container();
    }

    // return ui
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: sliders.length,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              initialPage: 1,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            itemBuilder: (BuildContext context, int itemIndex, int index1) {
              final img = sliders[index1].image!.isNotEmpty
                  ? NetworkImage(
                      sliders[index1].image.toString(),
                    )
                  : const NetworkImage("");

              return Padding(
                padding: EdgeInsets.only(
                    left: parentWidth * 0.04,
                    right: parentWidth * 0.04,
                    top: parentHeight * 0.02,
                    bottom: parentHeight * 0.02),
                child: Container(
                    height: SizeConfig.screenHeight * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.17),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: img,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < sliders.length; i++)
              Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color:
                      currentIndex == i ? Colors.green : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
      ],
    );
  }

  Widget getCategoriesLayout(double parentHeight, double parentWidth) {
    // categories
    var categories = _allData.categories;

    // return empty
    if (categories == null) {
      print("empty container slider");
      return Container();
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.03,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop by Category",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    fontWeight: FontWeight.w500,
                    color: CommonColor.BLACK_COLOR,
                    fontFamily: 'Roboto_Medium'),
              ),
              GestureDetector(
                onTap: () {
                  widget.mListener.getAddCategoriesLayout();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        color: CommonColor.APP_BAR_COLOR,
                        fontFamily: 'Roboto_Medium'),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: SizedBox(
            height: parentHeight * 0.23,
            child: ListView.builder(
                padding: EdgeInsets.only(right: parentWidth * 0.05),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final img = categories[index].image!.isNotEmpty
                      ? Image.network(
                          "${categories[index].image}",
                        )
                      : Image.network("");

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
                                builder: (context) => CategoryProduct(
                                      proName: "${categories[index].name}",
                                      catId: "${categories[index].id}",
                                    )));
                      },
                      child: Container(
                        height: parentHeight * 0.18,
                        width: parentWidth * 0.35,
                        child: Column(
                          children: [
                            Container(
                                height: parentHeight * 0.14,
                                width: parentWidth * 0.32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0.1, 1),
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: img)),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: parentHeight * 0.01),
                              child: Text(
                                categories[index].name.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.5,
                                    fontFamily: 'Roboto_Normal',
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget getSectionLayout(
      double parentHeight, double parentWidth, Sections sections) {
    // check styles
    if (sections.style == "style_1") {
      return getSectionOne(parentHeight, parentWidth, sections);
    } else if (sections.style == "style_2") {
      return getSectionOne(parentHeight, parentWidth, sections);
    } else if (sections.style == "style_3") {
      return getSectionOne(parentHeight, parentWidth, sections);
    } else {
      return Container();
    }
  }

  // style 1
  Widget getSectionOne(
      double parentHeight, double parentWidth, Sections sections) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.03,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    sections.title.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: CommonColor.BLACK_COLOR,
                        fontFamily: 'Roboto_Medium'),
                  ),
                  Text(
                    sections.shortDescription.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: CommonColor.GRAY_COLOR,
                        fontFamily: 'Roboto_Regular'),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SectionPriceDetails(
                                sectionId: sections.id.toString(),
                                sectionName: sections.title.toString(),
                              )));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontWeight: FontWeight.w400,
                      color: CommonColor.APP_BAR_COLOR,
                      fontFamily: 'Roboto_Medium'),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: SizedBox(
            height: parentHeight * 0.32,
            child: ListView.builder(
                padding: EdgeInsets.only(right: parentWidth * 0.05),
                scrollDirection: Axis.horizontal,
                itemCount: sections.products!.length,
                itemBuilder: (context, index) {
                  var productName = sections.products?[index].name.toString();
                  var productPrice = sections
                      .products?[index].variants?[0].discountedPrice
                      .toString();
                  var productOriginalPrice =
                      sections.products?[index].variants?[0].price.toString();
                  var productOffer = 0;
                  if (productPrice != null && productOriginalPrice != null) {
                    productOffer = int.parse(productOriginalPrice) -
                        int.parse(productPrice);
                  }
                  var productRating =
                      sections.products?[index].numberOfRatings.toString();
                  var productId = sections.products?[index].id.toString();
                  var productImage = sections.products?[index].image.toString();

                  var cartCountString =
                      sections.products?[index].variants![0].cartCount;
                  var cartCount = 0;
                  if (cartCountString != null) {
                    cartCount = int.parse(cartCountString);
                  }

                  return GestureDetector(
                    onTap: () {
                      // Code to be executed when the widget is tapped
                      print('Widget tapped!');
                    },
                    child: Padding(
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
                                          productId: productId.toString(),
                                          catId: "",
                                        )));
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        height: parentHeight * 0.17,
                                        width: parentWidth * 0.47,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Image(
                                            image: NetworkImage(
                                                productImage ?? ""),
                                            fit: BoxFit.cover,
                                          ),
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
                                                color:
                                                    CommonColor.APP_BAR_COLOR,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "$productOffer \u{20B9} off",
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
                                          sections.products?[index]
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
                                                          "${sections.products?[index].variants?[0].productId}";

                                                      productName =
                                                          "${sections.products?[0].name}";

                                                      favTap = 0;

                                                      var result =
                                                          AllCommonApis()
                                                              .removeToFavorite(
                                                                  productId!);

                                                      result.then((value) {
                                                        if (mounted) {
                                                          setState(() {
                                                            _isDialogVisible =
                                                                true;

                                                            Future.delayed(
                                                                const Duration(
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
                                                          "${sections.products?[index].variants?[0].productId}";

                                                      productName =
                                                          "${sections.products?[0].name}";

                                                      favTap = 1;

                                                      var result =
                                                          AllCommonApis()
                                                              .addToFavorite(
                                                                  productId!);

                                                      result.then((value) {
                                                        if (mounted) {
                                                          setState(() {
                                                            _isDialogVisible =
                                                                true;

                                                            Future.delayed(
                                                                const Duration(
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
                                      height: parentHeight * 0.13,
                                      width: parentWidth * 0.47,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
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
                                                Flexible(
                                                  child: Text(
                                                    productName!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            3.5,
                                                        fontFamily:
                                                            'Roboto_Normal',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.center,
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
                                                  "Rs ${productPrice!}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          3.5,
                                                      fontFamily:
                                                          'Roboto_Normal',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth * 0.02),
                                                  child: Text(
                                                    "Rs ${productOriginalPrice!}",
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: parentHeight * 0.033,
                                                  width: parentWidth * 0.13,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor
                                                          .REVIEW_CONTAINER_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        productRating!,
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
                                                      Icon(
                                                        Icons.star,
                                                        color: CommonColor
                                                            .REVIEW_COLOR,
                                                        size:
                                                            parentHeight * 0.02,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: cartCount != 0
                                                      ? true
                                                      : false,
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          var similarProductId =
                                                              "${sections.products?[index].variants?[0].productId}";
                                                          var similarProductVariantId =
                                                              "${sections.products?[index].variants?[0].id}";

                                                          count = int.parse(
                                                              "${sections.products?[index].variants?[0].cartCount}");

                                                          count--;

                                                          sections
                                                                  .products?[index]
                                                                  .variants?[0]
                                                                  .cartCount =
                                                              count.toString();

                                                          AllCommonApis()
                                                              .addToCartApi(
                                                                  similarProductId,
                                                                  similarProductVariantId,
                                                                  count
                                                                      .toString())
                                                              .then((value) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(SnackBar(
                                                                    content: Text(value
                                                                        .message
                                                                        .toString())));

                                                            setState(() {
                                                              if (mounted) {
                                                                setState(() {
                                                                  AllCommonApis()
                                                                      .getAllCarts()
                                                                      .then(
                                                                          (value) {
                                                                    if (mounted) {
                                                                      setState(
                                                                          () {
                                                                        totalCartCount = value
                                                                            .data
                                                                            .length;
                                                                        print(
                                                                            count);
                                                                      });
                                                                    }
                                                                  });
                                                                });
                                                              }
                                                            });
                                                          });
                                                        },
                                                        child: Container(
                                                          height: parentHeight *
                                                              0.035,
                                                          width: parentWidth *
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
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    5.6),
                                                            textScaleFactor:
                                                                1.0,
                                                          )),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: parentHeight *
                                                            0.035,
                                                        width:
                                                            parentWidth * 0.07,
                                                        decoration: BoxDecoration(
                                                            color: CommonColor
                                                                .WHITE_COLOR,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                            child: Text(
                                                          "${sections.products?[index].variants?[0].cartCount}",
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
                                                          var similarProductId =
                                                              "${sections.products?[index].variants?[0].productId}";
                                                          var similarProductVariantId =
                                                              "${sections.products?[index].variants?[0].id}";

                                                          count = int.parse(
                                                              "${sections.products?[index].variants?[0].cartCount}");

                                                          count++;

                                                          sections
                                                                  .products?[index]
                                                                  .variants?[0]
                                                                  .cartCount =
                                                              count.toString();

                                                          AllCommonApis()
                                                              .addToCartApi(
                                                                  similarProductId,
                                                                  similarProductVariantId,
                                                                  count
                                                                      .toString())
                                                              .then((value) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(SnackBar(
                                                                    content: Text(value
                                                                        .message
                                                                        .toString())));

                                                            setState(() {
                                                              if (mounted) {
                                                                setState(() {
                                                                  AllCommonApis()
                                                                      .getAllCarts()
                                                                      .then(
                                                                          (value) {
                                                                    if (mounted) {
                                                                      setState(
                                                                          () {
                                                                        totalCartCount = value
                                                                            .data
                                                                            .length;
                                                                      });
                                                                    }
                                                                  });
                                                                });
                                                              }
                                                            });
                                                          });
                                                        },
                                                        child: Container(
                                                          height: parentHeight *
                                                              0.035,
                                                          width: parentWidth *
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
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
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
                                      visible: cartCount == 0 ? true : false,
                                      child: GestureDetector(
                                        onTap: () {
                                          var similarProductId =
                                              "${sections.products?[index].variants?[0].productId}";
                                          var similarProductVariantId =
                                              "${sections.products?[index].variants?[0].id}";

                                          count = int.parse(
                                              "${sections.products?[index].variants?[0].cartCount}");

                                          count++;

                                          sections.products?[index].variants?[0]
                                              .cartCount = count.toString();

                                          AllCommonApis()
                                              .addToCartApi(
                                                  similarProductId,
                                                  similarProductVariantId,
                                                  count.toString())
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(value.message
                                                        .toString())));

                                            setState(() {
                                              if (mounted) {
                                                setState(() {
                                                  AllCommonApis()
                                                      .getAllCarts()
                                                      .then((value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        totalCartCount =
                                                            value.data.length;
                                                      });
                                                    }
                                                  });
                                                });
                                              }
                                            });
                                          });
                                        },
                                        child: Container(
                                          height: parentHeight * 0.06,
                                          width: parentWidth * 0.13,
                                          decoration: const BoxDecoration(
                                              color: CommonColor.APP_BAR_COLOR,
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
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
                        )),
                  );
                }),
          ),
        )
      ],
    );
  }

  Future<void> getAllData() async {
    setState(() {
      _isLoading = true;
    });

    // auth
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    // fetch api
    final response = await http.post(
      Uri.parse('https://darkgreen.in/app-admin/api-firebase/get-all-data.php'),
      headers: headersList,
      body: {
        "accesskey": ApiConstants().accessKey,
        "get-all-sections": "1",
        "user_id": "369",
        "section_id": "99",
        "limit": "0",
        "offset": "0",
      },
    );

    // check response
    if (response.statusCode == 200) {
      print("get api success");

      var loadedData = AllData.fromJson(jsonDecode(response.body.jsonBody()));
      setState(() {
        _allData = loadedData;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to create album.');
    }
  }
}

abstract class HomeScreenInterface {
  getAddCategoriesLayout();
}
