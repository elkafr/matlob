

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field2.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/drower/drower_screen.dart';
import 'package:matlob/ui/favourite/favourite_screen.dart';
import 'package:matlob/ui/home/home_map.dart';
import 'package:flutter/services.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'dart:math' as math;
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field1.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/ui/search/search_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/category.dart';
import 'package:matlob/models/city.dart';
import 'package:matlob/models/country.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/ui/search/search_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

AuthProvider _authProvider;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double _height = 0, _width = 0;
  bool isDrawerOpen = false;
String _searchKey = '';
HomeProvider _homeProvider;
bool _initialRun = true;
  String _lang;
bool _isLoading = false;


Future<Null> _checkEnd() async {





}






@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_initialRun) {
    _homeProvider = Provider.of<HomeProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    _initialRun = false;

  }
}


  Future<void> _getLanguage() async {
    String language = await SharedPreferencesHelper.getUserLang();
    setState(() {
      _lang = language;
    });
  }
  Widget _customAppBar() {
    return Container(


      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: isDrawerOpen
            ? Text("")
            : GestureDetector(
            child:
            _lang == 'ar' ?
            Image.asset( 'assets/images/menu.png', fit: BoxFit.contain,)

                : Transform.rotate(
              angle: -180 * math.pi / 180,
              child:  Image.asset(
                'assets/images/menu.png',
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              setState(() {
                xOffset = (_lang == 'ar')? -200 : 290 ;
                yOffset = 80;
                scaleFactor = 0.8;
                isDrawerOpen = true;
              });
            }),
        title:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(
                color: Colors.grey[200],
              ),
              color: Colors.grey[200],

            ),
          height: 40,
          alignment: Alignment.center,

          child: Row(
            children: <Widget>[
              Container(
            width: _width*.5,

                child: CustomTextFormField2(

                  hintTxt: _homeProvider.currentLang=="ar"?"رقم الاعلان او عبارة البحث":"Ad number or search term",
                  onChangedFunc: (text) {
                    _searchKey = text;
                  },

                ),
              ),
              IconButton(
             icon: Icon(Icons.search,color: omarColor,),
                onPressed: () {
                  _homeProvider.setEnableSearch(true);
                  _homeProvider.setSearchKey(_searchKey);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen()));

                },
              )
            ],
          )
        ),

        trailing:      GestureDetector(
            onTap: () {

              if(_authProvider.currentUser!=null){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FavouriteScreen()));
              }else{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen()));
              }


            },
            child: Container(

              width: _width*.1,
              child: Icon(Icons.favorite_border),
            )),
      ),
    );
  }
  




  @override
  void initState() {
    super.initState();


    _getLanguage();



  }

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              (isDrawerOpen == false) ? Brightness.dark : Brightness.light),
      child: Scaffold(
        body: Stack(
          children: [
            AppDrawer(),
           
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(isDrawerOpen ? -0.5 : 0),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(isDrawerOpen?20:0.0)
              ),
              child: Container(


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      height: 25,
                    ),
                   _customAppBar(),
                    Container(
                      height: _height * 0.82,
                      width: _width,
                      child: Stack(children: [


                        HomeMap(),



                        isDrawerOpen
                            ? Container(
                          margin: EdgeInsets.all(0),
                          color: Colors.black,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,size: 40,color: Colors.white,),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          ),
                        ):Text(""),








                      ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}