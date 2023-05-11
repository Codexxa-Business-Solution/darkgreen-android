import 'package:darkgreen/constant/color.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/Address.dart';
import 'package:darkgreen/presentation/add_check_pay_parent_screen.dart';
import 'package:darkgreen/presentation/address_chid_screen.dart';
import 'package:darkgreen/presentation/cart.dart';
import 'package:darkgreen/presentation/change_password.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:darkgreen/presentation/notification.dart';
import 'package:darkgreen/presentation/track_order_parent_screen.dart';
import 'package:darkgreen/presentation/wallet_history_screen.dart';
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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CommonColor.ORDER_PLACED_COLOR.withOpacity(0.5),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
        children: [
          getMyAccount(SizeConfig.screenHeight, SizeConfig.screenWidth),
          getOtherThingsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),

          /*Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.015, left: SizeConfig.screenWidth*0.04,
              right: SizeConfig.screenWidth*0.04),
              child: Container(
                height: SizeConfig.screenHeight*0.13,
                decoration: BoxDecoration(
                  color: CommonColor.APP_BAR_COLOR,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: getProfileInfoLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
              ),
            ),
            Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.015, left: SizeConfig.screenWidth*0.04,
                right: SizeConfig.screenWidth*0.04,
            bottom: SizeConfig.screenHeight*0.03),
            child: Container(
                decoration: BoxDecoration(
                    color: CommonColor.WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: getAllOptionsLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
            ),
          )*/
        ],
      ),
    );
  }

  Widget getProfileInfoLayout(double parentHeight, double parentWidth) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: parentWidth * 0.03),
          child: Container(
            height: parentHeight * 0.1,
            width: parentHeight * 0.1,
            decoration: BoxDecoration(
                color: CommonColor.CIRCLE_COLOR,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.person,
              size: parentHeight * 0.09,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: parentWidth * 0.03, top: parentHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                width: parentWidth * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ash",
                      style: TextStyle(
                          color: CommonColor.WHITE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.edit,
                      size: parentHeight * 0.025,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.015),
                child: Text(
                  "1234567890",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontFamily: 'Roboto-Light',
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.005),
                child: Text(
                  "Wallet : \u20B90",
                  style: TextStyle(
                      color: CommonColor.WHITE_COLOR,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      fontFamily: 'Roboto-Light',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getAllOptionsLayout(double parentHeight, double parentWidth) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route route) => false);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Cart",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
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
            child: Text(
              "Hii",
              style: TextStyle(color: Colors.transparent),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrackOrderParentScreen()));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delivery_dining_outlined,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Your Orders",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WalletHistory()));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Wallet History",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.import_export,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Transaction History",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                
                onTap: () {
                  /*showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 20,
                      isScrollControlled: true,
                      isDismissible: true,
                      enableDrag: true,
                      builder: (BuildContext bc) {
                        return ChangePassword();
                      });*/
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 10,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (BuildContext bc) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                              height: SizeConfig.screenHeight * 0.45,
                              //height or you can use Get.width-100 to set height
                              child: ChangePassword()),
                        );
                      });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: GestureDetector(
            
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCheckPayParentScreen(
                            index: 0,
                            orderFormat: '',
                            addressId: '',
                          )));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.manage_accounts_rounded,
                        size: parentHeight * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          "Manage Addresses",
                          style: TextStyle(
                              color: CommonColor.GRAY_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: parentHeight * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.support_agent_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Support",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_add_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Refer & Earn",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
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
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Blog",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.perm_contact_cal_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "About Us",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Rate Us",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.share,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Share App",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "FAQ",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.event_note,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.security_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: parentHeight * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.05),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: CommonColor.GRAY_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                          fontFamily: 'Roboto-Light',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: parentHeight * 0.02,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.02,
              left: parentWidth * 0.05,
              right: parentWidth * 0.05),
          child: Container(),
        ),
      ],
    );
  }

  Widget getMyAccount(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: parentWidth * 0.05,
          top: parentHeight * 0.03,
          right: parentWidth * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "My Account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01),
            child: Row(
              children: [
                Text(
                  "Log in or sign up to view your complete profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: Container(
              width: parentWidth * 0.9,
              height: parentHeight * 0.05,
              decoration: BoxDecoration(
                  color: CommonColor.APP_BAR_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                        fontFamily: 'Roboto_Medium',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.only(top: parentHeight*0.01),
          //   child: Row(
          //     children: [
          //       Text("1234567890",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: SizeConfig.blockSizeHorizontal*3.6,
          //             fontFamily: 'Roboto_Regular',
          //             fontWeight: FontWeight.w400
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget getOtherThingsLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: parentWidth * 0.05,
          top: parentHeight * 0.03,
          right: parentWidth * 0.05),
      child: Column(
        children: [
          Container(
            height: parentHeight * 0.07,
            width: parentWidth * 0.9,
            decoration: BoxDecoration(
                color: CommonColor.CIRCLE_COLOR,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onDoubleTap: (){},
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletHistory()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.005),
                          child: Text(
                            "Wallet",
                            style: TextStyle(
                                color: CommonColor.BLACK_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.07),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.support_agent_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.005),
                          child: Text(
                            "Support",
                            style: TextStyle(
                                color: CommonColor.BLACK_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.import_export,
                        size: parentHeight * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: parentHeight * 0.005),
                        child: Text(
                          "Transaction",
                          style: TextStyle(
                              color: CommonColor.BLACK_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.03),
            child: Row(
              children: [
                Text(
                  "Your Information",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrackOrderParentScreen()));
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.delivery_dining_outlined,
                            size: parentHeight * 0.03),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Your Orders",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCheckPayParentScreen(
                              index: 0,
                              orderFormat: '',
                              addressId: '',
                            )));
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.manage_accounts_rounded,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Manage Addresses",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 20,
                    isScrollControlled: true,
                    isDismissible: true,
                    enableDrag: true,
                    builder: (BuildContext bc) {
                      return ChangePassword();
                    });
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Cart()));
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Cart",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Notification",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.03),
            child: Row(
              children: [
                Text(
                  "Other Information",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_add_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Refer & Earn",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit_note_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Blog",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.perm_contact_cal_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "About Us",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Rate Us",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.share,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Share App",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "FAQ",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.event_note,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Terms and Conditions",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: GestureDetector(
              
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: parentHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.05),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: CommonColor.GRAY_COLOR,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontFamily: 'Roboto-Light',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: parentHeight * 0.02,
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

abstract class ProfileScreenInterface {}
