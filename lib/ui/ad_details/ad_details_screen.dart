import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matlob/models/ad_details.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/ad_details_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/favourite_provider.dart';
import 'package:matlob/ui/chat/chat_screen.dart';
import 'package:matlob/ui/seller/seller_screen.dart';
import 'package:matlob/ui/section_ads/section_ads_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/error.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:matlob/ui/ad_details/widgets/slider_images.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/ui/comments/comment_bottom_sheet.dart';
import 'package:matlob/ui/comment/comment_screen.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/MainDrawer.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';


import 'package:matlob/models/comments.dart';
import 'package:matlob/providers/comment_provider.dart';

class AdDetailsScreen extends StatefulWidget {
  final Ad ad;

  const AdDetailsScreen({Key key, this.ad}) : super(key: key);
  @override
  _AdDetailsScreenState createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen>  with TickerProviderStateMixin {
  double _height = 0, _width = 0;
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;



  HomeProvider _homeProvider;
  String reportValue;
  AnimationController _animationController;
  String messageValue;
  String messageValue1;
  FocusNode _focusNode;

  @override
  void initState() {


    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    super.initState();
    _focusNode = FocusNode();
  }



  Widget _buildRow(
      {@required String imgPath,
      @required String value1,
      @required String title,
      @required String value}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1)),
      ),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: <Widget>[



          Text(
            value1,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          Spacer(),

          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title,
                style: TextStyle(color: omarColor, fontSize: 14),
              )),
          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }






  Widget _buildRow1(
      {@required String imgPath,
        @required String title,
        @required String value}) {
    return Container(

      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: <Widget>[
          /* Image.asset(
          imgPath,
          color: Color(0xffC5C5C5),
          height: 15,
          width: 15,
        ), */
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title+" : ",
                style: TextStyle(color: omarColor, fontSize: 15),
              )),

          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)), //this right here
          child: Container(
            child: new Wrap(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(_homeProvider.currentLang == "ar"
                      ? "ارسال بلاغ :-"
                      : "Send report :-"),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: CustomTextFormField(
                    hintTxt: _homeProvider.currentLang == "ar"
                        ? "سبب البلاغ"
                        : "Report reason",
                    onChangedFunc: (text) async {
                      reportValue = text;
                    },
                  ),
                ),
                CustomButton(
                  btnColor: mainAppColor,
                  btnLbl: _homeProvider.currentLang == "ar" ? "ارسال" : "Send",
                  onPressedFunction: () async {
                    if (reportValue != null) {
                      final results = await _apiProvider.post(
                          Urls.REPORT_AD_URL +
                              "?api_lang=${_authProvider.currentLang}",
                          body: {
                            "report_user": _authProvider.currentUser.userId,
                            "report_gid": widget.ad.adsId,
                            "report_value": reportValue,
                          });

                      if (results['response'] == "1") {
                        Commons.showToast(context, message: results["message"]);
                        Navigator.pop(context);
                      } else {
                        Commons.showError(context, results["message"]);
                      }
                    } else {
                      Commons.showError(context, "يجب ادخال سبب البلاغ");
                    }
                  },
                ),
                Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ),
        );


      },
    );


  }

  Widget _buildBodyItem() {
    return FutureBuilder<AdDetails>(
        future: Provider.of<AdDetailsProvider>(context, listen: false)
            .getAdDetails(widget.ad.adsId),
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
                List comments = snapshot.data.adsComments;
                // List related= snapshot.data.adsRelated;
                //var initalLocation = snapshot.data.adsLocation.
                //split(',');
                // LatLng pinPosition = LatLng(double.parse(initalLocation[0]), double.parse(initalLocation[1]));

                // these are the minimum required values to set
                // the camera position
                // CameraPosition initialLocation = CameraPosition(
                //  zoom: 15,
                //  bearing: 30,
                //  target: pinPosition
                //  );

                return ListView(
                  children: <Widget>[
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
                                      "report_gid": widget.ad.adsId,
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






        
                    Container(
                      margin: EdgeInsets.only(right: _width*.04,left: _width*.04),
                      child: Text(widget.ad.adsTitle,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff303030)),),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      height: _height*.60,
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      decoration: BoxDecoration(

                        color:  Color(0xffF2F2F2),

                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04),
                              child: _buildRow(
                                  imgPath: 'assets/images/edit.png',
                                  value1: snapshot.data.adsDate,
                                  title: AppLocalizations.of(context)
                                      .translate('ad_no'),
                                  value: snapshot.data.adsId)
                          ),


                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04,
                                  vertical: _height * 0.001),
                              child: _buildRow(
                                  imgPath: 'assets/images/city.png',
                                  value1: snapshot.data.adsUserName,
                                  title: AppLocalizations.of(context)
                                      .translate('city'),
                                  value: snapshot.data.adsCityName)),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04,
                                  vertical: _height * 0.001),
                              child: _buildRow(
                                  imgPath: 'assets/images/view.png',
                                  value1: snapshot.data.adsCatName,
                                  title:"السعر",
                                  value: snapshot.data.adsPrice)),
                          SizedBox(height: _width*.02,),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(
                              horizontal: _width * 0.04,
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('ad_description'),
                              style: TextStyle(
                                  color: Color(0xff4C4C4C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: _width*.02,),

                          Expanded(child: Container(

                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(
                              horizontal: _width * 0.04,
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                widget.ad.adsDetails,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,

                                ),
                              ),
                            ),
                          )),

                        ],
                      ),
                    ),


                 SizedBox(height: 10,),


                    snapshot.data.photos.length == 1
                        ? Container(
                      height: 255,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    child: GestureZoomBox(
                                      maxScale: 5.0,
                                      doubleTapScale: 2.0,
                                      duration:
                                      Duration(milliseconds: 200),
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Image.network(
                                        snapshot.data.adsMainPhoto,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ClipRRect(
                          child: Image.network(
                            snapshot.data.adsMainPhoto,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    )
                        :  snapshot.data.photos.length == 0?Container(
                      height: _height*.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04,
                          vertical: _height * 0.01),
                      child: Text(""),
                    ):Container(
                      height: _height*.50,
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04,
                          vertical: _height * 0.01),
                      child: SliderImages(),
                    ),






                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04, vertical: _height * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "عدد المشاهدات",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                widget.ad.adsVisits,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                _authProvider.currentLang != 'ar' ? 5 : 0,
                                left: _authProvider.currentLang == 'ar' ? 5 : 0,
                              ),
                              height: _height * 0.04,
                              width: _width * 0.07,
                              decoration: BoxDecoration(
                                  color: mainAppColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  border: Border.all(
                                    width: 1.5,
                                    color: mainAppColor,
                                  )),
                              child: _authProvider.currentUser == null
                                  ? GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/login_screen'),
                                child: Center(
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 22,
                                      color: Colors.white,
                                    )),
                              )
                                  : Consumer<FavouriteProvider>(builder:
                                  (context, favouriteProvider, child) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (favouriteProvider.favouriteAdsList
                                        .containsKey(
                                        snapshot.data.adsId)) {
                                      favouriteProvider
                                          .removeFromFavouriteAdsList(
                                          snapshot.data.adsId);
                                      await _apiProvider.get(Urls
                                          .REMOVE_AD_from_FAV_URL +
                                          "ads_id=${snapshot.data.adsId}&user_id=${_authProvider.currentUser.userId}");
                                    } else {
                                      favouriteProvider
                                          .addToFavouriteAdsList(
                                          snapshot.data.adsId, 1);
                                      await _apiProvider.post(
                                          Urls.ADD_AD_TO_FAV_URL,
                                          body: {
                                            "user_id": _authProvider
                                                .currentUser.userId,
                                            "ads_id": snapshot.data.adsId
                                          });
                                    }
                                  },
                                  child: Center(
                                    child: favouriteProvider
                                        .favouriteAdsList
                                        .containsKey(
                                        snapshot.data.adsId)
                                        ? SpinKitPumpingHeart(
                                      color: accentColor,
                                      size: 22,
                                    )
                                        : Icon(
                                      Icons.favorite_border,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              })),

                          Padding(padding: EdgeInsets.all(4)),

                          Container(
                              margin: EdgeInsets.only(
                                right:
                                _authProvider.currentLang != 'ar' ? 5 : 0,
                                left: _authProvider.currentLang == 'ar' ? 5 : 0,
                              ),
                              height: _height * 0.04,
                              width: _width * 0.07,
                              decoration: BoxDecoration(
                                  color: Color(0xff303030),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  border: Border.all(
                                    width: 1.5,
                                    color:  Color(0xff303030),
                                  )),
                              child: GestureDetector(
                                onTap: () {
                                  Share.share("https://matloobservices.com/site/show/" + widget.ad.adsId,
                                    subject: widget.ad.adsDetails,

                                  );
                                },
                                child: Icon(FontAwesomeIcons.shareAlt,color: Colors.white,size: 22,),
                              )),

                          Padding(padding: EdgeInsets.all(4)),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                _authProvider.currentLang != 'ar' ? 5 : 0,
                                left: _authProvider.currentLang == 'ar' ? 5 : 0,
                              ),
                              height: _height * 0.04,
                              width: _width * 0.07,
                              decoration: BoxDecoration(
                                  color: Color(0xff303030),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  border: Border.all(
                                    width: 1.5,
                                    color:  Color(0xff303030),
                                  )),
                              child: GestureDetector(
                                onTap: () {
                                  launch(
                                    //  "https://wa.me/${snapshot.data.adsWhatsapp}");
                                      "https://api.whatsapp.com/send?text=https://matloobservices.com/site/show/${widget.ad.adsId}");
                                },
                                child: Icon(FontAwesomeIcons.whatsapp,color: Colors.white,size: 22,),
                              ))
                        ],
                      ),
                    ),


                    SizedBox(height: _width*.03,),

                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child: Text(
                        _homeProvider.currentLang=="ar"?" التعليقات":"ٍShow comments",
                        style: TextStyle(
                            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: _width*.02,),
                    Container(

                      height: 250,
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child: FutureBuilder<List<Comments>>(
                          future: Provider.of<CommentProvider>(context, listen: false)
                              .getCommentsList(_homeProvider.currentAds),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return NoData(
                                    message:
                                    _homeProvider.currentLang=="ar"?"لا يوجد تعليقات":"No comments found",
                                  );
                                } else {
                                  if (snapshot.data.length > 0) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Container(

                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              border: Border.all(
                                                color: hintColor.withOpacity(0.4),
                                              ),
                                              color: snapshot.data[index].commentBy==widget.ad.adsUserName?Colors.yellow.withOpacity(0.3):Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.4),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                            width: _width,
                                            height: _height * 0.13,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(snapshot.data[index].commentBy,style: TextStyle(fontSize: 14,color: Colors.grey[900])),
                                                    Padding(padding: EdgeInsets.all(2)),
                                                    Container(
                                                      width: 300,
                                                      child: Text(snapshot.data[index].commentDetails,style: TextStyle(fontSize: 16,color: mainAppColor,),maxLines: 2,),
                                                    ),
                                                    Text(snapshot.data[index].commentDate,style: TextStyle(fontSize: 14,color: Colors.grey[900])),
                                                  ],
                                                )


                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    return NoData(
                                      message:
                                      AppLocalizations.of(context).translate('no_msgs'),
                                    );
                                  }
                                }
                            }
                            return SpinKitFadingCircle(color: mainAppColor);
                          }),
                    ),

                    SizedBox(height: _width*.01,),


                    Container(
                        height: 60,


                        child: CustomButton(
                          btnLbl: "اضف تعليق",
                          onPressedFunction: (){






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

                                              child: Text(_homeProvider.currentLang=="ar"?"اكتب تعليقك هنا ...":"Add your comment here ...",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                            ),
                                            Padding(padding: EdgeInsets.all(15)),
                                            Container(

                                              child: CustomTextFormField(
                                                maxLines: 4,
                                                hintTxt: "محتوى التعليق",

                                                onChangedFunc: (text) async{
                                                  messageValue1 = text;
                                                },
                                              ),

                                            ),

                                            CustomButton(
                                              btnColor: mainAppColor,
                                              btnLbl:"ارسال",
                                              onPressedFunction: () async{

                                                if(messageValue1!=null) {

                                                  final results = await _apiProvider
                                                      .post(Urls.ADD_COMMENT , body: {
                                                    "ads_id": widget.ad.adsId,
                                                    "comment_details":messageValue1.toString(),
                                                    "user_id": _authProvider.currentUser.userId,


                                                  });


                                                  if (results['response'] == "1") {
                                                    Commons.showToast(context, message: results["message"] );
                                                    Navigator.pop(context);
                                                    setState(() {

                                                    });

                                                  } else {
                                                    Commons.showError(context, results["message"]);

                                                  }

                                                }else{
                                                  Commons.showError(context, "يجب ادخال التعليق");
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
                        )),

                     SizedBox(height: _width*.01,),































































































































































                    Container(
                      height: _height * 0.1,
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04, vertical: _height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: hintColor.withOpacity(0.4),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: _width * 0.025),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: _height * 0.035,
                              backgroundImage:
                                  NetworkImage(snapshot.data.adsUserPhoto),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _homeProvider
                                  .setCurrentSeller(snapshot.data.adsUser);
                              _homeProvider.setCurrentSellerName(
                                  snapshot.data.adsUserName);
                              _homeProvider.setCurrentSellerPhone(
                                  snapshot.data.adsUserPhone);
                              _homeProvider.setCurrentSellerPhoto(
                                  snapshot.data.adsUserPhoto);



                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SellerScreen(
                                            userId: snapshot.data.adsUser,
                                          )));
                            },
                            child: Text(
                              snapshot.data.adsUserName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              launch("tel://${snapshot.data.adsPhone}");
                            },
                            child: Text(snapshot.data.adsUserPhone),
                          ),
                          GestureDetector(
                            onTap: () {
                              launch("tel://${snapshot.data.adsUserPhone}");
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: _width * 0.025),
                                child:
                                    Image.asset('assets/images/phone1.png')),
                          ),
             
                        ],
                      ),
                    ),







                    Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 60,


                        child: CustomButton(
                          btnLbl: "راسل المعلن",
                          onPressedFunction: (){



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
                                                    "message_recever": widget.ad.adsUser,
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
                        )),



                     Row(
                       children: <Widget>[

                         GestureDetector(
                           child: Container(
                             decoration: BoxDecoration(
                               color: mainAppColor,
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                             ),
                             width: _width*.42,
                             alignment: Alignment.center,
                             margin: EdgeInsets.only(
                                 top: 10, bottom: 10, right: 15, left: 15),
                             height: 50,

                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Icon(Icons.favorite_border,color: Colors.white,),
                                 Padding(padding: EdgeInsets.all(3)),
                                 Text(_homeProvider.currentLang=="ar"?"متابعة الردود":"Report the content",
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 14
                                   ),
                                 )
                               ],
                             ),
                           ),
                           onTap: () async{
                             if(_authProvider.currentUser!=null){

                               final results = await _apiProvider
                                   .post("https://matloobservices.com/api/follow" , body: {
                                 "user_id": _authProvider.currentUser.userId,
                                 "ads_id": widget.ad.adsId,
                               });


                               if (results['response'] == "1") {
                                 Commons.showToast(context, message: results["message"]);
                                 Navigator.pop(context);
                               } else {
                                 Commons.showError(context, results["message"]);
                               }


                             }else{
                               Commons.showToast(context, message: "عفوا يجب عليك تسجيل الدخول اولا");

                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                           LoginScreen()));
                             }

                           },
                         ),
                         
                         
         
                         
                         GestureDetector(
                           child: Container(
                             width: _width*.42,
                             decoration: BoxDecoration(
                               color: accentColor,
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                             ),
                             alignment: Alignment.center,
                             margin: EdgeInsets.only(
                                 top: 10, bottom: 10, right: 15, left: 15),
                             height: 50,

                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset(
                                   'assets/images/about.png',
                                   color: Color(0xffE24848),
                                 ),
                                 Padding(padding: EdgeInsets.all(3)),
                                 Text(_homeProvider.currentLang=="ar"?"أبلغ عن المحتوي":"Report the content",
                                   style: TextStyle(
                                       color: Color(0xffE24848),
                                       fontSize: 14
                                   ),
                                 )
                               ],
                             ),
                           ),
                           onTap: () async{
                             _settingModalBottomSheet(context);
                           },
                         ),
                       ],
                     ),


                    SizedBox(
                      height: 5,
                    ),





                    SizedBox(
                      height: 30,
                    ),



                   /* Container(
                      child: GestureDetector(
                        child:
                        FutureBuilder<String>(
                            future: Provider.of<HomeProvider>(context,
                                listen: false)
                                .getPhoto2(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Center(
                                    child: Text(""),
                                  );
                                case ConnectionState.active:
                                  return Text('');
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Text(""),
                                  );
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return  Text("");
                                  } else {
                                    _homeProvider.setPhoto2(snapshot.data);
                                    print("sssssssssssss");
                                    print(_homeProvider.photo2);
                                    print("ssssssssssssssss");
                                    return  Image.network(snapshot.data);
                                  }
                              }
                              return Center(
                                child:  Text(""),
                              );
                            }),
                        onTap: (){

                          launch(_homeProvider.url1);
                        },
                      ),
                    ), */






                    Container(

                      padding: EdgeInsets.all(8),
                      alignment: _authProvider.currentLang == 'ar' ?Alignment.topRight:Alignment.topLeft,
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child:      Text(
                        _authProvider.currentLang == 'ar' ?"إعلانات مشابهة":"Similar ads",
                        style: TextStyle(
                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: _height*.20,
                      width: _width,
                      child: FutureBuilder<List<Ad>>(
                          future:  Provider.of<HomeProvider>(context,
                              listen: false)
                              .getAdsListRelated(widget.ad.adsId) ,
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
                                        scrollDirection: Axis.horizontal,
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

                                              width: _width*.48,

                                              child: InkWell(
                                                  onTap: (){

                                                    _homeProvider.setCurrentAds(snapshot.data[index].adsId);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => AdDetailsScreen(
                                                              ad: snapshot.data[index],


                                                            )));
                                                  },
                                                  child: AdItem2(
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
                      margin: EdgeInsets.only(right: _width*.02,left: _width*.02),
                      padding: EdgeInsets.all(7),

                      child: Row(
                        children: <Widget>[


                          Container(
                            height: 50,
                            width: _width*.40,
                            margin: EdgeInsets.all(_width*.02),
                            child: FutureBuilder<List<Ad>>(
                                future:  Provider.of<HomeProvider>(context,
                                    listen: false)
                                    .getAdsListNext(widget.ad.adsId) ,
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
                                        return null;
                                      } else {
                                        if (snapshot.data.length > 0) {
                                          return     ListView.builder(
                                              scrollDirection: Axis.horizontal,
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

                                                    width: _width*.40,

                                                    child: InkWell(
                                                        onTap: (){

                                                          _homeProvider.setCurrentAds(snapshot.data[index].adsId);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => AdDetailsScreen(
                                                                    ad: snapshot.data[index],


                                                                  )));
                                                        },
                                                        child:  Container(

                                                          padding: EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            border: Border.all(
                                                              color: mainAppColor,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.keyboard_arrow_right,color: mainAppColor,),
                                                              Text("الاعلان التالي",style: TextStyle(color: mainAppColor,fontSize: 16,fontWeight: FontWeight.bold),)
                                                            ],
                                                          ),
                                                        )));
                                              }
                                          );
                                        } else {
                                          return Text("");
                                        }
                                      }
                                  }
                                  return Center(
                                    child: SpinKitFadingCircle(color: mainAppColor),
                                  );
                                }),
                          ),






                          Container(
                            height: 50,
                            width: _width*.40,
                            margin: EdgeInsets.all(_width*.02),
                            child: FutureBuilder<List<Ad>>(
                                future:  Provider.of<HomeProvider>(context,
                                    listen: false)
                                    .getAdsListPrev(widget.ad.adsId) ,
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
                                              scrollDirection: Axis.horizontal,
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

                                                    width: _width*.40,

                                                    child: InkWell(
                                                        onTap: (){

                                                          _homeProvider.setCurrentAds(snapshot.data[index].adsId);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => AdDetailsScreen(
                                                                    ad: snapshot.data[index],


                                                                  )));
                                                        },
                                                        child:  Container(

                                                          padding: EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            border: Border.all(
                                                              color: mainAppColor,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.keyboard_arrow_right,color: mainAppColor,),
                                                              Text("الاعلان السابق",style: TextStyle(color: mainAppColor,fontSize: 16,fontWeight: FontWeight.bold),)
                                                            ],
                                                          ),
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




                        ],
                      ),
                    )





                  ],
                );
              }
          }
          return Center(
            child: SpinKitFadingCircle(color: mainAppColor),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,


      title: Text(
        widget.ad.adsTitle,
        style: TextStyle(fontSize: 15, color: omarColor),
      ),
      actions: <Widget>[
        IconButton(
            icon: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return authProvider.currentLang == 'ar'
                    ? Image.asset(
                        'assets/images/left.png',
                        color: omarColor,
                      )
                    : Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: Image.asset(
                          'assets/images/left.png',
                          color: omarColor,
                        ));
              },
            ),
            onPressed: () => Navigator.pop(context))
      ],
    );

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
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
