import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/order/get_all_orders_status_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/door_step_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetAllPickUpOrders extends StatefulWidget {
  const GetAllPickUpOrders({Key? key}) : super(key: key);

  @override
  State<GetAllPickUpOrders> createState() => _GetAllPickUpOrdersState();
}

class _GetAllPickUpOrdersState extends State<GetAllPickUpOrders> {
  String? pickUpDate;

  String placeDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllCommonApis().getAllOrdersStatus();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<GetOredersStatusResponseModel>(
            future: AllCommonApis().getAllShippedStatus(),
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

              print(snap.data?.data.length);

              if (data == null) {
                return Container(
                  height: SizeConfig.screenHeight * 0.83,
                  color: Colors.transparent,
                  child: const Center(
                    child: Text("No Pick Up Order Available"),
                  ),
                );
              }

              return Container(
                // color: Colors.red,
                height: SizeConfig.screenHeight * 0.83,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        right: SizeConfig.screenWidth * 0.03,
                        left: SizeConfig.screenWidth * 0.03),
                    scrollDirection: Axis.vertical,
                    itemCount: snap.data?.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.01,
                            bottom: SizeConfig.screenHeight * 0.01),
                        child: getOrderDetails(SizeConfig.screenHeight,
                            SizeConfig.screenWidth, data, index),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getOrderDetails(double parentHeight, double parentWidth,
      GetOredersStatusResponseModel model, int index) {
    placeDate = DateFormat('dd-MM-yyyy').format(model.data[index].orderTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoorStepOrder(
                      model: model,
                      index: index,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: CommonColor.CIRCLE_COLOR, width: 3.0)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03,
                  right: parentWidth * 0.03,
                  top: parentHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No : ${model.data[index].id}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto_Medium'),
                  ),
                  Text(
                    "\u20B9${model.data[index].total}",
                    style: TextStyle(
                        color: CommonColor.APP_BAR_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto_Medium'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03, top: parentHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${model.data[index].items.length} Items",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Regular'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03, top: parentHeight * 0.01),
              child: Row(
                children: [
                  Container(
                    width: parentWidth * 0.8,
                    height: parentHeight * 0.025,
                    color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: model.data[index].items.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20, top: 3),
                        itemBuilder: (context, index1) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${model.data[index].items[index1].name}, ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_Medium'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03, top: parentHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Placed order on $placeDate",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_Medium'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.03,
                  right: parentWidth * 0.03,
                  top: parentHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: parentHeight * 0.04,
                    width: model.data[index].activeStatus == "awaiting_payment"
                        ? parentWidth * 0.32
                        : parentWidth * 0.2,
                    decoration: BoxDecoration(
                      color: CommonColor.APP_BAR_COLOR,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        model.data[index].activeStatus == "awaiting_payment"
                            ? "Awaiting Approval"
                            : model.data[index].activeStatus == "pending"
                                ? "Pending"
                                : model.data[index].activeStatus == "received"
                                    ? "Received"
                                    : model.data[index].activeStatus ==
                                            "processed"
                                        ? "Processed"
                                        : model.data[index].activeStatus ==
                                                "shipped"
                                            ? "Shipped"
                                            : model.data[index].activeStatus ==
                                                    "delivered"
                                                ? "Delivered"
                                                : model.data[index]
                                                            .activeStatus ==
                                                        "cancelled"
                                                    ? "Cancelled"
                                                    : model.data[index]
                                                                .activeStatus ==
                                                            "returned"
                                                        ? "Returned"
                                                        : "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto_Medium'),
                      ),
                    ),
                  ),
                  Container(
                    height: parentHeight * 0.04,
                    width: parentWidth * 0.4,
                    decoration: BoxDecoration(
                      color: CommonColor.ORDER_PLACED_COLOR,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(2, 2.0))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining_rounded,
                          size: parentHeight * 0.025,
                          color: Colors.black38,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.01),
                          child: Text(
                            model.data[index].localPickup == "0"
                                ? "Door Step Delivery"
                                : "PickUp From Store",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto_Medium'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: parentHeight * 0.012,
            )
          ],
        ),
      ),
    );
  }
}
