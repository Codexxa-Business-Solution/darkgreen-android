import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/address_chid_screen.dart';
import 'package:flutter/material.dart';

class AddressListScreen extends StatefulWidget {
  final int index;
  final int totalAmount;
  final int itemCount;
  final int deliveryCharges;
  final String orderFormat;
  final String addressId;
  final String promoCode;
  final String promoDiscount;
  final String selectAddress;
  final String selectLat;
  final String selectLong;
  final List productVariantList;
  final List productVariantQtyList;

  const AddressListScreen(
      {Key? key,
      required this.index,
      this.totalAmount = 0,
      this.itemCount = 0,
      this.deliveryCharges = 0,
      required this.orderFormat,
      required this.addressId,
      this.promoCode = "",
      this.promoDiscount = "",
      this.selectAddress = "",
      this.selectLat = "",
      this.selectLong = "",
      required this.productVariantList,
      required this.productVariantQtyList})
      : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: CommonColor.BLACK_COLOR,
            size: SizeConfig.blockSizeHorizontal * 7),
        backgroundColor: CommonColor.WHITE_COLOR,
        title: Text(
          "Address",
          style: TextStyle(
              color: CommonColor.BLACK_COLOR,
              fontSize: SizeConfig.blockSizeHorizontal * 5.0,
              fontFamily: 'Roboto-Medium',
              fontWeight: FontWeight.w500),
        ),
      ),
      body: AddressSelectScreen(
          totalAmount: widget.totalAmount,
          itemCount: widget.itemCount,
          orderFormat: widget.orderFormat,
          productVariantList: widget.productVariantList,
          productVariantQtyList: widget.productVariantQtyList),
    );
  }
}
