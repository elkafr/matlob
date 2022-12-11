import 'package:matlob/custom_widgets/ad_item/ad_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/my_ads_provider.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/ui/my_ads/widgets/my_ad_item.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/error.dart';
import 'package:matlob/ui/add_ad/widgets/add_ad_bottom_sheet.dart';
import 'package:matlob/ui/ad_details/ad_details_screen.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:matlob/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/utils/urls.dart';
import 'package:matlob/utils/commons.dart';

import 'dart:math' as math;
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>  with TickerProviderStateMixin{
  double _height = 0 , _width = 0;
  NavigationProvider _navigationProvider;
  AnimationController _animationController;
  HomeProvider _homeProvider;

  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider ;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    final orientation = MediaQuery.of(context).orientation;
    return ListView(
      children: <Widget>[
        Container(height: 20,),


        Container(
          color: Color(0xffFBFBFB),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[




              Container(

                child: SingleChildScrollView(

                  child: Column(

                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(15,5,15,10),
                          height: _height,
                          width: _width,
                          child:
                          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
                            return FutureBuilder<List<Ad>>(
                                future: Provider.of<HomeProvider>(context, listen: true)
                                    .getAdsSearchList(),
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
                                          errorMessage: "حدث خطأ ما ",
                                        );
                                      } else {
                                        if (snapshot.data.length > 0) {

                                          return ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                var count = snapshot.data.length;
                                                var animation =
                                                Tween(begin: 0.0, end: 1.0).animate(
                                                  CurvedAnimation(
                                                    parent: _animationController,
                                                    curve: Interval(
                                                        (1 / count) * index, 1.0,
                                                        curve: Curves.fastOutSlowIn),
                                                  ),
                                                );
                                                _animationController.forward();
                                                return Container(
                                                    height: 145,
                                                    width: _width,
                                                    child: InkWell(
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
                                                        child: AdItem(
                                                          animationController:
                                                          _animationController,
                                                          animation: animation,
                                                          ad: snapshot.data[index],
                                                        )));
                                              });

                                        } else {
                                          return NoData(message: 'لاتوجد نتائج');
                                        }
                                      }
                                  }
                                  return Center(
                                    child: SpinKitFadingCircle(color: mainAppColor),
                                  );
                                });
                          }))

                    ],
                  ),
                ),
              ),


            ],
          ),
        )



      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,

      title:Text("نتيجة البحث",style: TextStyle(fontSize: 15,color: omarColor),),
      actions: <Widget>[


        IconButton(
            icon: Consumer<AuthProvider>(
              builder: (context,authProvider,child){
                return authProvider.currentLang == 'ar' ? Image.asset(
                  'assets/images/left.png',
                  color: omarColor,
                ): Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child:  Image.asset(
                      'assets/images/left.png',
                      color: omarColor,
                    ));
              },
            ),
            onPressed: () {

              _homeProvider.setEnableSearch(false);
              _homeProvider.setSearchKey(null);
              _homeProvider.setPriceFrom(null);
              _homeProvider.setPriceTo(null);

              _homeProvider.setSelectedSub(null);
              _homeProvider.setSelectedCity(null);


              _navigationProvider.upadateNavigationIndex(0);
              Navigator.pushReplacementNamed(context,  '/navigation');
            }


        )



      ],
    );




    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);

    return PageContainer(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,

        body: _buildBodyItem(),
      ),
    );
  }
}