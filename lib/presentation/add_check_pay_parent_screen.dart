import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/address_chid_screen.dart';
import 'package:darkgreen/presentation/checkout.dart';
import 'package:darkgreen/presentation/payment_child_screen.dart';
import 'package:flutter/material.dart';


class AddCheckPayParentScreen extends StatefulWidget {

  final int index;
  final int totalAmount;
  final int itemCount;
  final int deliveryCharges;
  final String orderFormat;
  final String addressId;
  final String promoCode;
  final String promoDiscount;

  const AddCheckPayParentScreen({Key? key, required this.index, this.totalAmount = 0, this.itemCount = 0, this.deliveryCharges = 0, required this.orderFormat, required this.addressId, this.promoCode = "", this.promoDiscount = ""}) : super(key: key);

  @override
  State<AddCheckPayParentScreen> createState() => _AddCheckPayParentScreenState();
}

class _AddCheckPayParentScreenState extends State<AddCheckPayParentScreen> with SingleTickerProviderStateMixin{


  late TabController _tabController;


  @override
  void initState() {
    print(widget.index);
    _tabController = TabController(length: 3, vsync: this);
    super.initState();

    print("parent ${widget.orderFormat}");
    print("parent ${widget.addressId}");
    print("dc ${widget.promoCode}");
    print("dc ${widget.promoDiscount}");
  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: DefaultTabController(
        initialIndex: widget.index,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: CommonColor.BLACK_COLOR,
            size: SizeConfig.blockSizeHorizontal*7),
            backgroundColor: CommonColor.WHITE_COLOR,
            title: Text(widget.index == 0 ? "Address" : widget.index == 1 ?
            "Checkout" : widget.index == 2 ? "Payment" : "",
            style: TextStyle(
              color: CommonColor.BLACK_COLOR,
              fontSize: SizeConfig.blockSizeHorizontal*5.0,
              fontFamily: 'Roboto-Medium',
              fontWeight: FontWeight.w500
            ),),
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.transparent,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                        Image(image: AssetImage("assets/images/nextTab.png"),
                        height: SizeConfig.screenHeight*0.03,
                        color:widget.index == 0 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.015),
                        child: Text("Address",
                          style: TextStyle(
                              color: widget.index == 0 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal* 4.2,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Image(image: AssetImage("assets/images/nextTab.png"),
                        height: SizeConfig.screenHeight*0.025,
                        color:widget.index == 1 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.015),
                        child: Text("Checkout",
                          style: TextStyle(
                              color: widget.index == 1 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal* 4.2,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Image(image: AssetImage("assets/images/nextTab.png"),
                        height: SizeConfig.screenHeight*0.025,
                        color:widget.index == 2 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.015),
                        child: Text("Payment",
                          style: TextStyle(
                              color: widget.index == 2 ? CommonColor.APP_BAR_COLOR : CommonColor.CIRCLE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal* 4.2,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AddressSelectScreen(totalAmount: widget.totalAmount, itemCount: widget.itemCount, orderFormat: widget.orderFormat,),
              Checkout(deliverCharges: widget.deliveryCharges, orderFormat: widget.orderFormat, selectAddId: widget.addressId, promoCode: widget.promoCode, promoDiscount: widget.promoDiscount,),
              PaymentScreen(orderFormat: widget.orderFormat, selectAddId: widget.addressId, promoCode: widget.promoCode, promoDiscount: widget.promoDiscount,)
            ],
          ),
        ),
      ),
    );
  }
}
