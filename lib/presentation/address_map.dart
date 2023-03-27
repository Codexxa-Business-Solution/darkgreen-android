
import 'dart:async';

import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';




class AddressMap extends StatefulWidget {

  final String buttonText;

  const AddressMap({Key? key, required this.buttonText}) : super(key: key);

  @override
  State<AddressMap> createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {



  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? controller;

  List<Placemark>? placeMark;
  String _address = '';
  Timer? _debounce;
  String name = "";
  String street = "";
  String subLocality = "";
  String locality = "";
  String postalCode = "";
  String administrativeArea = "";
  String country = "";
  double selectLat = 0.0;
  double selectLong = 0.0;

  static const kGoogleApiKey = "AIzaSyDmKx2C1OIAxNzTeoxEH1U8getJT3hTQF4";


  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(18.6011, 73.7641),
    zoom: 14
  );


  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(28.7041, 77.1025),
      infoWindow: InfoWindow(title: 'marker'),
    )
  ];


  @override
  void initState() {
    super.initState();
    getUserCurrentLocation().then((value) async {
      print("${value?.latitude.toString()}    ${value?.longitude.toString()}");

      selectLat = value?.latitude ?? 0.0;
      selectLong = value?.longitude ?? 0.0;

      _markers.add(
          Marker(
              markerId:MarkerId('2'),
              position: LatLng(double.parse("${value?.latitude.toString()}"), double.parse("${value?.longitude.toString()}")),
              infoWindow: InfoWindow(
                  title: 'Current'
              )
          )
      );


      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(double.parse("${value?.latitude.toString()}"),
              double.parse("${value?.longitude.toString()}")));

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      placeMark = await placemarkFromCoordinates(double.parse("${value?.latitude.toString()}"),
          double.parse("${value?.longitude.toString()}"));

      print("placemark  ${placeMark?[0].name}  ${placeMark?[0].locality}  ${placeMark?[0].postalCode}");

      setState(() {

      });

    });
  }

  Future<Position?> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }


  _updateAddress(LatLng target) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () async {

      _markers.clear();
      _markers.add(
          Marker(
              markerId:MarkerId('2'),
              position: LatLng(double.parse("${target.latitude}"), double.parse("${target.longitude}")),
              infoWindow: InfoWindow(
                  title: 'Current'
              )
          )
      );

      selectLat = double.parse("${target.latitude}");
      selectLong = double.parse("${target.longitude}");


      await placemarkFromCoordinates(double.parse("${target.latitude}"),
          double.parse("${target.longitude}")).then((value) {

              setState(() {

              });

            name = value[0].name.toString();
            street = value[0].street.toString();
            subLocality = value[0].subLocality.toString();
            locality = value[0].locality.toString();
            postalCode = value[0].postalCode.toString();
            administrativeArea = value[0].administrativeArea.toString();
            country = value[0].country.toString();

      });

      print(placeMark);
    });
  }

  _updateAddressTap(double lat, double long) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {

      _markers.clear();
      _markers.add(
          Marker(
              markerId: MarkerId('2'),
              position: LatLng(lat, long),
              infoWindow: InfoWindow(
                  title: 'Current'
              )
          )
      );

      selectLat = lat;
      selectLong = long;

      await placemarkFromCoordinates(lat, long).then((value){
        setState(() {

        });

        print(value);

        name = value[0].name.toString();
        street = value[0].street.toString();
        subLocality = value[0].subLocality.toString();
        locality = value[0].locality.toString();
        postalCode = value[0].postalCode.toString();
        administrativeArea = value[0].administrativeArea.toString();
        country = value[0].country.toString();
      });


    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            onCameraMove: (position) {
              _updateAddress(position.target);
              setState(() {

              });
            },
            onTap: (position){
              _updateAddressTap(position.latitude, position.longitude);
              setState(() {
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.height * .2,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child:name.isNotEmpty ? Card(
                        elevation: 5,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: name.isNotEmpty ? Text('$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                                style: TextStyle(
                                  color: Colors.black
                              ),) : Text(""),
                             ),
                            ))
                          : Container(),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>
                           Address(isCome: widget.buttonText,
                         address: '$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                         landMark: '$name, $subLocality',
                         city: locality,
                         area: subLocality,
                         country: country,
                         state: administrativeArea,
                         postalCode: postalCode, lat: selectLat, long: selectLong,
                       )));
                      },
                      child: const Text('Save Address'),
                    )
                  ]),
            ),
          ),
          getSearchBarLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
        ],
      ),
    );
  }

  Widget getSearchBarLayout(double parentHeight, parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * .05,
          right: SizeConfig.screenWidth * .05,
          top: SizeConfig.screenHeight * 0.07),
      child: Container(
        height: SizeConfig.screenHeight * .050,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
              child: const Image(
                image: AssetImage("assets/images/search.png"),
                // fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.02,
                    right: SizeConfig.screenWidth * .01),
                child: GestureDetector(
                  onTap: () async {

                    _handlePressButton();

                  },
                  child: Text("Search Location",style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                    color: CommonColor.SEARCH_TEXT_COLOR,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      offset: 0,
      radius: 1000,
      types: [],
      strictbounds: false,
      components: [],
    );

    displayPrediction(p);
    setState(
          () {

      },
    );

  }


  Future<Null> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,

        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      selectLong = double.parse('$lng');
      selectLat = double.parse('$lat');

      setState(() {


        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 100), () async {

          CameraPosition cameraPosition = CameraPosition(
              zoom: 14,
              target: LatLng(selectLat, selectLong));

          final GoogleMapController controller = await _controller.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

          _markers.clear();
          _markers.add(
              Marker(
                  markerId:MarkerId('2'),
                  position: LatLng(selectLat, selectLong),
                  infoWindow: InfoWindow(
                      title: 'Current'
                  )
              )
          );


          await placemarkFromCoordinates(selectLat,
              selectLong).then((value) {

            setState(() {

            });

            name = value[0].name.toString();
            street = value[0].street.toString();
            subLocality = value[0].subLocality.toString();
            locality = value[0].locality.toString();
            postalCode = value[0].postalCode.toString();
            administrativeArea = value[0].administrativeArea.toString();
            country = value[0].country.toString();

          });

          print(placeMark);
        });

      });

    }}

}
