import 'package:darkgreen/api_model/address/get_address_of_user_response_model.dart';
import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/Address.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:flutter/material.dart';


class AddressSelectScreen extends StatefulWidget {

  final int totalAmount;
  final int itemCount;
  final int deliveryCharges;
  final String orderFormat;

  const AddressSelectScreen({Key? key, this.totalAmount = 0, this.itemCount = 0, this.deliveryCharges = 0, required this.orderFormat}) : super(key: key);

  @override
  State<AddressSelectScreen> createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {



  bool selectedAddress = false;
  int selectedIndex = 0;

  String selectAddId = "";


  @override
  void initState() {
    super.initState();
    print("Hi");
    AllCommonApis().getAddressOfUser().then((value){
      if(mounted){
        setState(() {
          selectAddId = value.data?.elementAt(0).id ?? "";
          print(" initId $selectAddId");
        });
      }
    });
    print("add ${widget.orderFormat}");
  }


  Future<Null> refreshList() async {
    await Future.delayed(const Duration(seconds: 1));

    var result = AllCommonApis().getAddressOfUser();

    result.then((value) {
      setState(() {});
    });

    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.LAYOUT_BACKGROUND_COLOR,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: SizeConfig.screenHeight*0.9,
              color: Colors.white,
            child: Padding(
              padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.07),
              child: NameAddressLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
            )
          ),
          getBottomText(SizeConfig.screenHeight, SizeConfig.screenWidth)
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.07, right: SizeConfig.screenWidth*0.03),
        child: FloatingActionButton(
          backgroundColor: CommonColor.APP_BAR_COLOR,
          child: Icon(Icons.add,
          size: SizeConfig.blockSizeHorizontal*9.0,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Address(isCome: '1', lat: 0.0, long: 0.0,))).then((value){
              if(mounted) {
                setState(() {
                  AllCommonApis().getAddressOfUser().then((value){
                    if(mounted){
                      setState(() {
                        print("selectAddId $selectAddId");
                      });
                    }
                  });
              });
              }
            });
          },),
      ),
    );
  }



  Widget NameAddressLayout(double parentHeight, double parentWidth){
    return FutureBuilder<GetAddressOfUserResponseModel>(
      future: AllCommonApis().getAddressOfUser(),
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

        if (data.data == null) {
          return const Center(
            child: Text("No Address Available."),
          );
        }

        return ListView.builder(
            itemCount: snap.data?.data?.length,
            padding: const EdgeInsets.only(bottom: 20, top: 3),
            itemBuilder: (context, index) {

              final typeText = snap.data?.data?[index].type == "1" ? "Home"
                  : snap.data?.data?[index].type == "2" ? "Office" : "Office";

              if(snap.data?.data?[index].isDefault == "1") {
                selectedIndex == index;
              }


              return Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03,
                  left: SizeConfig.screenWidth*0.03,
                  right: SizeConfig.screenWidth*0.03,),
                child: GestureDetector(
                  onDoubleTap: (){},
                  onTap: (){
                    selectedIndex = index;
                    setState(() {
                      selectAddId = snap.data?.data?[index].id ?? "";
                      print(" selectId $selectAddId");
                    });
                  },
                  child: Container(
                    height: SizeConfig.screenHeight*0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.17),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.015,
                              left: parentWidth*0.03, right: parentWidth*0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                        onDoubleTap: (){},
                                        onTap: (){
                                          // selectedIndex = index;
                                          // setState(() {
                                          //   selectAddId = snap.data?.data?[index].id ?? "";
                                          //   print(" selectId $selectAddId");
                                          // });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Icon(Icons.circle_outlined,
                                            color: CommonColor.APP_BAR_COLOR,),
                                        ),
                                      ),
                                      Visibility(
                                        visible: index == selectedIndex,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: parentWidth*0.0027),
                                          child: Icon(Icons.circle,
                                            color: CommonColor.APP_BAR_COLOR,
                                            size: SizeConfig.blockSizeHorizontal*4.0,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: parentWidth*0.01),
                                    child: Container(
                                      width: parentWidth*0.31,
                                      color: Colors.transparent,
                                      child: Text("${snap.data?.data?[index].name}",
                                        style: TextStyle(
                                          color: CommonColor.APP_BAR_COLOR,
                                          fontSize: SizeConfig.blockSizeHorizontal*4.0,
                                          fontFamily: 'Roboto_Medium',
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),maxLines: 1,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: parentWidth*0.02),
                                    child: Container(
                                      height: parentHeight*0.03,
                                      width: parentWidth*0.14,
                                      decoration: BoxDecoration(
                                          color: CommonColor.APP_BAR_COLOR,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Center(child: Text(typeText,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto_Medium',
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeConfig.blockSizeHorizontal*3.0
                                        ),)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: snap.data?.data?[index].isDefault == "0" ? false : true,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: parentWidth*0.02),
                                      child: Container(
                                        height: parentHeight*0.03,
                                        width: parentWidth*0.17,
                                        decoration: BoxDecoration(
                                            color: CommonColor.APP_BAR_COLOR,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Center(child: Text("Default",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto_Medium',
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig.blockSizeHorizontal*3.0
                                          ),)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: parentWidth*0.02),
                                    child: GestureDetector(
                                      onDoubleTap: (){},
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Address(
                                          isCome: '2',
                                          lat: double.parse("${snap.data?.data?[index].latitude}"),
                                          long: double.parse("${snap.data?.data?[index].longitude}"),
                                          fullName: "${snap.data?.data?[index].name}",
                                          phoneNumber: "${snap.data?.data?[index].mobile}",
                                          alterPhoneNumber: "${snap.data?.data?[index].alternateMobile}",
                                          address: "${snap.data?.data?[index].address}",
                                          landMark: "${snap.data?.data?[index].landmark}",
                                          city: "${snap.data?.data?[index].cityId}",
                                          area: "${snap.data?.data?[index].areaId}",
                                          country: "${snap.data?.data?[index].country}",
                                          state: "${snap.data?.data?[index].state}",
                                          postalCode: "${snap.data?.data?[index].pincode}",
                                          isType: "${snap.data?.data?[index].type}",
                                          isDefault:"${snap.data?.data?[index].isDefault}",
                                          addressId: "${snap.data?.data?[index].id}",
                                        ))).then((value){
                                          setState(() {
                                            AllCommonApis().getAddressOfUser().then((value){
                                              if(mounted){
                                                setState(() {
                                                  print("selectAddId $selectAddId");
                                                });
                                              }
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Icon(Icons.edit)
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onDoubleTap: (){},
                                    onTap: (){
                                      AllCommonApis().removeAddress("${snap.data?.data?[index].id}").then((value){
                                        setState(() {

                                        });
                                      });
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                        child: Icon(Icons.delete_forever
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.017, left: parentWidth*0.1, right: parentWidth*0.04),
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text("${snap.data?.data?[index].address}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto_Regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeConfig.blockSizeHorizontal*4.0
                                      ),
                                      maxLines: 4,)
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget getBottomText(double parentHeight, double parentWidth){
    return Container(
      height: SizeConfig.screenHeight*0.07,
      decoration: BoxDecoration(
        color: CommonColor.APP_BAR_COLOR,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              spreadRadius: 3,
              offset: Offset(2, 2.0))
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
                Text("Rs.${widget.totalAmount}",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400
                  ),),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.005),
                  child: Text("${widget.itemCount} Item",
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCheckPayParentScreen(index: 1, deliveryCharges: widget.deliveryCharges, orderFormat: widget.orderFormat, addressId: selectAddId,))).then((value){
                  setState(() {
                    AllCommonApis().getAddressOfUser().then((value){
                      if(mounted){
                        setState(() {
                          print(selectAddId);
                        });
                      }
                    });
                  });
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text("Continue",
                      style: TextStyle(
                          color: CommonColor.WHITE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*5.0,
                          fontFamily: 'Roboto_Bold',
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




}
