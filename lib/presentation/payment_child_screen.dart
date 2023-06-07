
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/api_model/order/get_order_placed.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:darkgreen/presentation/track_order_parent_screen.dart';
import 'package:darkgreen/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentScreen extends StatefulWidget {

  final String orderFormat;
  final String selectAddId;
  final String promoCode;
  final String promoDiscount;
  final String selectAddress;
  final String selectLat;
  final String selectLong;
  final List productVariantList;
  final List productVariantQtyList;
  final int totalAmount;
  final int deliveryCharges;

  const PaymentScreen({Key? key, required this.orderFormat, required this.selectAddId,
    this.promoCode = "", this.promoDiscount = "", this.selectAddress = "",
    this.selectLat = "", this.selectLong = "",
    required this.productVariantList, required this.productVariantQtyList, required this.totalAmount, required this.deliveryCharges}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  late DateTime _selectedDate;
  final TextEditingController _notes = TextEditingController();

  int selectTime = 0;

  bool afternoonTime = false;
  bool eveningTime = false;

  bool razorMethod = false;
  bool cashMethod = false;

  final Dio _dio = Dio();

  bool cashOnDelivery = false;
  bool razorPay = false;

  int selectPaymentMethod = 0;

  String dates = "";

  void handlePaymentErrorResponse(PaymentFailureResponse response) {

    ScaffoldMessenger.of(context)
        .showSnackBar( SnackBar(content: Text("${response.message}")));
    // showAlertDialog(context, "Payment Failed", "${response.message}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar( SnackBar(content: Text("${response.walletName}")));

  }

  String cod = "";
  String pap = "";
  String paum = "";
  String razr = "";
  String pays = "";
  String flutterWave = "";
  String midTrans = "";
  String stripe = "";
  String paytm = "";
  String ssl = "";
  String bankTransfer = "";

  String rzrPayKey = "";

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();

    print("pay ${widget.orderFormat}");
    print("pay ${widget.selectAddId}");
    print("pay ${widget.promoCode}");
    print("pay ${widget.promoDiscount}");

    print("Hii ${widget.productVariantList}");
    print("Hii ${widget.productVariantQtyList}");
    print("Hii ${widget.selectAddress}");
    print("Hii ${widget.selectLat}");
    print("Hii ${widget.selectLong}");
    print("Hii ${widget.promoCode}");
    print("Hii ${widget.promoDiscount}");


    AllCommonApis().getAllPaymentMethodShow().then((value){

     if(mounted){
       setState(() {
         cod = value.paymentMethods.codPaymentMethod;
         pap = value.paymentMethods.paypalPaymentMethod;
         paum = value.paymentMethods.payumoneyPaymentMethod;
         razr = value.paymentMethods.razorpayPaymentMethod;
         pays = value.paymentMethods.paystackPaymentMethod;
         flutterWave = value.paymentMethods.flutterwavePaymentMethod;
         midTrans = value.paymentMethods.midtransPaymentMethod;
         stripe = value.paymentMethods.stripePaymentMethod;
         paytm = value.paymentMethods.paytmPaymentMethod;
         ssl = value.paymentMethods.sslMethod;
         bankTransfer = value.paymentMethods.directBankTransferMethod;
         rzrPayKey = value.paymentMethods.razorpayKey;
       });
     }

    });

  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            // shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.015, left: SizeConfig.screenWidth*0.03,right: SizeConfig.screenWidth*0.03,),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 7,
                          spreadRadius: 1,
                          offset: const Offset(2, 2.0))
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01, left: SizeConfig.screenWidth*0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Preferred Delivery Date/Time",
                            style: TextStyle(
                              color: CommonColor.APP_BAR_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto_Medium"
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.02, right: SizeConfig.screenWidth*0.02),
                        child: Container(
                          height: SizeConfig.screenHeight*0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(2, 2.0))
                            ],
                          ),
                          child: CalendarTimeline(
                            showYears: false,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                            onDateSelected: (date) => setState(() {
                              _selectedDate = date;
                              print(_selectedDate);

                              var datesss = _selectedDate;

                              dates = DateFormat('dd-MM-yyyy').format(datesss);
                              print(dates);

                            }
                            ),
                            leftMargin: 20,
                            monthColor: Colors.transparent,
                            dayColor: CommonColor.CIRCLE_COLOR,
                            dayNameColor: CommonColor.WHITE_COLOR,
                            activeDayColor: Colors.white,
                            activeBackgroundDayColor: CommonColor.APP_BAR_COLOR,
                            dotsColor: Colors.transparent,
                            locale: 'en',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                        child: GestureDetector(
                          onDoubleTap: (){},
                          onTap: (){
                            if(mounted){
                              setState(() {
                                selectTime = 1;
                                afternoonTime = !afternoonTime;
                                eveningTime = false;
                                print("$selectTime");
                              });
                            }
                          },
                          child: Container(
                             color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("12 PM TO 3 PM"),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(Icons.circle_outlined,
                                      color: CommonColor.APP_BAR_COLOR,),
                                    Visibility(
                                      visible: afternoonTime,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                        child: Icon(Icons.circle,
                                          color: CommonColor.APP_BAR_COLOR,
                                          size: SizeConfig.blockSizeHorizontal*4.0,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.001,
                          width: SizeConfig.screenWidth * 0.9,
                          color: CommonColor.CIRCLE_COLOR,
                          child: const Text(
                            "Hii",
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                        child: GestureDetector(
                          onDoubleTap: (){},
                          onTap: (){
                           if(mounted){
                             setState(() {
                               selectTime = 2;
                               eveningTime = !eveningTime;
                               afternoonTime = false;
                               print("$selectTime");
                             });
                           }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("9 AM TO 12 PM"),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(Icons.circle_outlined,
                                      color: CommonColor.APP_BAR_COLOR,),
                                    Visibility(
                                      visible: eveningTime,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                        child: Icon(Icons.circle,
                                          color: CommonColor.APP_BAR_COLOR,
                                          size: SizeConfig.blockSizeHorizontal*4.0,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.001,
                          width: SizeConfig.screenWidth * 0.9,
                          color: CommonColor.CIRCLE_COLOR,
                          child: const Text(
                            "Hii",
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight*0.01,
                      )
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16),
              //   child: TextButton(
              //     style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
              //     ),
              //     child: const Text(
              //       'RESET',
              //       style: TextStyle(color: Color(0xFF333A47)),
              //     ),
              //     onPressed: () => setState(() => _resetSelectedDate()),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Center(
              //   child: Text(
              //     'Selected date is $_selectedDate',
              //     style: const TextStyle(color: Colors.black54),
              //   ),
              // )
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.015, left: SizeConfig.screenWidth*0.03,right: SizeConfig.screenWidth*0.03,),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 7,
                          spreadRadius: 1,
                          offset: const Offset(2, 2.0))
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01, left: SizeConfig.screenWidth*0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Payment Method",
                              style: TextStyle(
                                  color: CommonColor.APP_BAR_COLOR,
                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto_Medium"
                              ),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                        child: GestureDetector(
                          onTap: (){
                            if(mounted){
                              setState(() {
                                selectPaymentMethod = 1;
                                cashMethod = !cashMethod;
                                razorMethod = false;
                                print("$cashMethod");
                              });
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(Icons.circle_outlined,
                                          color: CommonColor.APP_BAR_COLOR,),
                                        Visibility(
                                          visible: cashMethod,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                            child: Icon(Icons.circle,
                                              color: CommonColor.APP_BAR_COLOR,
                                              size: SizeConfig.blockSizeHorizontal*4.0,),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                      child: Text("Cash On Delivery",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto_Regular'
                                      ),),
                                    ),
                                  ],
                                ),
                                const Image(image: AssetImage("assets/images/cash_delivery.png"),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.001,
                          width: SizeConfig.screenWidth * 0.9,
                          color: CommonColor.CIRCLE_COLOR,
                          child: const Text(
                            "Hii",
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                        child: GestureDetector(
                          onTap: (){
                            if(mounted){
                              setState(() {
                                selectPaymentMethod = 2;
                                razorMethod = !razorMethod;
                                cashMethod = false;
                                print("$razorMethod");
                              });
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(Icons.circle_outlined,
                                          color: CommonColor.APP_BAR_COLOR,),
                                        Visibility(
                                          visible: razorMethod,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                            child: Icon(Icons.circle,
                                              color: CommonColor.APP_BAR_COLOR,
                                              size: SizeConfig.blockSizeHorizontal*4.0,),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                      child: Text("RazorPay",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto_Regular'
                                        ),),
                                    ),
                                  ],
                                ),

                                Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                height: SizeConfig.screenHeight*0.015,)

                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.001,
                          width: SizeConfig.screenWidth * 0.9,
                          color: CommonColor.CIRCLE_COLOR,
                          child: const Text(
                            "Hii",
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: pap == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(
                                                visible: pap == "1" ? true : false,
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("PayPal",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: paum == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("PauMoney",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: pays == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("PayStack",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: flutterWave == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("FlutterWaves",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: midTrans == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("MidTrans",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: stripe == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("Stripe",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: paytm == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("PayTm",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: ssl == "1" ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                              child: GestureDetector(
                                onTap: (){
                                  // if(mounted){
                                  //   setState(() {
                                  //     selectPaymentMethod = 2;
                                  //     razorMethod = !razorMethod;
                                  //     cashMethod = false;
                                  //     print("$razorMethod");
                                  //   });
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Icon(Icons.circle_outlined,
                                                color: CommonColor.APP_BAR_COLOR,),
                                              Visibility(

                                                child: Padding(
                                                  padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                                  child: Icon(Icons.circle,
                                                    color: CommonColor.APP_BAR_COLOR,
                                                    size: SizeConfig.blockSizeHorizontal*4.0,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                            child: Text("SSL",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto_Regular'
                                              ),),
                                          ),
                                        ],
                                      ),

                                      // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                      //   height: SizeConfig.screenHeight*0.015,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.001,
                                width: SizeConfig.screenWidth * 0.9,
                                color: CommonColor.CIRCLE_COLOR,
                                child: const Text(
                                  "Hii",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: bankTransfer == "1" ? true : false,
                        child: Padding(
                          padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.02, left: SizeConfig.screenWidth*0.03, right: SizeConfig.screenWidth*0.03),
                          child: GestureDetector(
                            onTap: (){
                              // if(mounted){
                              //   setState(() {
                              //     selectPaymentMethod = 2;
                              //     razorMethod = !razorMethod;
                              //     cashMethod = false;
                              //     print("$razorMethod");
                              //   });
                              // }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(Icons.circle_outlined,
                                            color: CommonColor.APP_BAR_COLOR,),
                                          Visibility(

                                            child: Padding(
                                              padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.0027),
                                              child: Icon(Icons.circle,
                                                color: CommonColor.APP_BAR_COLOR,
                                                size: SizeConfig.blockSizeHorizontal*4.0,),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.02),
                                        child: Text("Direct Bank Transfer",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto_Regular'
                                          ),),
                                      ),
                                    ],
                                  ),

                                  // Image(image: const AssetImage("assets/images/razorpay-icon.png"),
                                  //   height: SizeConfig.screenHeight*0.015,)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                      //   child: Container(
                      //     height: SizeConfig.screenHeight * 0.001,
                      //     width: SizeConfig.screenWidth * 0.9,
                      //     color: CommonColor.CIRCLE_COLOR,
                      //     child: const Text(
                      //       "Hii",
                      //       style: TextStyle(color: Colors.transparent),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: SizeConfig.screenHeight*0.02,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight*0.1,
              )
            ],
          ),
          getBottomText(SizeConfig.screenHeight, SizeConfig.screenWidth)
        ],
      ),
    );
  }


  Widget getBottomText(double parentHeight, double parentWidth){

    int ft = widget.totalAmount - widget.deliveryCharges;

    return Container(
      height: SizeConfig.screenHeight*0.07,
      decoration: BoxDecoration(
        color: CommonColor.APP_BAR_COLOR,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              spreadRadius: 3,
              offset: const Offset(2, 2.0))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.01, left: SizeConfig.screenWidth*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rs.154",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400
                  ),),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.005),
                  child: Text("1 Item",
                    style: TextStyle(
                        color: CommonColor.WHITE_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal*4.0,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.w400
                    ),),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.05),
            child: GestureDetector(
              onDoubleTap: (){},
              onTap: (){

                int amount = widget.totalAmount;
                int dc = widget.deliveryCharges;


                if(selectPaymentMethod == 0){
                  ScaffoldMessenger.of(context)
                      .showSnackBar( const SnackBar(content: Text("Please Select Payment Method")));
                }else{
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
                              Text('Confirm Order Amount'),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.001,
                              width: SizeConfig.screenWidth * 0.9,
                              color: CommonColor.CIRCLE_COLOR,
                              child: const Text(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Items Amount :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                              Text('\u20B9$amount',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Charge :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                              Text('\u20B9$dc',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                              Text('\u20B9${widget.totalAmount}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto-Light'
                                ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Final Total :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto_Bold'
                                ),),
                              Text('\u20B9$ft',
                                style: TextStyle(
                                    color: CommonColor.APP_BAR_COLOR,
                                    fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto_Bold'
                                ),),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              color: Colors.transparent,
                              child: TextFormField(
                                controller: _notes,
                                decoration: const InputDecoration(
                                    labelText: 'Special Note',
                                    labelStyle: TextStyle(
                                        color: Colors.black26
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: parentHeight*0.055,
                                width: parentWidth*0.37,
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text("Cancel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'
                                  ),)),
                              ),
                            ),
                            GestureDetector(
                              onDoubleTap: (){},
                              onTap: (){

                                print(" widget.totalAmount ${ widget.totalAmount}");

                                if(selectPaymentMethod == 1){
                                  getPlacedOrder().then((value){

                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        backgroundColor: CommonColor.GIF_BACKGROUND_COLOR,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        title: Column(
                                          children: [
                                            Image(
                                              image: const AssetImage(("assets/images/confirm.gif")
                                              ),
                                              height:parentHeight*0.15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                                              child: const Text(
                                                "Order Placed!",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Your order has been successfully placed!",
                                              style: TextStyle(color: CommonColor.RS_COLOR,
                                                  fontSize: SizeConfig.blockSizeHorizontal*3.7),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onDoubleTap: (){},
                                                onTap: (){
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                          const Dashboard()),
                                                          (Route route) =>
                                                      false);
                                                },
                                                child: Container(
                                                  height: parentHeight*0.055,
                                                  width: parentWidth*0.37,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor.APP_BAR_COLOR,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Continue Shopping",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Roboto-Light'
                                                    ),)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onDoubleTap: (){},
                                                onTap: (){
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TrackOrderParentScreen()));
                                                },
                                                child: Container(
                                                  height: parentHeight*0.055,
                                                  width: parentWidth*0.37,
                                                  decoration: BoxDecoration(
                                                      color: CommonColor.APP_BAR_COLOR,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("View All Orders",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Roboto-Light'
                                                    ),)),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                }else {

                                  print("rzrPayKey $rzrPayKey");

                                  Razorpay razorpay = Razorpay();
                                  var options = {
                                    'key': rzrPayKey,
                                    'amount': widget.totalAmount * 100,
                                    'name': 'Dark Green',
                                    'description': 'Your Order Amount is ${widget.totalAmount}',
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
                                    getPlacedOrder()
                                        .then((value) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar( SnackBar(content: Text("Congratulation Your Order has been Placed")));
                                      //Navigator.of(context).pop();

                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          backgroundColor: CommonColor.GIF_BACKGROUND_COLOR,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          title: Column(
                                            children: [
                                              Image(
                                                image: const AssetImage(("assets/images/confirm.gif")
                                                ),
                                                height:parentHeight*0.15,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                                                child: const Text(
                                                  "Order Placed!",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Your order has been successfully placed!",
                                                style: TextStyle(color: CommonColor.RS_COLOR,
                                                    fontSize: SizeConfig.blockSizeHorizontal*3.7),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onDoubleTap: (){},
                                                  onTap: (){
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                            const Dashboard()),
                                                            (Route route) =>
                                                        false);
                                                  },
                                                  child: Container(
                                                    height: parentHeight*0.055,
                                                    width: parentWidth*0.37,
                                                    decoration: BoxDecoration(
                                                        color: CommonColor.APP_BAR_COLOR,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Center(child: Text("Continue Shopping",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'Roboto-Light'
                                                      ),)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onDoubleTap: (){},
                                                  onTap: (){
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TrackOrderParentScreen()));
                                                  },
                                                  child: Container(
                                                    height: parentHeight*0.055,
                                                    width: parentWidth*0.37,
                                                    decoration: BoxDecoration(
                                                        color: CommonColor.APP_BAR_COLOR,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Center(child: Text("View All Orders",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: SizeConfig.blockSizeHorizontal*3.7,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'Roboto-Light'
                                                      ),)),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  });
                                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                      handleExternalWalletSelected);

                                  razorpay.open(options);
                                }



                              },
                              child: Container(
                                height: parentHeight*0.055,
                                width: parentWidth*0.37,
                                decoration: BoxDecoration(
                                    color: CommonColor.APP_BAR_COLOR,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text("Confirm",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.blockSizeHorizontal*5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Light'
                                  ),)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }



              },

              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text("Proceed",
                      style: TextStyle(
                          color: CommonColor.WHITE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*5.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500
                      ),),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.01),
                      child: Icon(Icons.arrow_forward_ios_outlined,
                        color: CommonColor.WHITE_COLOR,
                        size: SizeConfig.screenHeight*0.02,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<GetOrderPlacedResponceModel> getPlacedOrder() async {
    String? id = await AppPreferences.getIds();
    String? userNumber = await AppPreferences.getUserNumber();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};


    print(id);
    print(userNumber);
    print(widget.productVariantList);
    print(widget.productVariantQtyList);
    print(widget.deliveryCharges == 0 ? "Free" : widget.deliveryCharges.toString());
    print(widget.totalAmount);
    print(widget.selectAddress);
    print(widget.selectLat);
    print(widget.selectLong);
    print(selectPaymentMethod == 1 ? "Cash Method" : selectPaymentMethod == 2 ? "Razorpay" : "");
    print(_notes.text.trim());
    print(widget.promoCode);
    print(widget.promoDiscount);
    print(widget.orderFormat == "1" ? "Door Step Delivery" : widget.orderFormat == "2" ? "Pick Up From Store" : "");
    print("$dates - ${selectTime == 1 ? "12PM To 3PM" : selectTime == 2 ? "9AM To 12PM" : ""}");


    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey":"90336",
          "place_order":"1",
          "user_id":id,
          "mobile":userNumber,
          "product_variant_id":widget.productVariantList.toString(),
          "quantity":widget.productVariantQtyList.toString(),
          "delivery_charge":widget.deliveryCharges == 0 ? "Free" : widget.deliveryCharges.toString(),
          "total":widget.totalAmount.toString(),
          "final_total":widget.totalAmount.toString(),
          "address":widget.selectAddress,
          "latitude":widget.selectLat,
          "longitude":widget.selectLong,
          "payment_method":selectPaymentMethod == 1 ? "Cash Method" : selectPaymentMethod == 2 ? "Razorpay" : "",
          "discount":"0",
          "tax_percentage":"20",
          "tax_amount":"30",
          "area_id":"1",
          "order_note":_notes.text.trim(),
          "wallet_balance":"",
          "promo_code":widget.promoCode,
          "promo_discount":widget.promoDiscount.toString(),
          "order_from":"test",
          "local_pickup":widget.orderFormat == "1" ? "0" : widget.orderFormat == "2" ? "1" : "",
          "wallet_used":"false",
          "status":"awaiting_payment",
          "delivery_time":"$dates - ${selectTime == 1 ? "12PM To 3PM" : selectTime == 2 ? "9AM To 12PM" : ""}"
        },
        headers: headersList);

    if (response.statusCode == 200) {
  print(response.body.jsonBody());

      return getOrderPlacedResponceModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

}

