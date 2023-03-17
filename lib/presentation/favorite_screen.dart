import 'dart:convert';
import 'package:darkgreen/api_model/allCommonApis/common_api.dart';
import 'package:http/http.dart' as http;
import 'package:darkgreen/api_model/favorite/fav_products_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/products_info_screen.dart';
import 'package:flutter/material.dart';



class FavoriteScreen extends StatefulWidget {

  final FavoriteScreenInterface mListener;

  const FavoriteScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


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
    AllCommonApis().getAllFavoriteProductsApi();
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
             color: Colors.transparent,
             height: SizeConfig.screenHeight*0.8,
               child: getProductDetailsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
           )
        ],
      ),
    );
  }


  Widget getProductDetailsLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
      child: FutureBuilder<GetAllFavProductsResponseModel>(
        future: AllCommonApis().getAllFavoriteProductsApi(),
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

          return GridView.builder(
              padding: EdgeInsets.only(bottom: parentHeight*0.05, top: parentHeight*0.03,
                left: parentWidth*0.0,right: parentWidth*0.03,),
              shrinkWrap: true,
              itemCount: snap.data?.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  height: parentHeight*0.33
              ),
              itemBuilder: (context, index) {

                final img = data.data[index].image.isNotEmpty
                    ? Image.network(
                  data.data[index].image,
                )
                    : Image.network("");


                return Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.01,bottom: parentHeight * 0.01, left: parentWidth*0.05),
                  child: GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductInfoScreen()));
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
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: img,
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
                                      decoration: const BoxDecoration(
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


                                    snap.data?.data[index].isFavorite == true ?
                                    Padding(
                                      padding: EdgeInsets.only(right: parentWidth*0.02),
                                      child: GestureDetector(
                                        onDoubleTap: (){},
                                        onTap: (){

                                          productId = "${snap.data?.data[index].variants[0].productId}";

                                         var result = AllCommonApis().removeToFavorite(productId);

                                         result.then((value) {
                                           if(mounted){
                                             setState((){});
                                           }
                                         });

                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Icon(Icons.favorite_rounded,
                                            color: CommonColor.LIKE_COLOR,),
                                        ),
                                      ),
                                    ) :
                                    Padding(
                                      padding: EdgeInsets.only(right: parentWidth*0.02),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: const Icon(Icons.favorite_outline_rounded,
                                          color: CommonColor.LIKE_COLOR,),
                                      ),
                                    )

                                    /*Padding(
                                        padding: EdgeInsets.only(right: parentWidth*0.02),
                                        child: Stack(
                                          children: [
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
                                                  child: const Icon(Icons.favorite_outline_rounded,
                                                    color: CommonColor.LIKE_COLOR,),
                                                ),
                                              ),
                                            ),
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
                                                  child: const Icon(Icons.favorite_rounded,
                                                    color: CommonColor.LIKE_COLOR,),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )

                                    ),*/
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
                                decoration: const BoxDecoration(
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
                                      padding: EdgeInsets.only(top: parentHeight*0.01, left: parentWidth*0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Rs ${snap.data?.data[index].variants[0].discountedPrice}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*3.5,
                                                fontFamily: 'Roboto_Normal',
                                                fontWeight: FontWeight.w500
                                            ),textAlign: TextAlign.center,),

                                          Padding(
                                            padding: EdgeInsets.only(left: parentWidth*0.02),
                                            child: Text("Rs ${snap.data?.data[index].variants[0].price}",
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
                                                  child: Text("${snap.data?.data[index].ratings}",
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
                                                  onDoubleTap: () {},
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
                                                    AllCommonApis().addToCartApi(
                                                        productId,
                                                        productVariantId,
                                                        cartCount.toString());

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
                                                    AllCommonApis().addToCartApi(
                                                        productId,
                                                        productVariantId,
                                                        cartCount.toString());

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
                                  onDoubleTap: () {},
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
                                    AllCommonApis().addToCartApi(productId, productVariantId,
                                        cartCount.toString());

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
    );
  }


}


abstract class FavoriteScreenInterface{

}