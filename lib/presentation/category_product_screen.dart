import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/category_product_details_screen.dart';
import 'package:flutter/material.dart';



class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key}) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: CommonColor.APP_BAR_COLOR,
            height: SizeConfig.screenHeight*0.12,
              child: getAddMainHeadingLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
          ),
          Container(
              color: CommonColor.WHITE_COLOR,
              height: SizeConfig.screenHeight*0.88,
              child: getCategoryProductGridLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
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
          Text(
            "Grocery",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                fontFamily: 'Roboto_Medium',
                fontWeight: FontWeight.w400,
              color: CommonColor.WHITE_COLOR,),
          ),
          Container(
            child: Icon(
              Icons.search_outlined,
              color: CommonColor.WHITE_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCategoryProductGridLayout(double parentHeight, double parentWidth){
    return GridView.builder(
        padding: EdgeInsets.only(bottom: parentHeight*0.05, top: parentHeight*0.03,
          left: parentWidth*0.03,right: parentWidth*0.03,),
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            height: parentHeight*0.27
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01,
              bottom: parentHeight * 0.01,
              right: parentWidth*0.03,
              left: parentWidth*0.03,
            ),
            child: GestureDetector(
              onDoubleTap: (){},
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPriceDetails()));
              },
              child: Container(
                width: parentWidth*0.35,
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
                          // color: Colors.blue
                        ),
                        height: parentHeight*0.19,
                        width: parentWidth*0.41,
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
                      height: parentHeight*0.055,
                      child: Center(
                        child: Text("Grocery",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                              fontFamily: 'Roboto_Normal',
                              fontWeight: FontWeight.w400
                          ),textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
