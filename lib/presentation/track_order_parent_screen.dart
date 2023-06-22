import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/all_order_screen.dart';
import 'package:darkgreen/presentation/cancelled_order_screen.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/delivered_order_screen.dart';
import 'package:darkgreen/presentation/get_all_pickup_order_child_screen.dart';
import 'package:darkgreen/presentation/processed_order_screen.dart';
import 'package:darkgreen/presentation/received_order_screen.dart';
import 'package:darkgreen/presentation/returned_order_screen.dart';
import 'package:darkgreen/presentation/search_screen.dart';
import 'package:darkgreen/presentation/shipped_order_screen.dart';
import 'package:flutter/material.dart';

class TrackOrderParentScreen extends StatefulWidget {
  const TrackOrderParentScreen({Key? key}) : super(key: key);

  @override
  State<TrackOrderParentScreen> createState() => _TrackOrderParentScreenState();
}

class _TrackOrderParentScreenState extends State<TrackOrderParentScreen> {
  int cartCount = 0;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        AllCommonApis().getAllCarts().then((value) {
          cartCount = value.data.length;
          print(cartCount);
          if (mounted) {
            setState(() {});
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 8,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.13),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.16,
                  child: AppBar(
                    backgroundColor: CommonColor.WHITE_COLOR,
                    elevation: 7,
                    centerTitle: true,
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.03,
                          top: SizeConfig.screenHeight * 0.01),
                      child: GestureDetector(
                        onDoubleTap: () {},
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            color: Colors.transparent,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    title: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                      child: Text(
                        'Track Order',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                            color: CommonColor.BLACK_COLOR,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto_Medium'),
                      ),
                    ),
                    bottom: TabBar(
                        isScrollable: true,
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05),
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: CommonColor.CIRCLE_COLOR,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto_Medium',
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0),
                        unselectedLabelStyle: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto_Regular'),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: CommonColor.APP_BAR_COLOR,
                        ),
                        tabs: const [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'All',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Pick Up',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Received',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Processed',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Shipped',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Delivered',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Cancelled',
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Returned',
                              ),
                            ),
                          ),
                        ]),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.035),
                        child: Container(
                          width: SizeConfig.screenWidth * 0.2,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchProduct())).then((value) {
                                    setState(() {
                                      if (mounted) {
                                        setState(() {
                                          AllCommonApis()
                                              .getAllCarts()
                                              .then((value) {
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
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: SizeConfig.screenHeight * 0.035,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Cart()));
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.01),
                                      child: Container(
                                        height: SizeConfig.screenHeight * 0.05,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/trolly.png"),
                                            color: Colors.black,
                                            height:
                                                SizeConfig.screenHeight * 0.03,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: cartCount == 0 ? false : true,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                SizeConfig.screenHeight * 0.03,
                                            right:
                                                SizeConfig.screenWidth * 0.005),
                                        child: Container(
                                          height:
                                              SizeConfig.screenHeight * 0.05,
                                          width: SizeConfig.screenWidth * 0.05,
                                          decoration: BoxDecoration(
                                              color: CommonColor.WHITE_COLOR,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      CommonColor.APP_BAR_COLOR,
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.005)),
                                          child: Center(
                                            child: Text(
                                              "$cartCount",
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CommonColor.WHITE_COLOR,
                  height: SizeConfig.screenHeight * 0.007,
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.red,
            height: SizeConfig.screenHeight * 0.9,
            child: const TabBarView(
              children: <Widget>[
                AllOrderScreen(),
                GetAllPickUpOrders(),
                ReceivedOrderScreen(),
                ProcessedOrderScreen(),
                ShippedOrderScreen(),
                DeliveredOrderScreen(),
                CancelledOrderScreen(),
                ReturnedOrderScreen()
              ],
            ),
          )),
    );
  }
}
