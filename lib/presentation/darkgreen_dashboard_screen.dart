import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/darkgreen_screen_constant.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/category_screen.dart';
import 'package:darkgreen/presentation/favorite_screen.dart';
import 'package:darkgreen/presentation/home_screen.dart';
import 'package:darkgreen/presentation/profile_screen.dart';
import 'package:darkgreen/presentation/search_screen.dart';
import 'package:flutter/material.dart';




class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with HomeScreenInterface, CategoryScreenInterface,
    FavoriteScreenInterface, ProfileScreenInterface{

  String currentScreen = "Dashboard";
  Widget? widDashboardScreen, widMenuScreen;
  bool isShow = true;


  @override
  void initState() {
    super.initState();
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
              shape: BoxShape.circle
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: parentHeight * 0.01),
            child: Text("Dark Green",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal*7.0,
                fontFamily: "Roboto_Medium",
                fontWeight: FontWeight.w500,
              color: CommonColor.WHITE_COLOR
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth*0.035),
            child: Container(
              width: parentWidth*0.18,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onDoubleTap: (){},
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct()));
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                   },
                   child: Container(
                     color: Colors.transparent,
                     child: Image(image: AssetImage("assets/images/trolly.png"),
                     height: parentHeight*0.03,),
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
              addNewScreen(
                  HomeScreen(
                    mListener: this,
                  ),
                  ScreenConstant.HOME_PAGE);
            },
            onDoubleTap: () {},
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
              isShow = true;
              addNewScreen(
                  CategoryScreen(
                    mListener: this,
                  ),
                  ScreenConstant.CATEGORY_FRAGMENT);
            },
            onDoubleTap: () {},
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
              isShow = true;
              addNewScreen(
                  FavoriteScreen(
                    mListener: this,
                  ),
                  ScreenConstant.FAVORITE_FRAGMENT);
            },
            onDoubleTap: () {},
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
              isShow = true;
              addNewScreen(
                  ProfileScreen(
                    mListener: this,
                  ),
                  ScreenConstant.PROFILE_FRAGMENT);
            },
            onDoubleTap: () {},
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
