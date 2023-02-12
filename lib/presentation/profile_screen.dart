import 'package:flutter/material.dart';



class ProfileScreen extends StatefulWidget {

  final ProfileScreenInterface mListener;


  const ProfileScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(),
    );
  }
}


abstract class ProfileScreenInterface{

}