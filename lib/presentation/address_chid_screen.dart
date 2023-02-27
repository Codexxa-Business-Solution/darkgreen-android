import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/Address.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:flutter/material.dart';


class AddressSelectScreen extends StatefulWidget {

  const AddressSelectScreen({Key? key}) : super(key: key);

  @override
  State<AddressSelectScreen> createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.LAYOUT_BACKGROUND_COLOR,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCheckPayParentScreen(index: 1)));
            },
            child: Container(
              height: SizeConfig.screenHeight*0.9,
                color: Colors.white,
              child: Padding(
                padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.07),
                child: NameAddressLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
              )
            ),
          ),
          getBottomText(SizeConfig.screenHeight, SizeConfig.screenWidth)
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.07, right: SizeConfig.screenWidth*0.03),
        child: FloatingActionButton(
          child: Icon(Icons.add,
          size: SizeConfig.blockSizeHorizontal*9.0,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Address(isCome: '1',)));
          },),
      ),
    );
  }



  Widget NameAddressLayout(double parentHeight, double parentWidth){
    return ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(bottom: 20, top: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03,
                left: SizeConfig.screenWidth*0.03,
                right: SizeConfig.screenWidth*0.03,),
            child: Container(
              height: SizeConfig.screenHeight*0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.17),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.015,
                        left: parentWidth*0.03, right: parentWidth*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(Icons.circle_outlined,
                                  color: CommonColor.APP_BAR_COLOR,),
                                Padding(
                                  padding: EdgeInsets.only(right: parentWidth*0.0027),
                                  child: Icon(Icons.circle,
                                    color: CommonColor.APP_BAR_COLOR,
                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: parentWidth*0.01),
                              child: Container(
                                width: parentWidth*0.3,
                                color: Colors.transparent,
                                child: Text("Ashish Bhosale",
                                  style: TextStyle(
                                    color: CommonColor.APP_BAR_COLOR,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontFamily: 'Roboto_Medium',
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),maxLines: 1,),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: parentWidth*0.02),
                              child: Container(
                                height: parentHeight*0.03,
                                width: parentWidth*0.14,
                                decoration: BoxDecoration(
                                    color: CommonColor.APP_BAR_COLOR,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("Home",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto_Medium',
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeHorizontal*3.0
                                  ),)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: parentWidth*0.02),
                              child: Container(
                                height: parentHeight*0.03,
                                width: parentWidth*0.17,
                                decoration: BoxDecoration(
                                    color: CommonColor.APP_BAR_COLOR,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("Default",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto_Medium',
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeHorizontal*3.0
                                  ),)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: parentWidth*0.02),
                              child: GestureDetector(
                                onDoubleTap: (){},
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Address(isCome: '2',)));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                    child: Icon(Icons.edit)
                                ),
                              ),
                            ),
                            Icon(Icons.delete_forever),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.017, left: parentWidth*0.1, right: parentWidth*0.04),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text("City Avenue, Wakad Bridge, Bhumkar Chawk, Pune, Maharashtra",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto_Medium',
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0
                                ),
                                maxLines: 4,)
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget getBottomText(double parentHeight, double parentWidth){
    return Container(
      height: SizeConfig.screenHeight*0.07,
      decoration: BoxDecoration(
        color: CommonColor.APP_BAR_COLOR,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              spreadRadius: 3,
              offset: Offset(2, 2.0))
        ],
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
                Text("Rs.154",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400
                  ),),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.005),
                  child: Text("1 Item",
                    style: TextStyle(
                        color: CommonColor.WHITE_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal*4.0,
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCheckPayParentScreen(index: 1,)));
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text("Continue",
                      style: TextStyle(
                          color: CommonColor.WHITE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*5.0,
                          fontFamily: 'Roboto_Bold',
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
    );
  }

}
