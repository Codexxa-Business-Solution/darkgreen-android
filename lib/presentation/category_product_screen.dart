import 'dart:convert';

import 'package:darkgreen/api_model/categories/get_sub_categories_by_id_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/constant/top_header_layout.dart';
import 'package:darkgreen/presentation/category_product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProduct extends StatefulWidget {
  final String proName;
  final String catId;

  const CategoryProduct({Key? key, required this.proName, required this.catId})
      : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  void initState() {
    super.initState();
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
              child: ToHeadLayout(
                title: widget.proName,
              )),
          Container(
              color: CommonColor.WHITE_COLOR,
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
              top: parentHeight * 0.03,
              left: parentWidth * 0.03,
              right: parentWidth * 0.03,
            ),
            shrinkWrap: true,
            itemCount: snap.data?.data.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    height: parentHeight * 0.27),
            itemBuilder: (context, index) {
              final img = data.data[index].image.isNotEmpty
                  ? Image.network(
                      "${data.data[index].image}",
                    )
                  : Image.network("");

              return Padding(
                padding: EdgeInsets.only(
                  top: parentHeight * 0.01,
                  bottom: parentHeight * 0.01,
                  right: parentWidth * 0.03,
                  left: parentWidth * 0.03,
                ),
                child: GestureDetector(
                  onDoubleTap: () {},
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPriceDetails(
                                  subProName: data.data[index].name,
                                  subCatId: data.data[index].id,
                                )));
                  },
                  child: Container(
                    width: parentWidth * 0.35,
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
                            height: parentHeight * 0.19,
                            width: parentWidth * 0.41,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: img)),
                        Container(
                          height: parentHeight * 0.06,
                          decoration: BoxDecoration(
                            color: CommonColor.LAYOUT_BACKGROUND_COLOR,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
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
                        ),
                      ],
                    ),
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
