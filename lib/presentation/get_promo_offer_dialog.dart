import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/order/get_promo_code_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:darkgreen/presentation/checkout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';



class PromoCodeScreen extends StatefulWidget {

  final String orderFormat;
  final String selectAddId;
  final int deliverCharges;
  final int amount;

  const PromoCodeScreen({Key? key, required this.orderFormat, required this.selectAddId, required this.deliverCharges, required this.amount}) : super(key: key);

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {



  @override
  void initState() {
    // TODO: implement initState
    print("diOF ${widget.orderFormat}");
    print("diOF ${widget.selectAddId}");
    print("diDC ${widget.deliverCharges}");
    AllCommonApis().getPromoCode("${widget.amount}");
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * .13,
            right: SizeConfig.screenWidth * .13),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child:  Container(
            height: SizeConfig.screenHeight*0.6,
            decoration:  const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(25.0)),
              color: CommonColor.LAYOUT_BACKGROUND_COLOR,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [

              FutureBuilder<GetPromoCodeResponseModel>(
                  future: AllCommonApis().getPromoCode("${widget.amount}"),
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
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03, bottom: SizeConfig.screenHeight*0.05),
                        scrollDirection: Axis.vertical,
                        itemCount: snap.data?.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03, left: SizeConfig.screenWidth*0.05,
                                right: SizeConfig.screenWidth*0.05),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03,
                                    right: SizeConfig.screenWidth*0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: SizeConfig.screenWidth*0.6,
                                      child: Text("${snap.data?.data[index].message}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'
                                        ),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01),
                                      child: Text("You will save \u{20B9}${snap.data?.data[index].discount} with this code.",
                                        style: TextStyle(
                                            color: CommonColor.APP_BAR_COLOR,
                                            fontSize: SizeConfig.blockSizeHorizontal*3.2,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'
                                        ),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DottedBorder(
                                            padding: EdgeInsets.all(7),
                                            color: CommonColor.APP_BAR_COLOR,
                                            radius: const Radius.circular(200),
                                            strokeWidth: 1,
                                            dashPattern: [5,5],
                                            child: Text("${snap.data?.data[index].promoCode}",
                                              style: TextStyle(
                                                  color: CommonColor.CIRCLE_COLOR,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.01),
                                            child: GestureDetector(
                                              onDoubleTap: (){},
                                              onTap: (){

                                                AllCommonApis().getPromoCodeValid("${widget.amount}", "${snap.data?.data[index].promoCode}").then((value){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                      AddCheckPayParentScreen(index: 1, deliveryCharges: widget.deliverCharges,
                                                    orderFormat: widget.orderFormat,
                                                    addressId:  widget.selectAddId,
                                                    promoDiscount: value.discount,
                                                    promoCode: value.promoCode,)));
                                                });


                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Text("Apply",
                                                  style: TextStyle(
                                                      color: CommonColor.APP_BAR_COLOR,
                                                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Roboto_Medium'
                                                  ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight*0.02,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.clear,
                      color: Colors.red,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
