import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/constant/top_header_layout.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:flutter/material.dart';



class ProductPriceDetails extends StatefulWidget {

  final String subProName;

  const ProductPriceDetails({Key? key, required this.subProName}) : super(key: key);

  @override
  State<ProductPriceDetails> createState() => _ProductPriceDetailsState();
}

class _ProductPriceDetailsState extends State<ProductPriceDetails> {


  bool isFav = false;
  int count = 0;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: CommonColor.APP_BAR_COLOR,
              height: SizeConfig.screenHeight*0.12,
              child: /*getAddMainHeadingLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)*/ToHeadLayout(title: widget.subProName,)
          ),
          Container(
              color: CommonColor.WHITE_COLOR,
              height: SizeConfig.screenHeight*0.88,
              child: getProductDetailsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
          ),
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
          Text(
            "Edible Oil",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
              fontFamily: 'Roboto_Medium',
              fontWeight: FontWeight.w400,
              color: CommonColor.WHITE_COLOR,),
          ),
          Container(
            child: Icon(
              Icons.search_outlined,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget getProductDetailsLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
      child: GridView.builder(
          padding: EdgeInsets.only(bottom: parentHeight*0.05, top: parentHeight*0.03,
            left: parentWidth*0.0,right: parentWidth*0.03,),
          shrinkWrap: true,
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              height: parentHeight*0.33
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.01,bottom: parentHeight * 0.01, left: parentWidth*0.05),
              child: GestureDetector(
                onDoubleTap: (){},
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInfoScreen()));
                },
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
                              height: parentHeight*0.18,
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
                                    child: Stack(
                                      children: [
                                        Visibility(
                                          visible: !isFav,
                                          child: GestureDetector(
                                            onDoubleTap: (){},
                                            onTap: (){
                                              if(mounted){
                                                setState(() {
                                                  isFav = !isFav;
                                                });
                                              }
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Icon(Icons.favorite_outline_rounded,
                                                color: CommonColor.LIKE_COLOR,),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isFav,
                                          child: GestureDetector(
                                            onDoubleTap: (){},
                                            onTap: (){
                                              if(mounted){
                                                setState(() {
                                                  isFav = !isFav;
                                                });
                                              }
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Icon(Icons.favorite_rounded,
                                                color: CommonColor.LIKE_COLOR,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )

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
                            height: parentHeight*0.13,
                            width: parentWidth*0.47,
                            decoration: BoxDecoration(
                                // color: Colors.red,
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
                                        height: parentHeight*0.035,
                                        width: parentWidth*0.13,
                                        decoration: BoxDecoration(
                                            color: CommonColor.REVIEW_CONTAINER_COLOR,
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: parentWidth*0.02),
                                              child: Text("4.5",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto_Medium'
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(right: parentWidth*0.015),
                                              child: Icon(Icons.star,
                                                color: CommonColor.REVIEW_COLOR,
                                                size: parentHeight*0.018,),
                                            )
                                          ],
                                        ),
                                      ),
                                      /*Container(
                                        height: parentHeight*0.046,
                                        width: parentWidth*0.21,
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
                                                  fontSize: SizeConfig.blockSizeHorizontal*3.5,
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
              ),
            );
          }),
    );
  }
}


