import 'package:matlob/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matlob/ui/blacklist1/blacklist1_screen.dart';
import 'package:matlob/ui/follow/follow_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:matlob/ui/account/about_app_screen.dart';
import 'package:matlob/ui/account/app_commission_screen.dart';
import 'package:matlob/ui/account/contact_with_us_screen.dart';
import 'package:matlob/ui/account/language_screen.dart';
import 'package:matlob/ui/account/personal_information_screen.dart';
import 'package:matlob/ui/account/terms_and_rules_Screen.dart';
import 'package:matlob/ui/my_ads/my_ads_screen.dart';
import 'package:matlob/ui/notification/notification_screen.dart';
import 'package:matlob/ui/favourite/favourite_screen.dart';
import 'package:matlob/ui/my_chats/my_chats_screen.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:matlob/ui/blacklist/blacklist_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/providers/terms_provider.dart';
import 'package:matlob/utils/error.dart';
import 'package:matlob/ui/add_ad/widgets/add_ad_bottom_sheet.dart';

class AppDrawer extends StatelessWidget {
  double _width, _height;

  AuthProvider _authProvider ;
  HomeProvider _homeProvider ;
  NavigationProvider _navigationProvider;

  Widget _buildAppDrawer(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
    _navigationProvider = Provider.of<NavigationProvider>(context);
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 70, bottom: 30, left: 10, right:10),
      width: _width,

      child:  ListView(
        padding: EdgeInsets.zero,

        children: <Widget>[




          (_authProvider.currentUser==null)?
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: hintColor.withOpacity(0.4),
                    ),
                    color: Color(0xff4C4C4C),


                  ),
                  child: Image.asset("assets/images/logo.png",width: 70,height:70 ,),
                ),
                Padding(padding: EdgeInsets.all(7)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)),
                    Text("زائر",style: TextStyle(color: Color(0xff4C4C4C),fontSize: 18)),
                    Text("الحساب الشخصي",style: TextStyle(color: Colors.black,fontSize: 16),),
                  ],
                )
              ],
            ),
          )
              :Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Consumer<AuthProvider>(
                    builder: (context,authProvider,child){
                      return CircleAvatar(
                        backgroundColor: accentColor,
                        backgroundImage: NetworkImage(authProvider.currentUser.userPhoto),
                        maxRadius: 40,
                      );
                    }
                ),
                Padding(padding: EdgeInsets.all(7)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)),
                    Text(_authProvider.currentUser.userName,style: TextStyle(color: mainAppColor,fontSize: 18)),
                    Text("الحساب الشخصي",style: TextStyle(color: Colors.black,fontSize: 16),),
                  ],
                )
              ],
            ),
          ),



          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalInformationScreen()))
            ,

            dense:true,

            title: Text(AppLocalizations.of(context).translate("personal_info"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),



          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: (){

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(

                    content: Container(
                      alignment: Alignment.center,
                      height: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add),
                                Text("إضافة طلب",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            onTap: (){

                              _homeProvider.setAdsRequest("1");
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        child: AddAdBottomSheet());
                                  });
                            },
                          ),


                          SizedBox(height: 20,),

                          GestureDetector(
                            child:  Row(
                              children: <Widget>[
                                Icon(Icons.add),
                                Text("إضافة عرض",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            onTap: (){

                              if(_authProvider.currentUser.userType=="2") {

                                _homeProvider.setAdsRequest("2");
                                showModalBottomSheet<dynamic>(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.7,
                                          child: AddAdBottomSheet());
                                    });

                              }else{


                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("تحذير"),
                                      content: Text(
                                        "عفوا اضافة عرض متاحة فقط لعضوية مقدم الخدمة ",
                                        style: TextStyle(
                                            color: omarColor,
                                            fontWeight: FontWeight.w700,

                                            fontSize: 18),
                                      ),

                                    );
                                  },
                                );


                              }


                            },
                          )


                        ],
                      ),
                    ),

                  );
                },
              );
            }
            ,

            dense:true,

            title: Text("اضافة اعلان",style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),



          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavouriteScreen())),
            dense:true,

            title: Text("المفضلة",style: TextStyle(
                color:Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),


          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowScreen())),
            dense:true,

            title: Text("المتابعة",style: TextStyle(
                color:Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),


          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyAdsScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("my_ads"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),



          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlacklistScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("blacklist"),style: TextStyle(
                color:Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),


          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Blacklist1Screen())),
            dense:true,

            title: Text( "الاعلانات الممنوعة",style: TextStyle(
                color:Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),


          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppCommissionScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("app_commission"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),

          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutAppScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("about_app"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),
          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndRulesScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("rules_and_terms"),style: TextStyle(
                color:Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),
          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactWithUsScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("contact_us"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ),

          Padding(padding: EdgeInsets.all(20)),
          (_authProvider.currentUser==null)?ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("login"),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
          ):ListTile(
            dense:true,
            leading: Icon(FontAwesomeIcons.signOutAlt,color: mainAppColor,),
            title: Text( AppLocalizations.of(context).translate('logout'),style: TextStyle(
                color: Color(0xff4C4C4C),fontSize: 15,fontWeight: FontWeight.bold
            ),),
            onTap: (){
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return LogoutDialog(
                      alertMessage:
                      AppLocalizations.of(context).translate('want_to_logout'),
                      onPressedConfirm: () {


                        SharedPreferencesHelper.remove("user");
                        _homeProvider.setCheckedValue("false");

                        _authProvider.setCurrentUser(null);

                        _navigationProvider.upadateNavigationIndex(0);
                        Navigator.pushReplacementNamed(context,  '/navigation');


                      },
                    );
                  });
            },
          ),




          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _width * 0.1, vertical: _height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getTwitt() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/twitter.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    })
                ,

                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getLinkid() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/linkedin.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getInst() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/instagram.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getFace() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
              ],
            ),
          ),






        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return _buildAppDrawer(context);
  }
}
