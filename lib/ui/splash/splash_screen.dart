import 'package:flutter/cupertino.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:location/location.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  double _height = 0, _width = 0;
  AuthProvider _authProvider;
  HomeProvider _homeProvider;
  LocationData _locData;


  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  
    Future initData() async {
    await Future.delayed(Duration(seconds: 4));
  }





   Future<void> _getLanguage() async {
    String currentLang = await SharedPreferencesHelper.getUserLang();
    _authProvider.setCurrentLanguage(currentLang);



   }





  Future<void> _getCurrentUserLocation() async {
    _locData = await Location().getLocation();
    if(_locData != null){
      print('lat' + _locData.latitude.toString());
      print('longitude' + _locData.longitude.toString());

      setState(() {


      });
    }
  }



  Future<Null> _checkIsLoginUser() async {
    var userData = await SharedPreferencesHelper.read("checkUser");
    if (userData != null) {
      _homeProvider.setCheckedValue(userData.toString());
    }else{
      _homeProvider.setCheckedValue("false");
    }

  }




  @override
  void initState() {
    super.initState();
      _getLanguage();
    _checkIsLoginUser();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2300),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.fromDirection(0.2, 0.1),
      end: Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    initData().then((value) {
print(_homeProvider.checkedValue);






Navigator.pushReplacementNamed(context,  '/navigation');


    });

  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);




    return Scaffold(
      body: Stack(
          children: [
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
              height: _height,
              width: _width,
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: _width,
                margin: EdgeInsets.only(top: _height * 0.3),
                padding: EdgeInsets.only(right: _width * 0.18),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),

            Positioned(
              bottom: 10,
                right: _width*.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Text("تطبيق مطلوب",style: TextStyle(color: mainAppColor,fontSize: 15),),
               Padding(padding: EdgeInsets.all(7)),
               Text(" طلبك موجود !!",style: TextStyle(color: Colors.black,fontSize: 15),)
              ],
            ))
          ] ),
    );
  }
}
