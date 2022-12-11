import 'package:matlob/models/ad.dart';
import 'package:matlob/ui/follow/widgets/my_follow_item.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/ui/my_ads/widgets/my_ad_item.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/ui/seller/seller_screen.dart';
import 'package:matlob/utils/error.dart';
import 'package:matlob/ui/add_ad/widgets/add_ad_bottom_sheet.dart';
import 'package:matlob/ui/ad_details/ad_details_screen.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/networking/api_provider.dart';

import 'dart:math' as math;
class FollowScreen extends StatefulWidget {
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen>  with TickerProviderStateMixin{
double _height = 0 , _width = 0;
NavigationProvider _navigationProvider;
AnimationController _animationController;
final _formKey = GlobalKey<FormState>();
HomeProvider _homeProvider = HomeProvider();
String _userName ='';
bool _initialRun = true;
Future<List<Ad>> _followList;
Future<List<User>> _followList2;
AuthProvider _authProvider ;
ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);


    super.initState();
  }


@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_initialRun) {
    _homeProvider = Provider.of<HomeProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);

    _followList = _homeProvider.getFollowlist();
    _followList2 = _homeProvider.getFollowlist2();

    _initialRun = false;
  }
}

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[

      SizedBox(
        height: 80,
      ),
      Text("متابعة الاعلانات"),
      SizedBox(
        height: 15,
      ),

      Container(
          height: _height*.40,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<Ad>>(
              future: _followList,
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
                      return NoData(message: "لا يوجد نتائج",);
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var count = snapshot.data.length;
                              var animation = Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              _animationController.forward();
                              return Container(
                                  height: _height*.10,
                                  width: _width,
                                  child: ListTile(
                                    title:  InkWell(
                                        onTap: () {
                                          _homeProvider.setCurrentAds(snapshot
                                              .data[index].adsId);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdDetailsScreen(
                                                        ad: snapshot
                                                            .data[index],
                                                      )));
                                        },
                                        child: MyFollowItem(
                                          animationController:
                                          _animationController,
                                          animation: animation,
                                          ad: snapshot.data[index],
                                        )),

                                    trailing:   GestureDetector(
                                      child: Icon(Icons.delete,color: Colors.red,),
                                      onTap: () async{



                                        final results = await _apiProvider
                                            .post("https://nl-arabmarkt.com/api/delete_follow" +
                                            "?api_lang=${_authProvider.currentLang}", body: {
                                          "user_id": _authProvider.currentUser.userId,
                                          "ads_id":snapshot
                                              .data[index].adsId,
                                        });


                                        if (results['response'] == "1") {
                                          Commons.showToast(context, message: results["message"]);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => FollowScreen()));
                                        } else {
                                          Commons.showError(context, results["message"]);
                                        }




                                      },
                                    ),
                                  )
                              );
                            });
                      } else {
                        return NoData(message: 'لاتوجد نتائج');
                      }
                    }
                }
                return Center(
                  child: SpinKitFadingCircle(color: mainAppColor),
                );
              })),







      Container(height: 1,color: mainAppColor,),
      SizedBox(
        height: 15,
      ),

      Text("متابعة الاعضاء"),
      SizedBox(
        height: 15,
      ),

      Container(
          height: _height*.40,
          color: Colors.white,
          
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<User>>(
              future: _followList2,
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
                      return NoData(message: "لا يوجد نتائج",);
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var count = snapshot.data.length;
                              var animation = Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              _animationController.forward();
                              return Container(
                                  height: _height*.10,
                                  width: _width,
                                  child:  ListTile(
                                    title: GestureDetector(
                                      onTap: (){
                                        _homeProvider.setCurrentSeller(snapshot.data[index].userId);
                                        _homeProvider.setCurrentSellerName(snapshot.data[index].userName);
                                        _homeProvider.setCurrentSellerPhone(snapshot.data[index].userPhone);
                                        _homeProvider.setCurrentSellerPhoto(snapshot.data[index].userPhoto);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SellerScreen
                                                  (
                                                  userId: snapshot.data[index].userId,

                                                )));

                                      },
                                      child: Text(
                                        snapshot.data[index].userName,
                                        style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      child: Icon(Icons.delete,color: Colors.red,),
                                      onTap: () async{



                                        final results = await _apiProvider
                                            .post("https://nl-arabmarkt.com/api/delete_follow2" +
                                            "?api_lang=${_authProvider.currentLang}", body: {
                                          "user_id": _authProvider.currentUser.userId,
                                          "user_id1":snapshot
                                              .data[index].userId,
                                        });


                                        if (results['response'] == "1") {
                                          Commons.showToast(context, message: results["message"]);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => FollowScreen()));
                                        } else {
                                          Commons.showError(context, results["message"]);
                                        }




                                      },
                                    ),
                                  ));
                            });
                      } else {
                        return NoData(message: 'لاتوجد نتائج');
                      }
                    }
                }
                return Center(
                  child: SpinKitFadingCircle(color: mainAppColor),
                );
              })),




    ],
  );
}




@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);
    return PageContainer(
      child: Scaffold(

          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
          Container(
              height: 60,

              color: Colors.white,

              child: Row(
                children: <Widget>[


                  Spacer(
                    flex: 3,
                  ),


                  Text(_homeProvider.currentLang=="ar"?"المتابعة":"Follow",
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 3,
                  ),


                  IconButton(
                    icon: Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return Icon(Icons.arrow_forward,color: Colors.black,);
                      },
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
        ],
      )),
    );
  }
}