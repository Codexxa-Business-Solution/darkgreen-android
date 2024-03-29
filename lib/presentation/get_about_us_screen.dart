import 'package:darkgreen/api_model/settings/get_abou_us_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String aboutUs = "";
  Widget? html;

  Future<GetAboutUsResponseModel> getTerms() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getSettingsData),
        body: {
          "accesskey": ApiConstants().accessKey,
          "settings": "1",
          "get_about_us": "1"
        },
        headers: headersList);

    // log(response.body);

    if (response.statusCode == 200) {
      return getAboutUsResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {
    super.initState();

    getTerms();

    getTerms().then((value) {
      aboutUs = value.about;

      print(aboutUs);

      if (mounted) {
        setState(() {});
      }
    });
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
                    "About Us",
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
            height: SizeConfig.screenHeight * 0.88,
            color: Colors.transparent,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Html(
                  data: aboutUs, //Your String.
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
