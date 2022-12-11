

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/favourite_provider.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/favourite/favourite_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';

class SellerItem extends StatefulWidget {

  final AnimationController animationController;
  final Animation animation;
  final bool insideFavScreen;
  final User user;

  const SellerItem({Key key, this.insideFavScreen = false, this.user, this.animationController, this.animation}) : super(key: key);
  @override
  _SellerItemState createState() => _SellerItemState();
}

class _SellerItemState extends State<SellerItem> {
  double _height = 0 ,_width = 0;
  bool _initialRun = true;
  AuthProvider _authProvider;
  FavouriteProvider _favouriteProvider;
  ApiProvider _apiProvider = ApiProvider();

  String messageValue;
  String requesteValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);


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
                          Row(
                            children: <Widget>[
                              Container(


                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(widget.user.userPhoto ,height: constraints.maxHeight*.90,
                                      width: constraints.maxWidth *0.3,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: constraints.maxHeight *0.04,
                                          horizontal: constraints.maxWidth *0.02
                                      ),
                                      width: constraints.maxWidth *0.62,

                                      child:  Text(widget.user.userName,style: TextStyle(
                                          color: Color(0xff515C6F),fontSize: 19,fontWeight: FontWeight.bold,

                                          height: 1.4
                                      ),
                                        maxLines: 1,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 2,
                                    ),





                                    Container(
                                      width: constraints.maxWidth *0.58,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: constraints.maxWidth *0.01
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          _buildItem(widget.user.userCatName!=null?widget.user.userCatName:"", 'assets/images/city.png'),
                                          _buildItem(widget.user.userSubName!=null?widget.user.userSubName:"", 'assets/images/city.png'),



                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Row(

                                        children: <Widget>[
                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              child: Text("مراسلة",style: TextStyle(color: mainAppColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                              width: _width*.25,
                                              alignment: Alignment.center,
                                            ),
                                            onTap: (){

                                              if(_authProvider.currentUser!=null){

                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,

                                                    builder: (context) {

                                                      return SingleChildScrollView(
                                                        child: Container(
                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[

                                                              Padding(padding: EdgeInsets.all(15)),
                                                              Container(

                                                                child: Text("رسالة خاصة",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                                              ),
                                                              Padding(padding: EdgeInsets.all(15)),
                                                              Container(

                                                                child: CustomTextFormField(
                                                                  maxLines: 4,
                                                                  hintTxt: "محتوى الرسالة",

                                                                  onChangedFunc: (text) async{
                                                                    messageValue = text;
                                                                  },
                                                                ),

                                                              ),

                                                              CustomButton(
                                                                btnColor: mainAppColor,
                                                                btnLbl:"ارسال",
                                                                onPressedFunction: () async{

                                                                  if(messageValue!=null) {

                                                                    final results = await _apiProvider
                                                                        .post(Urls.SEND_URL , body: {
                                                                      "message_sender": _authProvider.currentUser.userId,
                                                                      "message_recever": widget.user.userId,
                                                                      "message_title": "رسالة خاصة",
                                                                      "message_content": messageValue,
                                                                      "message_type": "1",
                                                                    });


                                                                    if (results['response'] == "1") {
                                                                      Commons.showToast(context, message: results["message"]);
                                                                      Navigator.pop(context);
                                                                    } else {
                                                                      Commons.showError(context, results["message"]);
                                                                    }

                                                                  }else{
                                                                    Commons.showError(context, "يجب ادخال الرسالة");
                                                                  }

                                                                },
                                                              ),

                                                              Padding(padding: EdgeInsets.all(10)),




                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });

                                              }else{
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              }


                                            },
                                          ),


                                           Spacer(flex: 1,),

                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              child: Text("طلب خاص",style: TextStyle(color: mainAppColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                              width: _width*.25,
                                              alignment: Alignment.center,
                                            ),
                                            onTap: (){

                                              if(_authProvider.currentUser!=null){

                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,

                                                    builder: (context) {

                                                      return SingleChildScrollView(
                                                        child: Container(
                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[

                                                              Padding(padding: EdgeInsets.all(15)),
                                                              Container(

                                                                child: Text("طلب خاص",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                                              ),
                                                              Padding(padding: EdgeInsets.all(15)),
                                                              Container(

                                                                child: CustomTextFormField(
                                                                  maxLines: 4,
                                                                  hintTxt: "محتوى الطلب",

                                                                  onChangedFunc: (text) async{
                                                                    messageValue = text;
                                                                  },
                                                                ),

                                                              ),



                                                              CustomButton(
                                                                btnColor: mainAppColor,
                                                                btnLbl:"ارسال",
                                                                onPressedFunction: () async{

                                                                  if(messageValue!=null) {

                                                                    final results = await _apiProvider
                                                                        .post(Urls.SEND_URL , body: {
                                                                      "message_sender": _authProvider.currentUser.userId,
                                                                      "message_recever": widget.user.userId,
                                                                      "message_title": "طلب خاص",
                                                                      "message_content": messageValue,
                                                                      "message_type": "2",
                                                                    });


                                                                    if (results['response'] == "1") {
                                                                      Commons.showToast(context, message: results["message"]);
                                                                      Navigator.pop(context);
                                                                    } else {
                                                                      Commons.showError(context, results["message"]);
                                                                    }

                                                                  }else{
                                                                    Commons.showError(context, "يجب ادخال الطلب");
                                                                  }

                                                                },
                                                              ),

                                                              Padding(padding: EdgeInsets.all(10)),




                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });

                                              }else{
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              }


                                            },
                                          )
                                        ],
                                      ),
                                    )


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



