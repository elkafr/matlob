
import 'package:matlob/ui/auth/code_activation_screen.dart';
import 'package:matlob/ui/account/active_account_screen.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/auth/new_password_screen.dart';
import 'package:matlob/ui/auth/phone_password_recovery_screen.dart';
import 'package:matlob/ui/auth/register_screen.dart';
import 'package:matlob/ui/bottom_navigation.dart/bottom_navigation_bar.dart';
import 'package:matlob/ui/my_ads/my_ads_screen.dart';
import 'package:matlob/ui/notification/notification_screen.dart';
import 'package:matlob/ui/seller/seller_screen.dart';
import 'package:matlob/ui/splash/splash_screen.dart';
import 'package:matlob/ui/search/search_screen.dart';
import 'package:matlob/ui/seller/seller_screen.dart';
import 'package:matlob/ui/account/pay_commission_screen.dart';
import 'package:matlob/ui/blacklist/blacklist_screen.dart';


final routes = {
  '/': (context) => SplashScreen(),
  '/login_screen':(context)=> LoginScreen(),
  '/phone_password_reccovery_screen' :(context) => PhonePasswordRecoveryScreen(),
  '/code_activation_screen':(context) => CodeActivationScreen(),
  '/active_account_screen':(context) => ActiveAccountScreen(),
 '/new_password_screen' :(context) => NewPasswordScreen(),
 '/register_screen':(context) => RegisterScreen(),
  '/navigation': (context) =>  BottomNavigation(),
  '/my_ads_screen':(context) =>MyAdsScreen(),
 '/notification_screen':(context) => NotificationScreen(),
  '/search_screen':(context) => SearchScreen(),
  '/seller_screen':(context) => SellerScreen(),
  '/pay_commission_screen':(context) => PayCommissionScreen(),
  '/blacklist_screen':(context) => BlacklistScreen(),


};
