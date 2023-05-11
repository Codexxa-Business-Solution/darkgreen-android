import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/cart/get_save_for_later_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';





class SaveForLater extends StatefulWidget {
  const SaveForLater({Key? key}) : super(key: key);

  @override
  State<SaveForLater> createState() => _SaveForLaterState();
}

class _SaveForLaterState extends State<SaveForLater> {



  String productVariantId = "";
  String productId = "";
  int count = 0;


  void refresh() {
    AllCommonApis().getSaveForLater().then((value){
      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: getAddMainHeadingLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
          Column(
            children: [
              getAllLaterCart(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ],
          )
        ],
        //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
      ),
    );
  }


  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Container(
      height: parentHeight * 0.1,
      color: CommonColor.APP_BAR_COLOR,
      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              
              child: Padding(
                padding: EdgeInsets.only(left: parentWidth * .04),
                child: Container(
                  padding: EdgeInsets.only(top: parentHeight * 0.02),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: parentHeight * .025,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.02),
              child: Text(
                "Save For Later",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: parentWidth * .04),
              child: Container(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .025,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget getAllLaterCart(double parentHeight, double parentWidth) {
    return Container(
      height: parentHeight * 0.9,
      child: FutureBuilder<GetSaveForLaterResponseModel>(
        future: AllCommonApis().getSaveForLater(),
        builder: (context, snap) {
          if (!snap.hasData && !snap.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snap.data;

          if (data?.message == "Data not found!") {
            return const Center(
              child: Text("No later items found in user cart!"),
            );
          }
          return ListView.builder(
              itemCount: snap.data?.data.length,
              padding: EdgeInsets.only(bottom: parentHeight * 0.13),
              itemBuilder: (context, index) {
                print("lent ${snap.data?.data.length}");

                final img = data?.data[index].image != null
                    ? Image.network(
                  "${data?.data[index].image}",
                )
                    : Image.network("");

                return Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.01,
                      bottom: parentHeight * 0.01,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: Container(
                    height: parentHeight * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: const Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: const Offset(5, 0),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(top: parentHeight * 0.02, left: parentWidth*0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: parentWidth * 0.2,
                                  width: parentWidth * 0.2,
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                          offset: Offset(1, 2))
                                    ],
                                    color: CommonColor.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(8),
                                    // border: Border.all(color: Colors.black, width: parentWidth*0.0005)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: img,
                                  )),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: parentWidth * 0.03,
                                          right: parentWidth * 0.01,),
                                        child: Container(
                                          width: parentWidth * 0.61,
                                          color: Colors.transparent,
                                          child: Text(
                                            "${snap.data?.data[index].name}",
                                            style: TextStyle(
                                                fontFamily:
                                                "Roboto_Regular",
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                    .blockSizeHorizontal *
                                                    4.0,
                                                color: CommonColor
                                                    .BLACK_COLOR),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: parentHeight * 0.02),
                                          child: GestureDetector(
                                            onTap: () {
                                              productVariantId =
                                              "${snap.data?.data[index].productVariantId}";

                                              var result = AllCommonApis().deleteSaveForLater(productVariantId);

                                              result.then((value) {
                                                if (mounted) {
                                                  setState(() {
                                                    refresh();
                                                  });
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: parentHeight * 0.03,
                                              color: Colors.transparent,
                                              child: Icon(Icons
                                                  .delete_forever_rounded),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    width: parentWidth*0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: parentWidth * 0.03),
                                          child: Container(
                                            color: Colors.transparent,
                                            width: parentWidth*0.65,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Rs.${snap.data?.data[index].discountedPrice}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          4.5,
                                                      fontFamily: 'Roboto_Medium',
                                                      fontWeight:
                                                      FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: parentWidth*0.02),
                                                  child: Text(
                                                    "Rs.${snap.data?.data[index].price}",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .DISCOUNT_COLOR,
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            4.5,
                                                        fontFamily: 'Roboto_Medium',
                                                        fontWeight: FontWeight.w500,
                                                        decoration: TextDecoration
                                                            .lineThrough),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: parentWidth*0.02),
                                                  child: Text(
                                                    "${snap.data?.data[index].measurement}${snap.data?.data[index].unit}",
                                                    style: TextStyle(
                                                        color: CommonColor
                                                            .DISCOUNT_COLOR,
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3.0,
                                                        fontFamily: 'Roboto_Medium',
                                                        fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                        Padding(
                          padding:
                          EdgeInsets.only(top: parentHeight * 0.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.05),
                                child: Text(
                                  "Move To Cart",
                                  style: TextStyle(
                                      color: Colors.transparent,
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal *
                                          4.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Medium'),
                                ),
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.transparent,
                                    fontSize:
                                    SizeConfig.blockSizeHorizontal *
                                        4.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto-Medium'),
                              ),
                              GestureDetector(
                                onDoubleTap: (){},
                                onTap: (){

                                  productId = "${snap.data?.data[index].productId}";

                                  productVariantId = "${snap.data?.data[index].productVariantId}";

                                  count = int.parse(
                                      "${snap.data?.data[index].qty}");

                                  AllCommonApis()
                                      .addToCartApi(
                                      productId,
                                      productVariantId,
                                      count
                                          .toString())
                                      .then((value) {
                                    if (mounted) {
                                      setState(() {
                                        print("hhuihuhuihhui");
                                        refresh();
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: parentWidth * 0.05),
                                    child: Text(
                                      "Move to cart",
                                      style: TextStyle(
                                          color: CommonColor.APP_BAR_COLOR,
                                          fontSize:
                                          SizeConfig.blockSizeHorizontal *
                                              4.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto-Medium'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
