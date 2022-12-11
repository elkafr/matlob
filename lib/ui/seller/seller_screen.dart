import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/seller_ads_provider.dart';
import 'package:matlob/ui/ad_details/ad_details_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/error.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/utils/commons.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:matlob/providers/auth_provider.dart';



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


class SellerScreen extends StatefulWidget {
  final String userId;

  const SellerScreen({Key key, this.userId}) : super(key: key);
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class FruitsList {
  String name;
  int index;
  FruitsList({this.name, this.index});
}

class _SellerScreenState extends State<SellerScreen> with TickerProviderStateMixin{
double _height = 0 , _width = 0;
HomeProvider _homeProvider;
ApiProvider _apiProvider = ApiProvider();
AnimationController _animationController;
AuthProvider _authProvider ;

bool checkedValue=false;
bool checkedValue1=false;



String messageValue;
String requesteValue;

// Default Radio Button Item
  String radioItem = 'نعم';

  // Group Value for Radio Button.
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "نعم",
    ),
    FruitsList(
      index: 0,
      name: "لا",
    ),
  ];

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


Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[
         SizedBox(
            height: 80,
          ),

      Container(
        alignment: Alignment.center,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: accentColor,
              backgroundImage: NetworkImage(_homeProvider.currentSellerPhoto),
              maxRadius: 40,
            ),


          ],
        ),
      ),




          Container(
          alignment: Alignment.center,
            child: Text(" رقم العضوية :- "+ _homeProvider.currentSeller,style: TextStyle(color: Colors.black),),
          ),
Padding(padding: EdgeInsets.all(2)),
      Container(
        alignment: Alignment.center,
        child: Text(" الاسم:- "+ _homeProvider.currentSellerName,style: TextStyle(color: Colors.black),),
      ),
      Padding(padding: EdgeInsets.all(2)),
      Container(
        alignment: Alignment.center,
        child: Text(" الوظيفة:- "+ _homeProvider.currentSellerJob,style: TextStyle(color: Colors.black),),
      ),

      Padding(padding: EdgeInsets.all(2)),


      Container(
  height: 50,
  width: _width*.50,
  margin: EdgeInsets.symmetric(
  horizontal: _width * 0.20, vertical: _height * 0.01),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  border: Border.all(
  color: mainAppColor.withOpacity(0.9),
  ),
  ),



child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: <Widget>[
    Container(
      alignment: Alignment.center,
      child: Text(_homeProvider.currentSellerPhone,style: TextStyle(color: Colors.black),),
    ),

    GestureDetector(
      onTap: (){
        launch(
            "tel://${_homeProvider.currentSellerPhone}");
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
          child: Image.asset('assets/images/callnow.png')),
    )
  ],
),
  ),



   Container(
     margin: EdgeInsets.only(right: _width*.04,left: _width*.04),
     child:  Row(

       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: <Widget>[



         GestureDetector(
           child: Container(
             padding: EdgeInsets.all(7),
             color: mainAppColor,
             alignment: Alignment.center,
             child: Text(_homeProvider.currentLang=="ar"?"متابعة ":"Follow seller",style: TextStyle(color: Colors.white,fontSize: 17),),
           ),
           onTap: () async{
             if(_authProvider.currentUser!=null){


               final results = await _apiProvider
                   .post("https://nl-arabmarkt.com/api/follow2" , body: {
                 "follow_user": _authProvider.currentUser.userId,
                 "follow_user1": _homeProvider.currentSeller,
               });


               if (results['response'] == "1") {
                 Commons.showToast(context, message: results["message"]);
                 Navigator.pop(context);
               } else {
                 Commons.showError(context, results["message"]);
               }


             }else{
               Commons.showToast(context, message: "عفوا يجب عليك تسجيل الدخول اولا");
             }


           },
         ),


         Spacer(flex: 1,),

         GestureDetector(
           child: Container(
             padding: EdgeInsets.all(6),
             child: Text("مراسلة",style: TextStyle(color: Colors.white,fontSize: 17),),
             color: mainAppColor,
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
                                     "message_recever": _homeProvider.currentSeller,
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
             child: Text("طلب خاص",style: TextStyle(color: Colors.white,fontSize: 17),),
             color: mainAppColor,
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
                                     "message_recever": _homeProvider.currentSeller,
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
   ),



    Container(
      margin: EdgeInsets.all(_width*.04),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          (_homeProvider.omarKey=="1")?GestureDetector(
            child: CustomButton(
              btnLbl: _homeProvider.currentLang=="ar"?"الابلاغ عن المعلن":"Report the advertiser",
              btnColor: mainAppColor,
              onPressedFunction: () async{

                final results = await _apiProvider
                    .post("https://matloobservices.com/api/report9999" +
                    "?api_lang=${_authProvider.currentLang}", body: {
                  // "report_user": _authProvider.currentUser.userId,
                  "report_gid": "1",
                  //"report_value": reportValue,
                });


                if (results['response'] == "1") {
                  Commons.showToast(context, message: results["message"]);
                  //  Navigator.pop(context);
                } else {
                  Commons.showError(context, results["message"]);
                }

              },
            ),
          ):Text(" ",style: TextStyle(height: 0),),


          (_homeProvider.omarKey == "1")
              ? GestureDetector(
            child: CustomButton(
              btnLbl: _homeProvider.currentLang == "ar"
                  ? "اخفاء المحتوى من هذا المعلن"
                  : "Hide content from this advertiser",
              btnColor: mainAppColor,
              onPressedFunction: () async {
                final results = await _apiProvider.post(
                    "https://matloobservices.com/api/report999" +
                        "?api_lang=${_authProvider.currentLang}",
                    body: {
                      // "report_user": _authProvider.currentUser.userId,
                      "report_gid": _homeProvider.currentSeller,
                      //"report_value": reportValue,
                    });

                if (results['response'] == "1") {
                  Commons.showToast(context,
                      message: results["message"]);
                  Navigator.pop(context);
                } else {
                  Commons.showError(
                      context, results["message"]);
                }
              },
            ),
          )
              : Text(
            " ",
            style: TextStyle(height: 0),
          ),




          (_homeProvider.omarKey == "1")
              ? GestureDetector(
            child: CustomButton(
              btnLbl: _homeProvider.currentLang == "ar"
                  ? "حظر هذا المعلن"
                  : "Ban this advertiser",
              btnColor: mainAppColor,
              onPressedFunction: () async {
                final results = await _apiProvider.post(
                    "https://matloobservices.com/api/report999" +
                        "?api_lang=${_authProvider.currentLang}",
                    body: {
                      // "report_user": _authProvider.currentUser.userId,
                      "report_gid": _homeProvider.currentSeller,
                      //"report_value": reportValue,
                    });

                if (results['response'] == "1") {
                  Commons.showToast(context,
                      message: results["message"]);
                  Navigator.pop(context);
                } else {
                  Commons.showError(
                      context, results["message"]);
                }
              },
            ),
          )
              : Text(
            " ",
            style: TextStyle(height: 0),
          ),



          Text("نبذة تسويقية",style: TextStyle(color: omarColor,fontWeight: FontWeight.bold),),
          Padding(padding: EdgeInsets.all(3)),
          Text(_homeProvider.currentSellerWasf,style: TextStyle(color: omarColor),)
        ],
      ),
    ),



    Container(
      height: 20,
    ),








              Container(
          height: _height - (_height*.4),
          width: _width,
          child: DefaultTabController(
  length: 2,
  child: Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
  Container(
  child: TabBar(tabs: [
  Tab(child: Container(
    child: Text("الطلبات",style: TextStyle(fontSize: 16),),
    color: mainAppColor,
    padding: EdgeInsets.all(4),
    width: _width,
    alignment: Alignment.center,
  ),),
    Tab(child: Container(
      child: Text("العروض",style: TextStyle(fontSize: 16),),
      color: mainAppColor,
      padding: EdgeInsets.all(4),
      width: _width,
      alignment: Alignment.center,
    ),),
  ]),
  ),
  Container(
  //Add this to give height
  height: MediaQuery.of(context).size.height,
  child: TabBarView(children: [
  Container(
  child: FutureBuilder<List<Ad>>(
      future:  Provider.of<SellerAdsProvider>(context,
          listen: false)
          .getAdsList(widget.userId) ,
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
                errorMessage: snapshot.error.toString(),
                // errorMessage: "حدث خطأ ما ",
              );
            } else {
              if (snapshot.data.length > 0) {
                return     ListView.builder(
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
                          height: _height*.20,
                          width: _width,
                          child: InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdDetailsScreen(
                                          ad: snapshot.data[index],


                                        )));
                              },
                              child: AdItem(
                                animationController: _animationController,
                                animation: animation,
                                ad: snapshot.data[index],
                              )));
                    }
                );
              } else {
                return NoData(message: AppLocalizations.of(context).translate('no_results'));
              }
            }
        }
        return Center(
          child: SpinKitFadingCircle(color: mainAppColor),
        );
      }),
  ),
    Container(
      child: FutureBuilder<List<Ad>>(
          future:  Provider.of<SellerAdsProvider>(context,
              listen: false)
              .getAdsList1(widget.userId) ,
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
                    errorMessage: snapshot.error.toString(),
                    // errorMessage: "حدث خطأ ما ",
                  );
                } else {
                  if (snapshot.data.length > 0) {
                    return     ListView.builder(
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
                              height: _height*.20,
                              width: _width,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdDetailsScreen(
                                              ad: snapshot.data[index],


                                            )));
                                  },
                                  child: AdItem(
                                    animationController: _animationController,
                                    animation: animation,
                                    ad: snapshot.data[index],
                                  )));
                        }
                    );
                  } else {
                    return NoData(message: AppLocalizations.of(context).translate('no_results'));
                  }
                }
            }
            return Center(
              child: SpinKitFadingCircle(color: mainAppColor),
            );
          }),
    ),


  ]),
  ),
  ],
  ),
  ),
        )
    ],
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _homeProvider = Provider.of<HomeProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
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
                  Text(_homeProvider.currentLang=='ar'?"صاحب الاعلان":"Ads owner",
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 2,
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