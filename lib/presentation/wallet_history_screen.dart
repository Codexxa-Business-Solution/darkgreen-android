import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/wallet/get_wallet_history_response_model.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {


  final TextEditingController _amount = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  int totalWalletAmount = 0;

  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    // totalWalletAmount = 0;
    // AllCommonApis().getWalletHistory().then((value){
    //   if (mounted) {
    //     setState(() {
    //       totalWalletAmount = value.data.isNotEmpty ? value.data.length : 0;
    //       for (var element in value.data) {
    //         totalWalletAmount += int.parse(element.amount);
    //         print(totalWalletAmount);
    //       }
    //     });
    //   }
    // });

    // refresh();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

  }


  void refresh() {
    var result = AllCommonApis().getWalletHistory();
    totalWalletAmount = 0;
    result.then((value) {
      if (mounted) {
        setState(() {
          totalWalletAmount = value.data.isNotEmpty ? value.data.length : 0;
          for (var element in value.data) {
            totalWalletAmount += int.parse(element.amount);
            print(totalWalletAmount);
          }
        });
      }
    });
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(context, "Payment Success", "${response.orderId}");
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
showAlertDialog(context, "Payment Failed", "${response.message}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }


  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context)
          ..pop()
          ..pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: SizeConfig.screenHeight * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 7,
                      spreadRadius: 3,
                      offset: Offset(2, 2.0))
                ],
              ),
              child:
                  getTopText(SizeConfig.screenHeight, SizeConfig.screenWidth)),

          Container(
            height: SizeConfig.screenHeight*0.9,
            child: FutureBuilder<GetWalletHistoryResponseModel>(
              future: AllCommonApis().getWalletHistory(),
              builder: (context, snap) {
                if (!snap.hasData && !snap.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snap.data;

                if (data == null) {
                  return const Center(
                    child: Text("No items found in user cart!"),
                  );
                }

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.03),
                            child: Container(
                                height: SizeConfig.screenHeight * 0.27,
                                child: getWalletHistory(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth)),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: snap.data?.data.length,
                              (context, index) {


                                totalWalletAmount += int.parse("${snap.data?.data[index].amount}");
                                print(totalWalletAmount);

                            return Padding(
                              padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                  bottom: SizeConfig.screenHeight*0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 7,
                                        spreadRadius: 1,
                                        offset: Offset(2, 2.0))
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ID #${snap.data?.data[index].id}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto_Bold'
                                            ),),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: CommonColor.APP_BAR_COLOR,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            height: SizeConfig.screenHeight*0.03,
                                            width: SizeConfig.screenWidth*0.2,
                                            child: Center(
                                              child: Text("${snap.data?.data[index].type}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto_Regular'
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.01),
                                      child: Container(
                                        color: Colors.black12,
                                        height: SizeConfig.screenHeight*0.001,
                                        child: Row(
                                          children: const [
                                            Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Date & Time",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto_Bold'
                                            ),),
                                          Text("Amount : \u20B9${snap.data?.data[index].amount}",
                                            style: TextStyle(
                                                color: CommonColor.APP_BAR_COLOR,
                                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto_Regular'
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("${snap.data?.data[index].dateCreated}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto_Normal'
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Message",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto_Bold'
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03,
                                          top: SizeConfig.screenHeight*0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("# ${snap.data?.data[index].message}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto_Normal'
                                            ),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight*0.03,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                );
              },
            ),
          )

        ],
      ),
    );
  }

  Widget getTopText(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Text(
              "Wallet History",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6.0,
                  fontFamily: "Roboto_Medium",
                  fontWeight: FontWeight.w500,
                  color: CommonColor.BLACK_COLOR),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.transparent,),
          ),
        ],
      ),
    );
  }

  Widget getWalletHistory(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.03,
          left: parentWidth * 0.03,
          right: parentWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: Text(
                "Your Balance",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 7.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: Text(
                "\u20B9$totalWalletAmount",
                style: TextStyle(
                    color: CommonColor.APP_BAR_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal * 12.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.02, left: parentWidth * 0.05),
              child: GestureDetector(
                
                onTap: () {
                  print("${_amount.text.trim()}");
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Wallet Recharge'),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.015),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.001,
                              width: SizeConfig.screenWidth * 0.9,
                              color: CommonColor.CIRCLE_COLOR,
                              child: Text(
                                "Hii",
                                style: TextStyle(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            // color: Colors.red,
                            height: parentHeight*0.04,
                            child: TextFormField(
                              controller: _amount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle:
                                      TextStyle(color: Colors.black26)),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.02),
                            child: Container(
                              color: Colors.transparent,
                              height: parentHeight*0.05,
                              child: TextFormField(
                                controller: _notes,
                                decoration: InputDecoration(
                                    hintText: 'Message(Optional)',
                                    hintStyle:
                                    TextStyle(color: Colors.black26)),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.03),
                            child: Row(
                              children: [
                                Text("Payment Method",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                      fontFamily: 'Roboto_Medium',
                                      fontWeight: FontWeight.w500
                                  ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/razorpay-icon.png",
                                ),
                                  height: parentHeight*0.03,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.circle_outlined,
                                      color: CommonColor.APP_BAR_COLOR,),
                                    Padding(
                                      padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027, bottom: parentHeight*0.001),
                                      child: Icon(Icons.circle,
                                        color: CommonColor.APP_BAR_COLOR,
                                        size: SizeConfig.blockSizeHorizontal*4.0,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight * 0.055,
                                width: SizeConfig.screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'),
                                )),
                              ),
                            ),
                            GestureDetector(
                              
                              onTap: () {

                                int amount = int.parse(_amount.text);


                                print(amount);
                                Razorpay razorpay = Razorpay();
                                var options = {
                                  'key': 'rzp_test_TR10gkPm5yHKHF',
                                  'amount': amount * 100,
                                  'name': 'Dark Green',
                                  'description': _notes.text.trim(),
                                  'retry': {'enabled': true, 'max_count': 1},
                                  'send_sms_hash': true,
                                  'prefill': {'contact': '', 'email': ''},
                                  'external': {
                                    'wallets': ['paytm']
                                  }
                                };

                                razorpay.on(
                                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
                                  showAlertDialog(context, "Payment Successful",
                                      "Congratulation Your Subscription is Activated");
                                });
                                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                    handleExternalWalletSelected);

                                razorpay.open(options);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight * 0.055,
                                width: SizeConfig.screenWidth * 0.37,
                                decoration: BoxDecoration(
                                    color: CommonColor.APP_BAR_COLOR,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(
                                  "Recharge",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'),
                                )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                  width: parentWidth * 0.84,
                  height: parentHeight * 0.05,
                  decoration: BoxDecoration(
                      color: CommonColor.APP_BAR_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Recharge Your Wallet",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget getAllHistoryLayout(double parentHeight, double parentWidth){
    return Container();
  }
}
