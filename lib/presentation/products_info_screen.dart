import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';





class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {


  int currentIndex = 0;
  int count = 0;
  bool isLike = false;




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
                  height: SizeConfig.screenHeight*0.12,
                  child: getAddMainHeadingLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
              ),
              Container(
                  color: CommonColor.WHITE_COLOR,
                  height: SizeConfig.screenHeight*0.88,
                  child:  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.05),
                    children: [
                      getImageCarouselSlider(SizeConfig.screenHeight, SizeConfig.screenWidth),
                      getNameLikeShareOtherLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
                      getSimilarProductLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
                      SizedBox(
                        height: SizeConfig.screenHeight*0.05,
                      )
                    ],
                  ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.01, left: SizeConfig.screenWidth*0.03,
              right: SizeConfig.screenWidth*0.03,),
            child: Container(
              height: SizeConfig.screenHeight*0.07,
              decoration: BoxDecoration(
                color: CommonColor.APP_BAR_COLOR,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01, left: SizeConfig.screenWidth*0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1 Item",
                        style: TextStyle(
                          color: CommonColor.WHITE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*4.0,
                          fontFamily: 'Roboto_Regular',
                          fontWeight: FontWeight.w400
                        ),),
                        Padding(
                          padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.005),
                          child: Text("Rs.154",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400
                            ),),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.05),
                    child: GestureDetector(
                      onDoubleTap: (){},
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                      },
                      child: Container(
                         color: Colors.transparent,
                        child: Row(
                          children: [
                            Text("View Cart",
                              style: TextStyle(
                                  color: CommonColor.WHITE_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                  fontFamily: 'Roboto_Medium',
                                  fontWeight: FontWeight.w500
                              ),),
                            Padding(
                              padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.01),
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                color: CommonColor.WHITE_COLOR,
                              size: SizeConfig.screenHeight*0.02,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .05, left: parentWidth*0.05, right: parentWidth*0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            onDoubleTap: () {},
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .025,
                color: CommonColor.WHITE_COLOR,
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: (){},
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
            },
            child: Container(
              color: Colors.transparent,
              child:  Image(image: AssetImage("assets/images/trolly.png"),
                height: parentHeight*0.03,)
            ),
          ),
        ],
      ),
    );
  }

  Widget getImageCarouselSlider(double parentHeight, double parentWidth) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: 5,
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
              height: parentHeight*0.35
            ),
            itemBuilder: (BuildContext context, int itemIndex, int index1) {
              // final img = images[index1].isNotEmpty
              //     ? NetworkImage(
              //   "http://admin.azan4salah.com${images[index1]}",
              // )
              //     : const NetworkImage("");
              return Padding(
                padding: EdgeInsets.only(
                    left: parentWidth * 0.07,
                    right: parentWidth * 0.07,
                    top: parentHeight * 0.02,
                    bottom: parentHeight * 0.02),
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withOpacity(0.17),
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/carosel_demo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: parentHeight*0.02, left: parentWidth*0.03),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(image: AssetImage("assets/images/offer_star.png")),
                          Text("18% \nOFF ",
                          style: TextStyle(
                            color: CommonColor.WHITE_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal*3.0,
                            fontFamily: 'Roboto_Medium',
                            fontWeight: FontWeight.w400
                          ),textAlign: TextAlign.center,)
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
            for (int i = 0; i < 5; i++)
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

  Widget getNameLikeShareOtherLayout(double parentHeight, double parentWidth){
    return Padding(
      padding:  EdgeInsets.only(top: parentHeight*0.02, left: parentWidth*0.05, right: parentWidth*0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: parentHeight*0.05,
                width: parentWidth*0.65,
                // color: Colors.red,
                  child: Text("Fortune Sunlite Refined Sunflower Oil  ( 1 L)",
                  style: TextStyle(
                    color: CommonColor.BLACK_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500
                  ),)
              ),

              Container(
                height: parentHeight*0.05,
                width: parentWidth*0.18,
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Visibility(
                          visible: !isLike,
                          child: GestureDetector(
                            onDoubleTap: (){},
                            onTap: (){
                              if(mounted){
                                setState(() {
                                  isLike = !isLike;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.favorite_outline_rounded,
                                color: CommonColor.BLACK_COLOR,
                                size: parentHeight*0.035,),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isLike,
                          child: GestureDetector(
                            onDoubleTap: (){},
                            onTap: (){
                              if(mounted){
                                setState(() {
                                  isLike = !isLike;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.favorite_rounded,
                                color: CommonColor.LIKE_COLOR,
                              size: parentHeight*0.035,),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Image(image: AssetImage("assets/images/share.png"),
                      color: Colors.black,
                      height: parentHeight*0.035,
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
                padding: EdgeInsets.only(top: parentWidth*0.01),
                child: RatingBar.builder(
                  initialRating: 3.5,
                  itemSize:20,
                  glow: false,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
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
                padding: EdgeInsets.only(top: parentHeight*0.015/*, right: parentWidth*0.02*/),
                child: Row(
                  children: [
                    Container(
                      height: parentHeight*0.033,
                      width: parentWidth*0.18,
                      decoration: BoxDecoration(
                          color: CommonColor.REVIEW_CONTAINER_COLOR,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You Save",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto_Regular'
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only( left: parentWidth*0.02),
                          child: Text("Rs. 34.00",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto_Regular'
                            ),
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
            padding: EdgeInsets.only(top: parentHeight*0.003),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Rs.154",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal*4.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500
                      ),textAlign: TextAlign.center,),

                    Padding(
                      padding: EdgeInsets.only(left: parentWidth*0.02),
                      child: Text("Rs.189",
                        style: TextStyle(
                            color: CommonColor.DISCOUNT_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal*3.0,
                            fontFamily: 'Roboto_Normal',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough
                        ),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: count == 0 ? true : false,
                      child: GestureDetector(
                        onDoubleTap: (){},
                        onTap: (){
                          if(mounted){
                            setState(() {
                              count++;
                            });
                          }
                        },
                        child: Container(
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
                        ),
                      ),
                    ),
                    Visibility(
                      visible: count != 0 ? true : false,
                      child: Row(
                        children: [
                          GestureDetector(
                            onDoubleTap: (){},
                            onTap: (){
                              if(mounted){
                                setState(() {
                                  count--;
                                });
                              }
                            },
                            child: Container(
                              height: parentHeight*0.029,
                              width: parentWidth*0.065,
                              decoration: BoxDecoration(
                                color: CommonColor.APP_BAR_COLOR,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(child: Text("-",
                              style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal*5.6
                              ),textScaleFactor: 1.0,)),
                            ),
                          ),
                          Container(
                            height: parentHeight*0.029,
                            width: parentWidth*0.07,
                            decoration: BoxDecoration(
                                color: CommonColor.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text("$count",
                              style: TextStyle(
                                  color: CommonColor.BLACK_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal*3.5
                              ),textScaleFactor: 1.0,)),
                          ),
                          GestureDetector(
                            onDoubleTap: (){},
                            onTap: (){
                              if(mounted){
                                setState(() {
                                    count++;
                                });
                              }
                            },
                            child: Container(
                              height: parentHeight*0.029,
                              width: parentWidth*0.065,
                              decoration: BoxDecoration(
                                color: CommonColor.APP_BAR_COLOR,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(child: Text("+",
                              style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal*5.0
                              ),textScaleFactor: 1.0,)),
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
                  padding: EdgeInsets.only(top: parentHeight*0.02),
                  child: Container(
                    height: parentHeight*0.001,
                    width: parentWidth*0.9,
                    color: CommonColor.CIRCLE_COLOR,
                    child: Text("Hii",
                    style: TextStyle(
                      color: Colors.transparent
                    ),),
                  ),
                ),
                Padding(
                padding: EdgeInsets.only(top: parentHeight*0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.02),
                      child: Container(
                        height: parentHeight * 0.023,
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
                        padding: EdgeInsets.only(left: parentWidth*0.02),
                        child: Text("10 Days Return Policy",
                        style: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*4.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto_Regular'
                        ),),
                      )
                    ],
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight*0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth*0.02),
                      child: Container(
                        height: parentHeight*0.023,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColor.OFFER_COLOR ,
                        ),
                        child: Text("Hii",
                          style: TextStyle(
                              color: Colors.transparent
                          ),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth*0.02),
                      child: Text("Order Can Cancel Till Order Processed",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal*4.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto_Regular'
                        ),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight*0.02),
                child: Container(
                  height: parentHeight*0.001,
                  width: parentWidth*0.9,
                  color: CommonColor.CIRCLE_COLOR,
                  child: Text("Hii",
                    style: TextStyle(
                        color: Colors.transparent
                    ),),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: parentHeight*0.02,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Product Details",
                    style: TextStyle(
                      color: CommonColor.BLACK_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight*0.02,),
                child: ReadMoreText(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  trimLines: 3,
                  preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                  style: TextStyle(
                      color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                  fontWeight: FontWeight.w400),
                  textScaleFactor: 1.05,
                  colorClickableText: CommonColor.APP_BAR_COLOR,
                  trimMode: TrimMode.Length,
                  trimCollapsedText: 'Read More Details',
                  trimExpandedText: ' Show Less',
                ),
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
                padding: EdgeInsets.only(right: parentWidth*0.05),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,bottom: parentHeight * 0.01, left: parentWidth*0.05),
                    child: Container(
                      height: parentHeight*0.17,
                      width: parentWidth*0.47,
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
                                  height: parentHeight*0.17,
                                  width: parentWidth*0.47,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(image: AssetImage("assets/images/carosel_demo.png"),
                                      fit: BoxFit.cover,),
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: parentHeight*0.015),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: parentWidth*0.15,
                                      height: parentHeight*0.027,
                                      decoration: BoxDecoration(
                                          color: CommonColor.APP_BAR_COLOR,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)
                                          )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("30% off",
                                            style: TextStyle(
                                                color: CommonColor.WHITE_COLOR,
                                                fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto_Regular'
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: parentWidth*0.02),
                                        child: /*Image(image: AssetImage("assets/images/like_icon.png"),
                                      height: parentHeight*0.02,
                                      ),*/
                                        Icon(Icons.favorite_outline_rounded,
                                          color: CommonColor.LIKE_COLOR,)
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: parentHeight*0.13,
                                width: parentWidth*0.47,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.01, left: parentWidth*0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("TATA Tea Premium",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w400
                                            ),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.01, left: parentWidth*0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Rs 34.00",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w500
                                            ),textAlign: TextAlign.center,),

                                          Padding(
                                            padding: EdgeInsets.only(left: parentWidth*0.02),
                                            child: Text("Rs 35.00",
                                              style: TextStyle(
                                                  color: CommonColor.DISCOUNT_COLOR,
                                                  fontSize: SizeConfig.blockSizeHorizontal*3.0,
                                                  fontFamily: 'Roboto_Normal',
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration.lineThrough
                                              ),textAlign: TextAlign.center,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.015, left: parentWidth*0.02, right: parentWidth*0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: parentHeight*0.033,
                                            width: parentWidth*0.13,
                                            decoration: BoxDecoration(
                                                color: CommonColor.REVIEW_CONTAINER_COLOR,
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("4.5",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Roboto_Medium'
                                                  ),
                                                ),

                                                Icon(Icons.star,
                                                  color: CommonColor.REVIEW_COLOR,
                                                  size: parentHeight*0.02,)
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
                                                  onDoubleTap: () {},
                                                  onTap: () {
                                                    if (mounted) {
                                                      setState(() {
                                                        count--;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: parentHeight * 0.035,
                                                    width: parentWidth * 0.067,
                                                    decoration: BoxDecoration(
                                                        color: CommonColor
                                                            .APP_BAR_COLOR,
                                                        borderRadius:
                                                        BorderRadius.circular(
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
                                                  height: parentHeight * 0.035,
                                                  width: parentWidth * 0.07,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      CommonColor.WHITE_COLOR,
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
                                                  onDoubleTap: () {},
                                                  onTap: () {
                                                    if (mounted) {
                                                      setState(() {
                                                        count++;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: parentHeight * 0.035,
                                                    width: parentWidth * 0.067,
                                                    decoration: BoxDecoration(
                                                        color: CommonColor
                                                            .APP_BAR_COLOR,
                                                        borderRadius:
                                                        BorderRadius.circular(
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
                                  onDoubleTap: (){},
                                  onTap:(){
                                    if(mounted){
                                      setState(() {
                                        count++;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: parentHeight*0.06,
                                    width: parentWidth*0.13,
                                    decoration: BoxDecoration(
                                        color: CommonColor.APP_BAR_COLOR,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )
                                    ),
                                    child: Icon(
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
}
