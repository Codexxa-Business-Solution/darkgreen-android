import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';

import '../api_model/order/faq_response_model.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    AllCommonApis().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<FaqResponse>(
            future: AllCommonApis().getFaqs(),
            builder: (context, snap) {
              if (!snap.hasData && !snap.hasError) {
                return Container(
                  height: SizeConfig.screenHeight * 0.83,
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final data = snap.data;

              if (data == null || data.data == null) {
                return Container(
                  height: SizeConfig.screenHeight * 0.83,
                  color: Colors.transparent,
                  child: const Center(
                    child: Text("No Faqs"),
                  ),
                );
              }

              return SizedBox(
                // color: Colors.red,
                height: SizeConfig.screenHeight * 0.83,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        right: SizeConfig.screenWidth * 0.03,
                        left: SizeConfig.screenWidth * 0.03),
                    scrollDirection: Axis.vertical,
                    itemCount: snap.data?.data?.length,
                    itemBuilder: (context, index) {
                      var faq = data.data?[index];
                      return ExpansionTile(
                        title: Text(faq!.question.toString()),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(faq.answer.toString()),
                          ),
                        ],
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
