import 'dart:async';

import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/Address.dart';
import 'package:darkgreen/presentation/address_map.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';




class CurrentLocationDialogue extends StatefulWidget {

  final String buttonText;

  const CurrentLocationDialogue({Key? key, required this.buttonText}) : super(key: key);

  @override
  State<CurrentLocationDialogue> createState() => _CurrentLocationDialogueState();
}

class _CurrentLocationDialogueState extends State<CurrentLocationDialogue> {


  List<Placemark>? placeMark;
  String name = "";
  String street = "";
  String subLocality = "";
  String locality = "";
  String postalCode = "";
  String administrativeArea = "";
  String country = "";
  double lat = 0.0;
  double long = 0.0;

  Future<Position?> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }



  @override
  void initState() {
    super.initState();

    print("Hiii");

    if(mounted){
      setState(() {
        getUserCurrentLocation().then((value) async {
          print("${value?.latitude.toString()}    ${value?.longitude.toString()}");

          lat = value?.latitude ?? 0.0;
          long = value?.longitude ?? 0.0;

          placeMark = await placemarkFromCoordinates(double.parse("${value?.latitude.toString()}"),
              double.parse("${value?.longitude.toString()}")).then((value) {

                if(mounted) {
                  setState(() {

            });
                }

            print(value);

            name = value[0].name.toString();
            street = value[0].street.toString();
            subLocality = value[0].subLocality.toString();
            locality = value[0].locality.toString();
            postalCode = value[0].postalCode.toString();
            administrativeArea = value[0].administrativeArea.toString();
            country = value[0].country.toString();

          });

          print("placemark  ${lat}  ${long}  ${placeMark?[0].postalCode}");

          if(mounted) {
            setState(() {

            });
          }

        });
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * .13,
            right: SizeConfig.screenWidth * .13),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child:  Container(
            decoration:  const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(25.0)),
              //color: CommonColor.RED_COLOR,
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03,
                  left: SizeConfig.screenWidth*0.05,
                  right: SizeConfig.screenWidth*0.05,),
                  child: Row(
                    children: [
                      Text("Add this current location",
                      style: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                          fontFamily: 'Roboto_Bold'),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03,
                    left: SizeConfig.screenWidth*0.05,
                    right: SizeConfig.screenWidth*0.05,
                  ),
                  child: name.isNotEmpty ?Row(
                    children: [
                      Expanded(
                        child: Text('$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                          style: TextStyle(
                              color: CommonColor.BLACK_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              fontFamily: 'Roboto_Regular',
                          fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.03,
                    left: SizeConfig.screenWidth*0.03,
                    right: SizeConfig.screenWidth*0.03,
                  bottom: SizeConfig.screenHeight*0.01,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onDoubleTap: (){},
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressMap(buttonText: widget.buttonText,)));
                        },
                        child: Container(
                          height: SizeConfig.screenHeight*0.05,
                          width: SizeConfig.screenWidth*0.32,
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("NO",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400),)),
                        ),
                      ),

                      GestureDetector(
                        onDoubleTap: (){},
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              Address(isCome: widget.buttonText,
                                address: '$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                                landMark: '$name, $subLocality',
                                city: locality,
                                area: subLocality,
                                country: country,
                                state: administrativeArea,
                                postalCode: postalCode, lat: lat, long: long,
                              ))).then((value){
                                Navigator.pop(context);
                          });
                          // Navigator.of(context).pop(placeMark);
                        },
                        child: Container(
                          height: SizeConfig.screenHeight*0.05,
                          width: SizeConfig.screenWidth*0.32,
                          decoration: BoxDecoration(
                              color:CommonColor.APP_BAR_COLOR,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("YES",
                            style: TextStyle(
                                color: CommonColor.WHITE_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400),)),
                        ),
                      ),                  ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
