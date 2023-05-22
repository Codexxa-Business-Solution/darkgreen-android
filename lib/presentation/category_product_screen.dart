import 'dart:convert';

import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/categories/get_sub_categories_by_id_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/category_product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'search_screen.dart';

class CategoryProduct extends StatefulWidget {
  final String proName;
  final String catId;

  const CategoryProduct({Key? key, required this.proName, required this.catId})
      : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    if(mounted){
      setState(() {
        AllCommonApis().getAllCarts().then((value){
          if(mounted){
            setState(() {
              cartCount = value.data.length;
              print(cartCount);
            });
          }
        });
      });
    }
    subCategoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: CommonColor.APP_BAR_COLOR,
              height: SizeConfig.screenHeight * 0.12,
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05, left: SizeConfig.screenWidth*0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth*0.12,
                      decoration: BoxDecoration(
                        color: CommonColor.CIRCLE_COLOR,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/images/appLogo.jpeg",),
                          fit: BoxFit.contain,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.screenHeight * 0.01),
                      child: Container(
                        color: Colors.transparent,
                        width: SizeConfig.screenWidth*0.6,
                        child: Center(
                          child: Text(widget.proName,
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
                      padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.02),
                      child: Container(
                        width: SizeConfig.screenWidth*0.2,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct())).then((value){
                                  setState(() {
                                    if(mounted){
                                      setState(() {
                                        AllCommonApis().getAllCarts().then((value) {
                                          if (mounted) {
                                            setState(() {
                                              cartCount = value.data.length;
                                              print(cartCount);
                                            });
                                          }
                                        });
                                      });
                                    }
                                  });
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Icon(Icons.search,
                                  color: Colors.white,
                                  size: SizeConfig.screenHeight*0.035,),
                              ),
                            ),
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())).then((value){
                                  setState(() {
                                    if(mounted){
                                      setState(() {
                                        AllCommonApis().getAllCarts().then((value) {
                                          if (mounted) {
                                            setState(() {
                                              cartCount = value.data.length;
                                              print(cartCount);
                                            });
                                          }
                                        });
                                      });
                                    }
                                  });
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01),
                                      child: Container(
                                        height: SizeConfig.screenHeight*0.05,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(image: AssetImage("assets/images/trolly.png"),
                                            height: SizeConfig.screenHeight*0.03,),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: cartCount == 0 ? false : true,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.04, right: SizeConfig.screenWidth*0.005),
                                        child: Container(
                                          height: SizeConfig.screenHeight*0.05,
                                          width: SizeConfig.screenWidth*0.05,
                                          decoration: BoxDecoration(
                                              color: CommonColor.WHITE_COLOR,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: CommonColor.APP_BAR_COLOR)
                                          ),
                                          child: Center(
                                            child: Text("$cartCount",
                                              style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal*2.5,
                                                  color: Colors.black
                                              ),),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Container(
              color: CommonColor.LAYOUT_BACKGROUND_COLOR,
              height: SizeConfig.screenHeight * 0.88,
              child: getCategoryProductGridLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth))
        ],
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * .05,
          left: parentWidth * 0.05,
          right: parentWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            
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
              color: CommonColor.WHITE_COLOR,
            ),
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

  Widget getCategoryProductGridLayout(double parentHeight, double parentWidth) {
    return FutureBuilder<GetSubCategoriesByIdResponseModel>(
      future: subCategoriesApi(),
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
            padding: EdgeInsets.only(
              bottom: parentHeight * 0.05,
              top: parentHeight * 0.02,
              left: parentWidth * 0.03,
              right: parentWidth * 0.03,
            ),
            shrinkWrap: true,
            itemCount: snap.data?.data.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 2,
                    height: parentHeight * 0.25),
            itemBuilder: (context, index) {
              final img = data.data[index].image.isNotEmpty
                  ? Image.network(
                      "${data.data[index].image}",
                    )
                  : Image.network("");

              return Padding(
                padding: EdgeInsets.only(
                  top: parentHeight * 0.0,
                  bottom: parentHeight * 0.01,
                  right: parentWidth * 0.03,
                  left: parentWidth * 0.03,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPriceDetails(
                                  subProName: data.data[index].name,
                                  subCatId: data.data[index].id,
                                ))).then((value){
                      setState(() {
                        if(mounted){
                          setState(() {
                            AllCommonApis().getAllCarts().then((value) {
                              if (mounted) {
                                setState(() {
                                  cartCount = value.data.length;
                                  print(cartCount);
                                });
                              }
                            });
                          });
                        }
                      });
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.1, 1),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          height: parentHeight * 0.17,
                          width: parentWidth * 0.4,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: img)),
                      Padding(
                        padding: EdgeInsets.only(top: parentHeight*0.02),
                        child: Text(
                          "${data.data[index].name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                              SizeConfig.blockSizeHorizontal * 3.7,
                              fontFamily: 'Roboto_Normal',
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Future<GetSubCategoriesByIdResponseModel> subCategoriesApi() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    print("${widget.catId}");

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().subCategories),
        body: {
          "accesskey": ApiConstants().accessKey,
          "category_id": widget.catId
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("subCategoriesResponse -->  ${body}");

      return getSubCategoriesByIdResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
