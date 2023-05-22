import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/categories/get_product_info_by_id_response_model.dart';
import 'package:darkgreen/api_model/categories/get_similar_product_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/view_all_product_needs_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class ProductInfoScreen extends StatefulWidget {
  final String productId;
  final String catId;

  const ProductInfoScreen(
      {Key? key, required this.productId, required this.catId})
      : super(key: key);

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  int currentIndex = 0;
  int count = 0;
  bool isLike = false;
  int price = 0;
  int discountPrice = 0;
  int savingPrice = 0;
  int cartCount = 0;
  int totalCartCount = 0;

  String productId = "";
  String productVariantId = "";
  String productName = "";
  int favTap = 0;
  int totalCartAmount = 0;

  bool _isDialogVisible = false;


  int sPrice = 0;
  int sDiscountPrice = 0;
  int sSavingPrice = 0;
  int? totalCartsCount;

  @override
  void initState() {
    super.initState();
    AllCommonApis().getProductInfoByIdApi(widget.productId).then((value) {
      price = int.parse("${value.data[0].variants[0].price}");
      discountPrice = int.parse("${value.data[0].variants[0].discountedPrice}");
      savingPrice = price - discountPrice;
    });

    AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId);


    refresh();
  }

  void refresh() {
    var result = AllCommonApis().getAllCarts();
    totalCartAmount = 0;
    result.then((value) {
      if (mounted) {
        setState(() {
          totalCartCount = value.data.length;
          totalCartsCount = value.data.isNotEmpty ? value.data.length : 0;
          for (var element in value.data) {
            totalCartAmount +=
            (int.parse(element.discountedPrice) * int.parse(element.qty));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              Container(
                  color: CommonColor.APP_BAR_COLOR,
                  height: SizeConfig.screenHeight * 0.12,
                  child: getAddMainHeadingLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth)),
              Container(
                color: CommonColor.WHITE_COLOR,
                height: SizeConfig.screenHeight * 0.88,
                child: FutureBuilder<GetProductByIdResponseModel>(
                  future:
                      AllCommonApis().getProductInfoByIdApi(widget.productId),
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

                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.screenHeight * 0.05),
                      children: [
                        getImageCarouselSlider(
                            SizeConfig.screenHeight,
                            SizeConfig.screenWidth,
                            "${snap.data?.data[0].image}",
                            snap.data?.data.length),
                        getNameLikeShareOtherLayout(SizeConfig.screenHeight,
                            SizeConfig.screenWidth, snap.data),
                        getSimilarProductLayout(
                            SizeConfig.screenHeight, SizeConfig.screenWidth),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.screenHeight * 0.01,
              left: SizeConfig.screenWidth * 0.03,
              right: SizeConfig.screenWidth * 0.03,
            ),
            child: Container(
              height: SizeConfig.screenHeight * 0.07,
              decoration: BoxDecoration(
                  color: CommonColor.APP_BAR_COLOR,
                  borderRadius: BorderRadius.circular(10)),
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
                          "$totalCartsCount Item",
                          style: TextStyle(
                              color: CommonColor.WHITE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.005),
                          child: Text(
                            "Rs.$totalCartAmount",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Cart())).then((value){
                          AllCommonApis().getProductInfoByIdApi(widget.productId).then((value) {
                            price = int.parse("${value.data[0].variants[0].price}");
                            discountPrice = int.parse("${value.data[0].variants[0].discountedPrice}");
                            savingPrice = price - discountPrice;
                          });

                          AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId);


                          refresh();
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              "View Cart",
                              style: TextStyle(
                                  color: CommonColor.WHITE_COLOR,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 4.5,
                                  fontFamily: 'Roboto_Medium',
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
          right: parentWidth * 0.03),
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
          GestureDetector(
            
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Cart())).then((value){
                AllCommonApis().getProductInfoByIdApi(widget.productId).then((value) {
                  price = int.parse("${value.data[0].variants[0].price}");
                  discountPrice = int.parse("${value.data[0].variants[0].discountedPrice}");
                  savingPrice = price - discountPrice;
                });

                AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId);


                refresh();
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
          ),
        ],
      ),
    );
  }

  Widget getImageCarouselSlider(
      double parentHeight, double parentWidth, String img, int? imgLen) {
    final imgs = img != null
        ? Image.network(
            img,
      fit: BoxFit.fill,
          )
        : Image.network("");
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: imgLen,
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
                height: parentHeight * 0.35),
            itemBuilder: (BuildContext context, int itemIndex, int index1) {
              return Padding(
                padding: EdgeInsets.only(
                    left: parentWidth * 0.15,
                    right: parentWidth * 0.15,
                    top: parentHeight * 0.02,
                    bottom: parentHeight * 0.02),
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  color: Colors.white, child: imgs)),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: parentHeight * 0.02, left: parentWidth * 0.03),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Image(
                              image:
                                  AssetImage("assets/images/offer_star.png")),
                          Text(
                            "$savingPrice \u{20B9} \noff",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 2.9,
                                fontFamily: 'Roboto_Medium',
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < imgLen!; i++)
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

  Widget getNameLikeShareOtherLayout(double parentHeight, double parentWidth,
      GetProductByIdResponseModel? model) {
    var doc = model?.data[0].description;
    String parsedstring3 = Bidi.stripHtmlIfNeeded(doc!);
    print(parsedstring3);

    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.02,
          left: parentWidth * 0.05,
          right: parentWidth * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: parentHeight * 0.05,
                  width: parentWidth * 0.65,
                  // color: Colors.red,
                  child: Text(
                    "${model?.data[0].name}",
                    style: TextStyle(
                        color: CommonColor.BLACK_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: parentHeight * 0.05,
                width: parentWidth * 0.18,
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model?.data[0].isFavorite == true
                        ? Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.screenWidth * 0.02),
                            child: GestureDetector(
                              
                              onTap: () {
                                productId =
                                    "${model?.data[0].variants[0].productId}";

                                productName = "${model?.data[0].name}";

                                favTap = 0;

                                var result =
                                    AllCommonApis().removeToFavorite(productId);

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
                              
                              onTap: () {
                                productId =
                                    "${model?.data[0].variants[0].productId}";

                                productName = "${model?.data[0].name}";

                                favTap = 1;

                                var result =
                                    AllCommonApis().addToFavorite(productId);

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
                                color: Colors.transparent,
                                child: const Icon(
                                  Icons.favorite_outline_rounded,
                                  color: CommonColor.LIKE_COLOR,
                                ),
                              ),
                            ),
                          ),
                    Image(
                      image: const AssetImage("assets/images/share.png"),
                      color: Colors.black,
                      height: parentHeight * 0.035,
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: parentWidth * 0.01),
                child: RatingBar.builder(
                  initialRating: double.parse("${model?.data[0].ratings}"),
                  itemSize: 20,
                  glow: false,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // myraiting = rating;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.015 /*, right: parentWidth*0.02*/),
                child: Row(
                  children: [
                    Container(
                      height: parentHeight * 0.033,
                      width: parentWidth * 0.18,
                      decoration: BoxDecoration(
                          color: CommonColor.REVIEW_CONTAINER_COLOR,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Save",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto_Regular'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.02),
                          child: Text(
                            "Rs.$savingPrice",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto_Regular'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.003),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Rs.${model?.data[0].variants[0].discountedPrice}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Text(
                        "Rs.${model?.data[0].variants[0].price}",
                        style: TextStyle(
                            color: CommonColor.DISCOUNT_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontFamily: 'Roboto_Normal',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: model?.data[0]
                          .variants[0].cartCount ==
                          "0"
                          ? true
                          : false,
                      child: GestureDetector(
                        
                        onTap: () {
                          productId = "${model?.data[0].variants[0].productId}";

                          productVariantId =
                          "${model?.data[0].variants[0].id}";

                          cartCount = int.parse(
                              "${model?.data[0].variants[0].cartCount}");

                          cartCount++;

                          model?.data[0].variants[0]
                              .cartCount =
                              cartCount.toString();

                          AllCommonApis()
                              .addToCartApi(
                              productId,
                              productVariantId,
                              cartCount.toString())
                              .then((value) {
                            setState(() {
                              refresh();
                            });
                          });
                        },
                        child: Container(
                          height: parentHeight * 0.045,
                          width: parentWidth * 0.25,
                          decoration: BoxDecoration(
                              color: CommonColor.APP_BAR_COLOR,
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.7,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: model?.data[0].variants[0].cartCount !=
                          "0"
                          ? true
                          : false,
                      child: Row(
                        children: [
                          GestureDetector(
                            
                            onTap: () {
                              productId =
                              "${model?.data[0].variants[0].productId}";

                              productVariantId =
                              "${model?.data[0].variants[0].id}";

                              cartCount = int.parse(
                                  "${model?.data[0].variants[0].cartCount}");

                              cartCount--;

                              model?.data[0].variants[0]
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
                                      var result = AllCommonApis().getAllCarts();

                                      result.then((value) {
                                        setState(() {
                                          refresh();
                                          totalCartCount = value.data.length;
                                        });
                                      });
                                    });
                                  });
                            },
                            child: Container(
                              height: parentHeight * 0.03,
                              width: parentWidth * 0.067,
                              decoration: BoxDecoration(
                                  color: CommonColor.APP_BAR_COLOR,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    color: CommonColor.WHITE_COLOR,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.6),
                                textScaleFactor: 1.0,
                              )),
                            ),
                          ),
                          Container(
                            height: parentHeight * 0.03,
                            width: parentWidth * 0.067,
                            decoration: BoxDecoration(
                                color: CommonColor.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                                  "${model?.data[0].variants[0].cartCount}",
                              style: TextStyle(
                                  color: CommonColor.BLACK_COLOR,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.5),
                              textScaleFactor: 1.0,
                            )),
                          ),
                          GestureDetector(
                            
                            onTap: () {
                              productId =
                              "${model?.data[0].variants[0].productId}";
                              productVariantId =
                              "${model?.data[0].variants[0].id}";

                              cartCount = int.parse(
                                  "${model?.data[0].variants[0].cartCount}");

                              cartCount++;

                              model?.data[0].variants[0]
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
                                      refresh();
                                    });
                                  });
                            },
                            child: Container(
                              height: parentHeight * 0.03,
                              width: parentWidth * 0.067,
                              decoration: BoxDecoration(
                                  color: CommonColor.APP_BAR_COLOR,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                "+",
                                style: TextStyle(
                                    color: CommonColor.WHITE_COLOR,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.0),
                                textScaleFactor: 1.0,
                              )),
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Container(
                  height: parentHeight * 0.001,
                  width: parentWidth * 0.9,
                  color: CommonColor.CIRCLE_COLOR,
                  child: const Text(
                    "Hii",
                    style: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Container(
                        height: parentHeight * 0.023,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColor.OFFER_COLOR,
                        ),
                        child: const Text(
                          "Hii",
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Text(
                        "10 Days Return Policy",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto_Regular'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Container(
                        height: parentHeight * 0.023,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColor.OFFER_COLOR,
                        ),
                        child: const Text(
                          "Hii",
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Text(
                        "Order Can Cancel Till Order Processed",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto_Regular'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Container(
                  height: parentHeight * 0.001,
                  width: parentWidth * 0.9,
                  color: CommonColor.CIRCLE_COLOR,
                  child: const Text(
                    "Hii",
                    style: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: parentHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Product Details",
                      style: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: parentHeight * 0.01,
                ),
                child: ReadMoreText(
                  parsedstring3,
                  trimLines: 3,
                  textAlign: TextAlign.start,
                  preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      fontWeight: FontWeight.w400),
                  textScaleFactor: 1.05,
                  colorClickableText: CommonColor.APP_BAR_COLOR,
                  trimMode: TrimMode.Length,
                  trimCollapsedText: 'Read More Details',
                  trimExpandedText: ' Show Less',
                ) /*Html(data: model?.data[0].description,)*/,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSimilarProductLayout(double parentHeight, double parentWidth) {
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
                "Similar Product",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    fontWeight: FontWeight.w500,
                    color: CommonColor.BLACK_COLOR,
                    fontFamily: 'Roboto_Medium'),
              ),
              GestureDetector(
                
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllProductsAndNeeds(
                            catId: widget.catId,
                            proId: widget.productId,
                          ))).then((value){
                    AllCommonApis().getProductInfoByIdApi(widget.productId).then((value) {
                      price = int.parse("${value.data[0].variants[0].price}");
                      discountPrice = int.parse("${value.data[0].variants[0].discountedPrice}");
                      savingPrice = price - discountPrice;
                    });

                    AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId);


                    refresh();
                  });
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
          child: Container(
            color: Colors.transparent,
            height: parentHeight * 0.32,
            child: FutureBuilder<GetSimilarProductResponseModel>(
              future: AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId),
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

                return ListView.builder(
                    padding: EdgeInsets.only(right: parentWidth * 0.05),
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data?.data.length,
                    itemBuilder: (context, index) {

                      sPrice = int.parse("${snap.data?.data[index].variants[0].price}");
                      sDiscountPrice = int.parse("${snap.data?.data[index].variants[0].discountedPrice}");
                      sSavingPrice = price - discountPrice;

                      final img = snap.data?.data[index].image != null
                          ? Image.network(
                        "${snap.data?.data[index].image}",
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
                                    builder: (context) => ProductInfoScreen(
                                      productId:
                                      "${snap.data?.data[index].id}",
                                      catId: "",
                                    ))).then((value){
                              AllCommonApis().getProductInfoByIdApi(widget.productId).then((value) {
                                price = int.parse("${value.data[0].variants[0].price}");
                                discountPrice = int.parse("${value.data[0].variants[0].discountedPrice}");
                                savingPrice = price - discountPrice;
                              });

                              AllCommonApis().getSimilarProductByIdApi(widget.productId, widget.catId);


                              refresh();
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
                                        height: parentHeight * 0.17,
                                        width: parentWidth * 0.47,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: img,
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
                                                  "$sSavingPrice \u{20B9} off",
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
                                      height: parentHeight * 0.13,
                                      width: parentWidth * 0.47,
                                      decoration: const BoxDecoration(
                                          color: CommonColor
                                              .LAYOUT_BACKGROUND_COLOR,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
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
                                                    "Rs ${snap.data?.data[index].variants[0].price}",
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
                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                        CommonColor.REVIEW_COLOR,
                                                        size: parentHeight * 0.02,
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
                                                                  refresh();
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
                                                                  refresh();
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
                                                refresh();
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
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}
