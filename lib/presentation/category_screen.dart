import 'dart:convert';
import 'package:darkgreen/api_model/categories/get_all_categories_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  final CategoryScreenInterface mListener;

  const CategoryScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    allCategoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: getCategoryGridLayout(
          SizeConfig.screenHeight, SizeConfig.screenWidth),
    );
  }

  Widget getCategoryGridLayout(double parentHeight, double parentWidth) {
    return FutureBuilder<GetAllCategoriesResponseModel>(
      future: allCategoriesApi(),
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
                  
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryProduct(
                                  proName: "${data.data[index].name}",
                                  catId: "${data.data[index].id}",
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
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: img,
                            )),
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
                                      SizeConfig.blockSizeHorizontal * 4.0,
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

  Future<GetAllCategoriesResponseModel> allCategoriesApi() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().allCategories),
        body: {"accesskey": ApiConstants().accessKey},
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("allCategoriesResponse -->  ${body}");

      return getAllCategoriesResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}

abstract class CategoryScreenInterface {}
