import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';



class CategoryScreen extends StatefulWidget {

  final CategoryScreenInterface mListener;

  const CategoryScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: getCategoryGridLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
    );
  }


  Widget getCategoryGridLayout(double parentHeight, double parentWidth){
    return GridView.builder(
        padding: EdgeInsets.only(bottom: parentHeight*0.05, top: parentHeight*0.03),
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 6
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01,bottom: parentHeight * 0.01,
                left: parentWidth*0.03, right: parentWidth*0.03),
            child: Container(
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
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: parentHeight*0.2,
                      width: parentWidth*0.45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image(image: AssetImage("assets/images/carosel_demo.png"),
                          fit: BoxFit.cover,),
                      )
                  ),
                  Container(
                    // color: Colors.blue,
                    height: parentHeight*0.045,
                    width: parentWidth*0.44,
                    child: Center(
                      child: Text("Grocery",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal*4.0,
                            fontFamily: 'Roboto_Medium',
                            fontWeight: FontWeight.w400
                        ),textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}


abstract class CategoryScreenInterface{

}
