import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/door_step_order.dart';
import 'package:flutter/material.dart';



class ShippedOrderScreen extends StatefulWidget {
  const ShippedOrderScreen({Key? key}) : super(key: key);

  @override
  State<ShippedOrderScreen> createState() => _ShippedOrderScreenState();
}

class _ShippedOrderScreenState extends State<ShippedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [

          Container(
            // color: Colors.red,
            height: SizeConfig.screenHeight*0.83,
            child: ListView.builder(
                padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.03,
                    left: SizeConfig.screenWidth*0.03),
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01, bottom: SizeConfig.screenHeight*0.01),
                    child: getOrderDetails(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  );
                }),
          ),

        ],
      ),
    );
  }

  Widget getOrderDetails(double parentHeight, double parentWidth){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: CommonColor.CIRCLE_COLOR,width: 3.0)
      ),
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(left: parentWidth*0.03, right: parentWidth*0.03,
                top: parentHeight*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order No : 10",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto_Medium'
                  ),),
                Text("\u20B9240.00",
                  style: TextStyle(
                      color: CommonColor.APP_BAR_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto_Medium'
                  ),)
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: parentWidth*0.03, top: parentHeight*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("1 Item",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*3.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto_Regular'
                  ),),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: parentWidth*0.03, top: parentHeight*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Moong Dal Yellow",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto_Medium'
                  ),),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: parentWidth*0.03, top: parentHeight*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Placed order on 27-2-2023",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto_Medium'
                  ),),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: parentWidth*0.03, right: parentWidth*0.03, top: parentHeight*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: parentHeight*0.04,
                  width: parentWidth*0.2,
                  decoration: BoxDecoration(
                    color: CommonColor.ORDER_SHIPPED_COLOR,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text("Shiped",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal*3.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto_Medium'
                      ),),
                  ),
                ),
                GestureDetector(
                  onDoubleTap: (){},
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoorStepOrder()));
                  },
                  child: Container(
                    height: parentHeight*0.04,
                    width: parentWidth*0.4,
                    decoration: BoxDecoration(
                      color: CommonColor.ORDER_PLACED_COLOR,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(2, 2.0))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(Icons.delivery_dining_rounded,
                          size: parentHeight*0.025,
                          color:Colors.black38,),

                        Padding(
                          padding: EdgeInsets.only(left: parentWidth*0.01),
                          child: Text("Door Step Delivery",
                            style: TextStyle(
                                color:Colors.black54,
                                fontSize: SizeConfig.blockSizeHorizontal*3.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto_Medium'
                            ),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: parentHeight*0.012,
          )


        ],
      ),
    );
  }
}
