import 'package:matlob/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class MainDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return new _MainDrawer();
  }
}

class _MainDrawer extends State<MainDrawer> {
  double _height = 0 , _width = 0;

  NavigationProvider _navigationProvider;
  AuthProvider _authProvider ;
  HomeProvider _homeProvider ;
  bool _initialRun = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
      _homeProvider = Provider.of<HomeProvider>(context);

      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {



      return Drawer(
          elevation: 20,

          child: ListView(
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
                       color: Colors.white,


                     ),
                     child: Image.asset("assets/images/logo.png",width: 70,height:70 ,),
                   ),
                    Padding(padding: EdgeInsets.all(7)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(4)),
                        Text("????????",style: TextStyle(color: Colors.black,fontSize: 18)),
                        Text("???????????? ????????????",style: TextStyle(color: Colors.black,fontSize: 16),),
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
                        Text("???????????? ????????????",style: TextStyle(color: Colors.black,fontSize: 16),),
                      ],
                    )
                  ],
                ),
              ),

               Container(
                 color: hintColor,
                 height: 1,
                 margin: EdgeInsets.all(5),
                 width: _width,
               ),

              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen()))
                ,

                dense:true,

                title: Text(AppLocalizations.of(context).translate("personal_info"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),

              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen())),
                dense:true,

                title: FutureBuilder<String>(
                    future: Provider.of<HomeProvider>(context,
                        listen: false)
                        .getUnreadNotify() ,
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
                              errorMessage: AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return  Row(
                              children: <Widget>[
                                Text( AppLocalizations.of(context).translate("notifications"),style: TextStyle(
                                    color: Colors.black,fontSize: 15
                                ),),
                                Padding(padding: EdgeInsets.all(3)),
                                Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),

                                  child: snapshot.data!="0"?Container(
                                      margin: EdgeInsets.symmetric(horizontal: _width *0.04),
                                      child: Text( snapshot.data.toString(),style: TextStyle(
                                          color: Colors.white,fontSize: 15,height: 1.6
                                      ),)):Text("",style: TextStyle(height: 0),),
                                ),
                              ],
                            );
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
              ),




              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouriteScreen())),
                dense:true,

                title: Text(AppLocalizations.of(context).translate("favourite"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),


              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAdsScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("my_ads"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),
              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyChatsScreen())),
                dense:true,

                title: FutureBuilder<String>(
                    future: Provider.of<HomeProvider>(context,
                        listen: false)
                        .getUnreadMessage() ,
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
                              errorMessage: AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return  Row(
                              children: <Widget>[
                                Text( AppLocalizations.of(context).translate("my_chats"),style: TextStyle(
                                    color: Colors.black,fontSize: 15
                                ),),
                                Padding(padding: EdgeInsets.all(3)),
                                Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),

                                  child: snapshot.data!="0"?Container(
                                      margin: EdgeInsets.symmetric(horizontal: _width *0.04),
                                      child: Text( snapshot.data.toString(),style: TextStyle(
                                          color: Colors.white,fontSize: 15,height: 1.6
                                      ),)):Text("",style: TextStyle(height: 0),),
                                ),
                              ],
                            );
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
              ),

              (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlacklistScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("blacklist"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),

              ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppCommissionScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("app_commission"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),
              ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("language"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),
              ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutAppScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("about_app"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),
              ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndRulesScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("rules_and_terms"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),
              ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactWithUsScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("contact_us"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ),

              (_authProvider.currentUser==null)?ListTile(
                onTap: ()=>    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen())),
                dense:true,

                title: Text( AppLocalizations.of(context).translate("login"),style: TextStyle(
                    color: Colors.black,fontSize: 15
                ),),
              ):ListTile(
                dense:true,

                title: Text( AppLocalizations.of(context).translate('logout'),style: TextStyle(
                    color: Colors.black,fontSize: 15
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
                            Navigator.pop(context);
                            SharedPreferencesHelper.remove("user");

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen()));
                            _authProvider.setCurrentUser(null);
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          ));



  }
}
