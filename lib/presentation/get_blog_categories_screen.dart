import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/settings/blog_categories_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/custom_grid_view.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';

class GetBlogCategories extends StatefulWidget {
  const GetBlogCategories({Key? key}) : super(key: key);

  @override
  State<GetBlogCategories> createState() => _GetBlogCategoriesState();
}

class _GetBlogCategoriesState extends State<GetBlogCategories> {
  @override
  void initState() {
    super.initState();
    AllCommonApis().getBlogCategoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.12,
            color: CommonColor.APP_BAR_COLOR,
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                    child: GestureDetector(
                      onDoubleTap: () {},
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Blogs",
                    style: TextStyle(
                        color: CommonColor.WHITE_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 6.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: SizeConfig.screenWidth * 0.03),
                    child: const Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: SizeConfig.screenHeight * 0.88,
            child: getCategoryGridLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          )
        ],
      ),
    );
  }

  Widget getCategoryGridLayout(double parentHeight, double parentWidth) {
    return FutureBuilder<GetBlogCatergoriesResponseModel>(
      future: AllCommonApis().getBlogCategoriesApi(),
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
                    mainAxisSpacing: 2,
                    height: parentHeight * 0.25),
            itemBuilder: (context, index) {
              final img = data.data[index].image.isNotEmpty
                  ? Image.network(
                      data.data[index].image,
                      fit: BoxFit.fill,
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CategoryProduct(
                    //           proName: "${data.data[index].name}",
                    //           catId: "${data.data[index].id}",
                    //         )));
                  },
                  child: Container(
                    width: parentWidth * 0.35,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0.1, 1),
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            height: parentHeight * 0.19,
                            width: parentWidth * 0.41,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: img,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.015),
                          child: Text(
                            data.data[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                fontFamily: 'Roboto_Normal',
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
}
