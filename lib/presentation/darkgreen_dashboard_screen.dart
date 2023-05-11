import 'package:darkgreen/allCommonApis/common_api.dart';
import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/darkgreen_screen_constant.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/category_screen.dart';
import 'package:darkgreen/presentation/exit_dialog.dart';
import 'package:darkgreen/presentation/favorite_screen.dart';
import 'package:darkgreen/presentation/home_screen.dart';
import 'package:darkgreen/presentation/profile_screen.dart';
import 'package:darkgreen/presentation/search_screen.dart';
import 'package:flutter/material.dart';




class Dashboard extends StatefulWidget {

  final int cartCount;
  final String comeFrom;

  const Dashboard({Key? key, this.cartCount = 0, this.comeFrom = "0"}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with HomeScreenInterface, CategoryScreenInterface,
    FavoriteScreenInterface, ProfileScreenInterface{

  String currentScreen = "Dashboard";
  Widget? widDashboardScreen, widMenuScreen;
  bool isShow = true;

  String? userName;

  int cartCount = 0;

  Future<bool> _onBackPressed() {
    return showExitDialog(context);
  }

  Future<void> init() async {
    userName = await AppPreferences.getUserName();
  }

  @override
  void initState() {
    super.initState();



    if(mounted){
      setState(() {

        init();

        if(widget.comeFrom == "1"){
          cartCount = widget.cartCount;
        }
        AllCommonApis().getAllCarts().then((value){
          cartCount = value.data.length;
          print(cartCount);
        });
      });
    }
    addNewScreen(
        HomeScreen(
          mListener: this,
        ),
        ScreenConstant.HOME_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop:  _onBackPressed,
        child: Material(
          child: Column(
            children: [
              Visibility(
                visible: isShow,
                child: Container(
                  color: CommonColor.APP_BAR_COLOR,
                  height: SizeConfig.safeUsedHeight * .12,
                  child: getTopText(SizeConfig.screenHeight, SizeConfig.screenWidth),
                ),
              ),
              Container(
                height: SizeConfig.safeUsedHeight * .8,
                child: getContainer(),
              ),
              Container(
                height: SizeConfig.safeUsedHeight * .08,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 7,
                        spreadRadius: 3,
                        offset: Offset(2, 2.0))
                  ],
                ),
                child: getBottomBarDesign(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget getContainer() {
    return Container(
      child: widDashboardScreen,
    );
  }

  getUpdateParentScreen(Widget showScreen) {
    return setState(() {
      widDashboardScreen = showScreen;
    });
  }

  /*Function for change dashboard Screen*/
  addNewScreen(Widget newScreen, String currentScreenStatus) {
    currentScreen = currentScreenStatus;
    if (mounted) {
      setState(() {
        widDashboardScreen = newScreen;
      });
    }
  }

  Widget getTopText(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth*0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: parentWidth*0.12,
            decoration: BoxDecoration(
              color: CommonColor.CIRCLE_COLOR,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/images/appLogo.jpeg",),
                fit: BoxFit.contain,),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Text(userName != null ? "$userName" : "",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal*7.0,
                fontFamily: "Roboto_Medium",
                fontWeight: FontWeight.w500,
              color: CommonColor.WHITE_COLOR
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth*0.01),
            child: Container(
              width: parentWidth*0.2,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct())).then((value){
                        if(mounted){
                          setState(() {
                            AllCommonApis().getAllCarts().then((value) {
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
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.search,
                      color: Colors.white,
                      size: parentHeight*0.035,),
                    ),
                  ),
                 GestureDetector(
                   onDoubleTap: (){},
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())).then((value){
                       if(mounted){
                         setState(() {
                           AllCommonApis().getAllCarts().then((value) {
                             if (mounted) {
                               setState(() {
                                 cartCount = value.data.length;
                                 print(cartCount);
                               });
                             }
                           });

                           isShow = true;
                           addNewScreen(
                               HomeScreen(
                                 mListener: this,
                               ),
                               ScreenConstant.HOME_PAGE);
                         });
                       }

                     });
                   },
                   child: Container(
                     color: Colors.transparent,
                     child: Stack(
                       alignment: Alignment.topRight,
                       children: [
                         Padding(
                           padding: EdgeInsets.only(top: parentHeight*0.01),
                           child: Container(
                             height: parentHeight*0.05,
                             color: Colors.transparent,
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Image(image: AssetImage("assets/images/trolly.png"),
                               height: parentHeight*0.03,),
                             ),
                           ),
                         ),
                         Visibility(
                           visible: cartCount == 0 ? false : true,
                           child: Padding(
                             padding: EdgeInsets.only(bottom: parentHeight*0.04, right: parentWidth*0.005),
                             child: Container(
                               height: parentHeight*0.05,
                               width: parentWidth*0.05,
                               decoration: BoxDecoration(
                                   color: CommonColor.WHITE_COLOR,
                                   shape: BoxShape.circle,
                                   border: Border.all(color: CommonColor.APP_BAR_COLOR)
                               ),
                               child: Center(
                                 child: Text("$cartCount",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeHorizontal*2.5,
                                       color: Colors.black
                                   ),),
                               ),
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBottomBarDesign(double parentHeight, double parentWidth) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17),
          topRight: Radius.circular(17),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {

              if(mounted){
                setState(() {
                  AllCommonApis().getAllCarts().then((value) {
                    if (mounted) {
                      setState(() {
                        cartCount = value.data.length;
                        print(cartCount);
                      });
                    }
                  });
                });
              }


              addNewScreen(
                  HomeScreen(
                    mListener: this,
                  ),
                  ScreenConstant.HOME_PAGE);
            },
            
            child: Container(
              height: parentHeight*0.07,
              width: parentWidth*0.17,
              decoration: BoxDecoration(
                color: CommonColor.ICON_BACKGROUND_COLOR,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/home.png"),
                    color: currentScreen == ScreenConstant.HOME_PAGE
                        ? CommonColor.APP_BAR_COLOR
                        : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                    height: parentHeight*0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.003),
                    child: Text(
                      "Home",
                      style: TextStyle(
                          color: currentScreen == ScreenConstant.HOME_PAGE
                              ? CommonColor.APP_BAR_COLOR
                              : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal*3.5,
                      fontFamily: "Roboto_Bold",
                      fontWeight: FontWeight.w400),

                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

              if(mounted){
                setState(() {
                  AllCommonApis().getAllCarts().then((value) {
                    if (mounted) {
                      setState(() {
                        cartCount = value.data.length;
                        print(cartCount);
                      });
                    }
                  });
                });
              }

              isShow = true;
              addNewScreen(
                  CategoryScreen(
                    mListener: this,
                  ),
                  ScreenConstant.CATEGORY_FRAGMENT);
            },
            
            child: Container(
              height: parentHeight*0.07,
              width: parentWidth*0.17,
              decoration: BoxDecoration(
                  color: CommonColor.ICON_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/category.png"),
                    color: currentScreen == ScreenConstant.CATEGORY_FRAGMENT
                        ? CommonColor.APP_BAR_COLOR
                        : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                    height: parentHeight*0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.003),
                    child: Text(
                      "Category",
                      style: TextStyle(
                          color: currentScreen == ScreenConstant.CATEGORY_FRAGMENT
                              ? CommonColor.APP_BAR_COLOR
                              : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*3.5,
                          fontFamily: "Roboto_Bold",
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

              if(mounted){
                setState(() {
                  AllCommonApis().getAllCarts().then((value) {
                    if (mounted) {
                      setState(() {
                        cartCount = value.data.length;
                        print(cartCount);
                      });
                    }
                  });
                });
              }

              isShow = true;
              addNewScreen(
                  FavoriteScreen(
                    mListener: this,
                  ),
                  ScreenConstant.FAVORITE_FRAGMENT);
            },
            
            child: Container(
              height: parentHeight*0.07,
              width: parentWidth*0.17,
              decoration: BoxDecoration(
                  color: CommonColor.ICON_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/favorite.png"),
                    color: currentScreen == ScreenConstant.FAVORITE_FRAGMENT
                        ? CommonColor.APP_BAR_COLOR
                        : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                    height: parentHeight*0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.003),
                    child: Text(
                      "Favorite",
                      style: TextStyle(
                          color: currentScreen == ScreenConstant.FAVORITE_FRAGMENT
                              ? CommonColor.APP_BAR_COLOR
                              : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*3.5,
                          fontFamily: "Roboto_Bold",
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

              if(mounted){
                setState(() {
                  AllCommonApis().getAllCarts().then((value) {
                    if (mounted) {
                      setState(() {
                        cartCount = value.data.length;
                        print(cartCount);
                      });
                    }
                  });
                });
              }

              isShow = true;
              addNewScreen(
                  ProfileScreen(
                    mListener: this,
                  ),
                  ScreenConstant.PROFILE_FRAGMENT);
            },
            
            child: Container(
              height: parentHeight*0.07,
              width: parentWidth*0.17,
              decoration: BoxDecoration(
                  color: CommonColor.ICON_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/profile.png"),
                    color: currentScreen == ScreenConstant.PROFILE_FRAGMENT
                        ? CommonColor.APP_BAR_COLOR
                        : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                    height: parentHeight*0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.003),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          color: currentScreen == ScreenConstant.PROFILE_FRAGMENT
                              ? CommonColor.APP_BAR_COLOR
                              : CommonColor.DASHBOARD_UNSELECTED_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*3.5,
                          fontFamily: "Roboto_Bold",
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  static showExitDialog(BuildContext context) {
    if (context != null) {
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            // return Transform(
            //   transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: ExitAppDialog(
                  message: "Are You Sure To Exit",
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation2, animation1) {
            return Container();
          });
    }
  }

  @override
  getAddCategoriesLayout() {
    isShow = true;
    addNewScreen(
        CategoryScreen(
          mListener: this,
        ),
        ScreenConstant.CATEGORY_FRAGMENT);
  }
}
