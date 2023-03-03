import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:flutter/material.dart';




class ToHeadLayout extends StatefulWidget {

  final String title;

  const ToHeadLayout({Key? key, required this.title}) : super(key: key);

  @override
  State<ToHeadLayout> createState() => _ToHeadLayoutState();
}

class _ToHeadLayoutState extends State<ToHeadLayout> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CommonColor.APP_BAR_COLOR,
      body: getTopText(SizeConfig.screenHeight, SizeConfig.screenWidth),
    );
  }

  Widget getTopText(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth*0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: parentWidth*0.12,
            decoration: BoxDecoration(
                color: CommonColor.CIRCLE_COLOR,
                shape: BoxShape.circle
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Container(
              color: Colors.transparent,
              width: parentWidth*0.6,
              child: Center(
                child: Text(widget.title,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                      fontFamily: "Roboto_Medium",
                      fontWeight: FontWeight.w500,
                      color: CommonColor.WHITE_COLOR
                  ),textAlign: TextAlign.center,),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth*0.035),
            child: Container(
              width: parentWidth*0.18,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search,
                    color: Colors.white,
                    size: parentHeight*0.035,),
                  GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Image(image: AssetImage("assets/images/trolly.png"),
                        height: parentHeight*0.03,),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
