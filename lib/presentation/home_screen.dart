import 'dart:convert';
import 'dart:js_interop';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/category_product_screen.dart';
import 'package:darkgreen/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  late AllData _allData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                // carousal slider
                getCarouselSlider(
                    SizeConfig.screenHeight, SizeConfig.screenWidth);

                // category list
                getCategoriesLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth);

                // sections
                _allData.sections?.forEach((element) {
                  getSectionLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth, element);
                });
              },
            ),
    );

    // ListView(
    //         shrinkWrap: true,
    //         padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.05),
    //         children: [
    //           getCarouselSlider(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getCategoriesLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getPopularLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getAdv1(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getDailyNeedsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getSummerZoneLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //           getAdv2(SizeConfig.screenHeight, SizeConfig.screenWidth),
    //         ],
    //       )
  }

  Widget getCarouselSlider(double parentHeight, double parentWidth) {
    // sliders
    var sliders = _allData.sliderImages;

    // return empty
    if (sliders == null) return Container();

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
    if (categories == null) return Container();

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
                            padding: EdgeInsets.only(top: parentHeight * 0.01),
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
        )
      ],
    );
  }

  Widget getSectionLayout(
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
              Text(
                sections.title.toString(),
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    fontWeight: FontWeight.w500,
                    color: CommonColor.BLACK_COLOR,
                    fontFamily: 'Roboto_Medium'),
              ),
              Text(
                "View All",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontWeight: FontWeight.w400,
                    color: CommonColor.APP_BAR_COLOR,
                    fontFamily: 'Roboto_Medium'),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: Container(
            // color: Colors.red,
            height: parentHeight * 0.32,
            child: ListView.builder(
                padding: EdgeInsets.only(right: parentWidth * 0.05),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        bottom: parentHeight * 0.01,
                        left: parentWidth * 0.05),
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
                                  height: parentHeight * 0.17,
                                  width: parentWidth * 0.47,
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/carosel_demo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.015),
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
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.02),
                                        child: /*Image(image: AssetImage("assets/images/like_icon.png"),
                                      height: parentHeight*0.02,
                                      ),*/
                                            const Icon(
                                          Icons.favorite_outline_rounded,
                                          color: CommonColor.LIKE_COLOR,
                                        ))
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
                                          Text(
                                            "TATA Tea Premium",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
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
                                            "Rs 34.00",
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
                                              "Rs 35.00",
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
                                            height: parentHeight * 0.033,
                                            width: parentWidth * 0.13,
                                            decoration: BoxDecoration(
                                                color: CommonColor
                                                    .REVIEW_CONTAINER_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "4.5",
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
                                                  color:
                                                      CommonColor.REVIEW_COLOR,
                                                  size: parentHeight * 0.02,
                                                )
                                              ],
                                            ),
                                          ),
                                          /* Container(
                                            height: parentHeight*0.045,
                                            width: parentWidth*0.25,
                                            decoration: BoxDecoration(
                                                color: CommonColor.APP_BAR_COLOR,
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Add to Cart",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto_Medium'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )*/
                                          Visibility(
                                            visible: count != 0 ? true : false,
                                            child: Row(
                                              children: [
                                                GestureDetector(
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
                                                    width: parentWidth * 0.067,
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
                                                  height: parentHeight * 0.035,
                                                  width: parentWidth * 0.07,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor
                                                          .WHITE_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
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
                                                    width: parentWidth * 0.067,
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
                                visible: count == 0 ? true : false,
                                child: GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        count++;
                                      });
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
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget getAdv1(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.02,
          right: parentWidth * 0.03,
          left: parentWidth * 0.03),
      child: Container(
        height: parentHeight * 0.21,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: const Image(
            image: AssetImage("assets/images/offer_adv.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget getDailyNeedsLayout(double parentHeight, double parentWidth) {
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
                "Daily Needs",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    fontWeight: FontWeight.w500,
                    color: CommonColor.BLACK_COLOR,
                    fontFamily: 'Roboto_Medium'),
              ),
              Text(
                "View All",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontWeight: FontWeight.w400,
                    color: CommonColor.APP_BAR_COLOR,
                    fontFamily: 'Roboto_Medium'),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: Container(
            // color: Colors.red,
            height: parentHeight * 0.32,
            child: ListView.builder(
                padding: EdgeInsets.only(right: parentWidth * 0.05),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        bottom: parentHeight * 0.01,
                        left: parentWidth * 0.05),
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
                                  height: parentHeight * 0.17,
                                  width: parentWidth * 0.47,
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/carosel_demo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.015),
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
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.02),
                                        child: /*Image(image: AssetImage("assets/images/like_icon.png"),
                                      height: parentHeight*0.02,
                                      ),*/
                                            const Icon(
                                          Icons.favorite_outline_rounded,
                                          color: CommonColor.LIKE_COLOR,
                                        ))
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
                                          Text(
                                            "TATA Tea Premium",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
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
                                            "Rs 34.00",
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
                                              "Rs 35.00",
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
                                            height: parentHeight * 0.033,
                                            width: parentWidth * 0.13,
                                            decoration: BoxDecoration(
                                                color: CommonColor
                                                    .REVIEW_CONTAINER_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "4.5",
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
                                                  color:
                                                      CommonColor.REVIEW_COLOR,
                                                  size: parentHeight * 0.02,
                                                )
                                              ],
                                            ),
                                          ),
                                          /* Container(
                                            height: parentHeight*0.045,
                                            width: parentWidth*0.25,
                                            decoration: BoxDecoration(
                                                color: CommonColor.APP_BAR_COLOR,
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Add to Cart",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto_Medium'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )*/
                                          Visibility(
                                            visible: count != 0 ? true : false,
                                            child: Row(
                                              children: [
                                                GestureDetector(
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
                                                    width: parentWidth * 0.067,
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
                                                  height: parentHeight * 0.035,
                                                  width: parentWidth * 0.07,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor
                                                          .WHITE_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
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
                                                    width: parentWidth * 0.067,
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
                                visible: count == 0 ? true : false,
                                child: GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        count++;
                                      });
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
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget getSummerZoneLayout(double parentHeight, double parentWidth) {
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
                "Summer Zone",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    fontWeight: FontWeight.w500,
                    color: CommonColor.BLACK_COLOR,
                    fontFamily: 'Roboto_Medium'),
              ),
              Text(
                "View All",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontWeight: FontWeight.w400,
                    color: CommonColor.APP_BAR_COLOR,
                    fontFamily: 'Roboto_Medium'),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: Container(
            // color: Colors.red,
            height: parentHeight * 0.32,
            child: ListView.builder(
                padding: EdgeInsets.only(right: parentWidth * 0.05),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        bottom: parentHeight * 0.01,
                        left: parentWidth * 0.05),
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
                                  height: parentHeight * 0.17,
                                  width: parentWidth * 0.47,
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/carosel_demo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.015),
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
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.02),
                                        child: /*Image(image: AssetImage("assets/images/like_icon.png"),
                                      height: parentHeight*0.02,
                                      ),*/
                                            const Icon(
                                          Icons.favorite_outline_rounded,
                                          color: CommonColor.LIKE_COLOR,
                                        ))
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
                                          Text(
                                            "TATA Tea Premium",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
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
                                            "Rs 34.00",
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
                                              "Rs 35.00",
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
                                            height: parentHeight * 0.033,
                                            width: parentWidth * 0.13,
                                            decoration: BoxDecoration(
                                                color: CommonColor
                                                    .REVIEW_CONTAINER_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "4.5",
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
                                                  color:
                                                      CommonColor.REVIEW_COLOR,
                                                  size: parentHeight * 0.02,
                                                )
                                              ],
                                            ),
                                          ),
                                          /* Container(
                                            height: parentHeight*0.045,
                                            width: parentWidth*0.25,
                                            decoration: BoxDecoration(
                                                color: CommonColor.APP_BAR_COLOR,
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Add to Cart",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto_Medium'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )*/
                                          Visibility(
                                            visible: count != 0 ? true : false,
                                            child: Row(
                                              children: [
                                                GestureDetector(
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
                                                    width: parentWidth * 0.067,
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
                                                  height: parentHeight * 0.035,
                                                  width: parentWidth * 0.07,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor
                                                          .WHITE_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
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
                                                    width: parentWidth * 0.067,
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
                                visible: count == 0 ? true : false,
                                child: GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        count++;
                                      });
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
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget getAdv2(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.02,
          right: parentWidth * 0.03,
          left: parentWidth * 0.03),
      child: Container(
        height: parentHeight * 0.21,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: const Image(
            image: AssetImage("assets/images/offer_adv2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
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
