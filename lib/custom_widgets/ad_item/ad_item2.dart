

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/favourite_provider.dart';
import 'package:matlob/ui/favourite/favourite_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';

class AdItem2 extends StatefulWidget {
  
  final AnimationController animationController;
  final Animation animation;
  final bool insideFavScreen;
  final Ad ad;

  const AdItem2({Key key, this.insideFavScreen = false, this.ad, this.animationController, this.animation}) : super(key: key);
  @override
  _AdItem2State createState() => _AdItem2State();
}

class _AdItem2State extends State<AdItem2> {
double _height = 0 ,_width = 0;
  bool _initialRun = true;
  AuthProvider _authProvider;
  FavouriteProvider _favouriteProvider;
  ApiProvider _apiProvider = ApiProvider();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
      _favouriteProvider = Provider.of<FavouriteProvider>(context);

      if (widget.ad.adsIsFavorite == 1 && _authProvider.currentUser != null) {
        _favouriteProvider.addItemToFavouriteAdsList(
            widget.ad.adsId, widget.ad.adsIsFavorite);
      }
      print('favourite' + widget.ad.adsIsFavorite.toString());
      _initialRun = false;
    }
  }

  Widget _buildItem(String title,String imgPath){
    return Row(
      children: <Widget>[
   Image.asset(imgPath,color: mainAppColor,
   height: _height *0.15,
   width: 20,
   ),
Consumer<AuthProvider>(
  builder: (context,authProvider,child){
    return  Container(
  margin: EdgeInsets.only(left: authProvider.currentLang == 'ar' ? 0 : 2,right:  authProvider.currentLang == 'ar' ? 2 : 0 ),
  child:   Text(title,style: TextStyle(
     fontSize: title.length >1 ?14 : 14,color: omarColor
   ),
   overflow: TextOverflow.ellipsis,
   ));
  }
)
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return   AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child:LayoutBuilder(builder: (context, constraints) {
      _height =  constraints.maxHeight;
      _width = constraints.maxWidth;
      return Container(

        margin: EdgeInsets.only(left: constraints.maxWidth *0.04,
        right: constraints.maxWidth *0.04,bottom: constraints.maxHeight *0.1),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:hintColor.withOpacity(0.4), width: 1)),

           color: Colors.white,

        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
               Container(

                 
                 child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
    child: Image.network(widget.ad.adsPhoto ,height: constraints.maxHeight*.60,
                  width: constraints.maxWidth,
                   fit: BoxFit.fill,
                  )),
               ),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: Column(
               
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                     Container(
                         alignment: Alignment.center,
                       width: constraints.maxWidth,
                       
                       child:  Text(widget.ad.adsTitle,style: TextStyle(
                         color: Color(0xff515C6F),fontSize: 16,fontWeight: FontWeight.bold,

                         height: 1.4
                       ),
                       maxLines: 1,
                       ),
                     ),







                    ],
                  ),
                )
                ],
            ),

          /*  Positioned(
              top: constraints.maxHeight *0.02,
             
              child: Container(
                height: _height *0.25,
                width: _width *0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,

                ),
                child: _authProvider.currentUser == null
                        ? GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/login_screen'),
                            child: Center(
                                child: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.white,
                            )),
                          )
                        : Consumer<FavouriteProvider>(
                            builder: (context, favouriteProvider, child) {
                            return GestureDetector(
                              onTap: () async {
                                if (favouriteProvider.favouriteAdsList
                                    .containsKey(widget.ad.adsId)) {
                                  favouriteProvider.removeFromFavouriteAdsList(
                                      widget.ad.adsId);
                                  await _apiProvider.get(Urls
                                          .REMOVE_AD_from_FAV_URL +
                                      "ads_id=${widget.ad.adsId}&user_id=${_authProvider.currentUser.userId}");
                                  if (widget.insideFavScreen) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FavouriteScreen()));
                                  }
                                } else {
                                  print(
                                      'user id ${_authProvider.currentUser.userId}');
                                  print('ad id ${widget.ad.adsId}');
                                  favouriteProvider.addToFavouriteAdsList(
                                      widget.ad.adsId, 1);
                                  await _apiProvider
                                      .post(Urls.ADD_AD_TO_FAV_URL, body: {
                                    "user_id": _authProvider.currentUser.userId,
                                    "ads_id": widget.ad.adsId
                                  });
                                }
                              },
                              child: Center(
                                child: favouriteProvider.favouriteAdsList
                                        .containsKey(widget.ad.adsId)
                                    ? SpinKitPumpingHeart(
                                        color: accentColor,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                              ),
                            );
                          })
                         
              ) ,
            )
            */





          ],
        ),
      );
    })));
    });
  }
}
