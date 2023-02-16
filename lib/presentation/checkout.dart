import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  int currentIndex = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(

        children: [
          Container(

          child:  getAddMainHeadingLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
            // child: Column(
            //   children: [
            //     getAddMainHeadingLayout(
            //         SizeConfig.screenHeight, SizeConfig.screenWidth),
            //     Center(
            //       child: Padding(
            //         padding:
            //         EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
            //         child: const Image(
            //           image: AssetImage(
            //             "assets/images/appLogo.jpg",
            //           ),
            //           height: 70,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),

          Container(
            child:
            getOrderSummery(SizeConfig.screenHeight,SizeConfig.screenWidth),
          )

        ],
        //  BackScreen(SizeConfig.screenHeight,SizeConfig.screenWidth);
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth)
  {
    return Container(
      height: parentHeight*0.1,
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
              onDoubleTap: () {},
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
                "Checkout",
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
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .03,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOrderSummery(double parentHeight,double parentWidth){
    return Padding(
      padding:  EdgeInsets.only(top: parentHeight*0.0,),
      child:
      Container(
       height: parentHeight*0.9,
        child: ListView.builder(

            itemCount: 3,
            itemBuilder: (context,index){

          return Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01,bottom: parentHeight * 0.01, left: parentWidth*0.02),
            child: Container(
              height: parentHeight*0.23,
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
                children:  [
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.02),
                    child: Text("Order Summery", style:TextStyle(
                        fontFamily: "Roboto_Bold",
                        fontWeight: FontWeight.w500,
                        fontSize:
                        SizeConfig.blockSizeHorizontal *
                            4.4,
                        color: CommonColor.BLACK_COLOR),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: parentHeight*0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: parentWidth*0.23,
                          width: parentWidth*0.22,
                          decoration: BoxDecoration(
                              color: CommonColor.GRAY_COLOR,
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/dark.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              children: [

                                 Padding(
                                  padding: EdgeInsets.only(left: parentWidth*0.03,right: parentWidth*0.01,top: parentHeight*0.01),
                                  child: Container(

                                    width: parentWidth*0.61,
                                    child: Text("Fortune Sunlite Refined Sunflower Oil ( 1 L)",style:TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            4.0,
                                        color: CommonColor.BLACK_COLOR),),
                                  ),),
                                Padding(
                                    padding:  EdgeInsets.only(bottom: parentHeight*0.02),
                                    child: Container(
                                    height: parentHeight*0.03,

                                    child:

                                    Image(image: AssetImage('assets/images/delete.png',),)
                               ),
                                  ),
                              ],
                            ),
                            Row(
                             children: [
                               Padding(
                                 padding: EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.02),
                                 child: Text("Rs.154",
                                   style: TextStyle(
                                       color: Colors.black,
                                       fontSize: SizeConfig.blockSizeHorizontal*4.7,
                                       fontFamily: 'Roboto_Medium',
                                       fontWeight: FontWeight.w500
                                   ),textAlign: TextAlign.center,),
                               ),

                               Padding(
                                 padding: EdgeInsets.only(left: parentWidth*0.02,top: parentHeight*0.02),
                                 child: Text("Rs.189",
                                   style: TextStyle(
                                       color: CommonColor.RS_COLOR,
                                       fontSize: SizeConfig.blockSizeHorizontal*4.7,
                                       fontFamily: 'Roboto_Normal',
                                       fontWeight: FontWeight.w400,
                                       decoration: TextDecoration.lineThrough
                                   ),textAlign: TextAlign.center,),
                               ),
                               Padding(
                                 padding: EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.15),
                                 child: Column(
                                   children: [

                                     Visibility(
                                       visible: count != 0 ? true : true,
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
                                               height: parentHeight*0.035,
                                               width: parentWidth*0.067,
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
                                             height: parentHeight*0.035,
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
                                               height: parentHeight*0.035,
                                               width: parentWidth*0.067,
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
                               ),
                             ],
                            )

                          ],
                        ),








                      ],
                    ),

                  ),




                ],
              ),
            ),
          );

        }),


      )






    );

  }






}
