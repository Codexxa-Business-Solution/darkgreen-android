import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkgreen/api_model/home/home_image_slider_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {


  int currentIndex = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    sliderImages();
  }





  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: getCarouselSlider(SizeConfig.screenHeight, SizeConfig.screenWidth)
    );
  }

Widget getCarouselSlider(double parentHeight, double parentWidth) {
  return FutureBuilder<SliderImageResponseModel>(
      future: sliderImages(),
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

        return Column(
          children: [
            CarouselSlider.builder(
                itemCount: data.data.length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  initialPage: 1,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int index1) {
                  final img = data.data[index1].image.isNotEmpty
                      ? NetworkImage(
                          "${data.data[index1].image}",
                        )
                      : const NetworkImage("");

                  return Padding(
                    padding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                        right: parentWidth * 0.04,
                        top: parentHeight * 0.02,
                        bottom: parentHeight * 0.02),
                    child: Container(
                        height: SizeConfig.screenHeight * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withOpacity(0.17),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < data.data.length; i++)
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: currentIndex == i
                          ? Colors.green
                          : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  )
              ],
            ),
          ],
        );
      });
}

  Future<SliderImageResponseModel> sliderImages() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().sliderImages),
        body: {"accesskey": ApiConstants().accessKey, "get-slider-images": "1"},
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("sliderResponse -->  ${body}");

      return sliderImageResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
