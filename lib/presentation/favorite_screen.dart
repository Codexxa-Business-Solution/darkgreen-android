import 'package:flutter/material.dart';



class FavoriteScreen extends StatefulWidget {

  final FavoriteScreenInterface mListener;

  const FavoriteScreen({Key? key, required this.mListener}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(),
    );
  }
}


abstract class FavoriteScreenInterface{

}