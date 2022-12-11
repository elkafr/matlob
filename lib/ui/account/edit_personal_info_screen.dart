import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/country.dart';
import 'package:matlob/models/interest.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:matlob/custom_widgets/MainDrawer.dart';
import 'dart:math' as math;


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/dialogs/confirmation_dialog.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/category.dart';
import 'package:matlob/models/city.dart';
import 'package:matlob/models/country.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:matlob/models/marka.dart';
import 'package:matlob/models/model.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;

class EditPersonalInfoScreen extends StatefulWidget {
  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> with ValidationMixin {
 double _height = 0 , _width = 0;
 String _userName = '',_userPhone = '',_userEmail ='',_userJob ='',_userWasf ='';
 AuthProvider _authProvider;
 Future<List<CategoryModel>> _subList;
 Future<List<CategoryModel>> _categoryList;
 Future<List<Interest>>  _interestList;
 CategoryModel _selectedCategory;
 CategoryModel _selectedSub;
 bool _initialRun = true;
 bool _isLoading = false;
 Country _selectedCountry;
 bool _initSelectedCountry = true;
  Future<List<Country>> _countryList;

 String _xx=null;
 String _yy=null;
  HomeProvider _homeProvider;
    final _formKey = GlobalKey<FormState>();
  ApiProvider _apiProvider = ApiProvider();


 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:'6');

      _countryList = _homeProvider.getCountryList();
      _interestList = _homeProvider.getInterestlist();
      _userName = _authProvider.currentUser.userName;
      _userPhone = _authProvider.currentUser.userPhone;
      _userEmail = _authProvider.currentUser.userEmail;
      _userJob = _authProvider.currentUser.userJob;
      _userWasf = _authProvider.currentUser.userWasf;
      _initialRun = false;
    }
  }
Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Container(
      height: _height,
      width: _width,
      child: Form(
        key: _formKey,
        child: Column(
     
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
             CustomTextFormField(
               initialValue: _userName,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/user.png',
                hintTxt:AppLocalizations.of(context).translate('user_name'),
                validationFunc:validateUserName
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: _height *0.02),
                child: CustomTextFormField(
                  initialValue: _userPhone,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/call.png',
                  hintTxt:  AppLocalizations.of(context).translate('phone_no'),
                  validationFunc: validateUserPhone
                ),
              ),
                CustomTextFormField(
                  initialValue: _userEmail,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/mail.png',
                  hintTxt: AppLocalizations.of(context).translate('email'),
                  validationFunc:  validateUserEmail
              ),

            _authProvider.currentUser.userType=="2"?SizedBox(height: _width*.03,):Text(""),
            _authProvider.currentUser.userType=="2"?CustomTextFormField(
                initialValue: _userJob,
                hintTxt: _authProvider.currentLang=="ar"?"المهنة":"Job",
            ):Text(""),
            _authProvider.currentUser.userType=="2"?SizedBox(height: _width*.03,):Text(""),

            _authProvider.currentUser.userType=="2"?CustomTextFormField(
              initialValue: _userWasf,
              hintTxt: _authProvider.currentLang=="ar"?"وصف تسويقي":"Marketing description",
            ):Text(""),



            _authProvider.currentUser.userType=="2"?Container(
              margin: EdgeInsets.only(right: _width*.04,left:  _width*.04,top: _width*.02),
              padding: EdgeInsets.all(5),
              child:
              Text(_authProvider.currentLang=="ar"?"الأقسام ذات الاهتمام (سيتم استلام اشعارات عند اضافة طلبات جديدة بهذه الأقسام )":"Sections of interest (notifications will be received when new requests are added in these sections)",style: TextStyle(fontWeight: FontWeight.bold),),
                
            ):Text(""),



            _authProvider.currentUser.userType=="2"?SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(right: _width*.04,left:  _width*.04),
            padding: EdgeInsets.all(10),
            height: _height*.15,
            width: _width,
            child: FutureBuilder<List<Interest>>(
                future: _interestList,
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
                        return Text("Error");
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(snapshot.data[index].interestCat!=null?snapshot.data[index].interestCat:"",style: TextStyle(fontWeight: FontWeight.bold),),
                                    GestureDetector(
                                      child: Image.asset(
                                        'assets/images/delete.png',
                                      ),
                                      onTap: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        final results =
                                        await _apiProvider.get(
                                            "https://matloobservices.com/api/do_delete_interest" +
                                                "?interest_id=${snapshot.data[index].interestId}");

                                        setState(() =>
                                        _isLoading = false);
                                        if (results['response'] ==
                                            "1") {
                                          Commons.showToast(context,
                                              message: results[
                                              "message"]);
                                         setState(() {
                                           _interestList = _homeProvider.getInterestlist();
                                         });
                                        } else {
                                          Commons.showError(context,
                                              results["message"]);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                  }
                  return Center(
                    child: SpinKitFadingCircle(color: mainAppColor),
                  );
                }),
          ),
        ):Text(""),

            _authProvider.currentUser.userType=="2"?SizedBox(height: _width*.01,):Text(""),
            _authProvider.currentUser.userType=="2"?FutureBuilder<List<CategoryModel>>(
              future: _categoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {

                      return new DropdownMenuItem<CategoryModel>(

                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    categoryList.removeAt(0);
                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint: _homeProvider.currentLang=='ar'?'القسم الرئيسي':'Main category',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {


                          _selectedCategory = newValue;
                          _selectedSub=null;
                          _homeProvider.setSelectedCat(newValue);
                          _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
                          AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:_homeProvider.selectedCat.catId);


                          _xx=_homeProvider.selectedCat.catId;
                          print(_xx);

                        });
                      },
                      value: _selectedCategory,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ):Text(""),


            _authProvider.currentUser.userType=="2"?SizedBox(height: _width*.03,):Text(""),

            _authProvider.currentUser.userType=="2"?FutureBuilder<List<CategoryModel>>(
              future: _subList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<CategoryModel>(
                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    categoryList.removeAt(0);
                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint:_homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub category',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedSub = newValue;
                          _homeProvider.setSelectedSub(newValue);
                          _yy=_homeProvider.selectedSub.catId;
                          print(_yy);
                        });
                      },
                      value: _selectedSub,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else    if (snapshot.hasError) {
                  DioError error = snapshot.error;
                  String message = error.message;
                  if (error.type == DioErrorType.CONNECT_TIMEOUT)
                    message = 'Connection Timeout';
                  else if (error.type ==
                      DioErrorType.RECEIVE_TIMEOUT)
                    message = 'Receive Timeout';
                  else if (error.type == DioErrorType.RESPONSE)
                    message =
                    '404 server not found ${error.response.statusCode}';
                  print(message);
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ):Text(""),

            _authProvider.currentUser.userType=="2"?Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ):Text(""),

            _authProvider.currentUser.userType=="2"?Container(
              width: _width*.50,
              child: CustomButton(
                btnLbl: _authProvider.currentLang=="ar"?"اضافة":"Add",
                onPressedFunction: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => _isLoading = true);
                    FormData formData = new FormData.fromMap({
                      "interest_user": _authProvider.currentUser.userId,
                      "interest_cat":  _yy,

                    });
                    final results = await _apiProvider
                        .postWithDio("https://matloobservices.com/api/add_interest" + "?api_lang=${_authProvider.currentLang}", body: formData);
                    setState(() => _isLoading = false);

                    if (results['response'] == "1") {
                      Commons.showToast(context,message: results["message"] );
                      setState(() {
                        _interestList = _homeProvider.getInterestlist();
                      });
                    } else {
                      Commons.showError(context, results["message"]);
                    }
                  }

                },
              ),
            ):Text(""),


Spacer(),
            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('save'),
              onPressedFunction: () async {
if (_formKey.currentState.validate()){
setState(() => _isLoading = true);
                    FormData formData = new FormData.fromMap({
                      "user_id": _authProvider.currentUser.userId,
                      "user_name":  _userName,        
                      "user_phone" : _userPhone,
                      "user_email":  _userEmail,

                    });
                    final results = await _apiProvider
                        .postWithDio(Urls.PROFILE_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
                    setState(() => _isLoading = false);

                    if (results['response'] == "1") {
                      _authProvider
                          .setCurrentUser(User.fromJson(results["user"]));
                      SharedPreferencesHelper.save(
                          "user", _authProvider.currentUser);
                      Commons.showToast(context,message: results["message"] );
                      Navigator.pop(context);
                    } else {
                      Commons.showError(context, results["message"]);
                    }
}
 
              },
              ),
              
SizedBox(
  height: _height *0.01,
)

              
          ],
        ),
      ),
    ),
  );
}


@override
  Widget build(BuildContext context) {



  final appBar = AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Color(0xffF5F6F8),
    centerTitle: true,
    leading: Builder(
      builder: (context) => IconButton(
        icon: Image.asset("assets/images/menu.png"),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    ),
    title:Text(AppLocalizations.of(context).translate('edit_info'),style: TextStyle(fontSize: 15,color: omarColor),),
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
          onPressed: () =>
              Navigator.pop(context)

      )



    ],
  );



  _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
        backgroundColor: Color(0xffF5F6F8),
        appBar: appBar,
        drawer: MainDrawer(),
        body: _buildBodyItem(),
      ),
    );
  }
}