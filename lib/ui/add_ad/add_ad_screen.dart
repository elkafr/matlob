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

import 'package:location/location.dart';
import 'package:matlob/models/city.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;
import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class AddAdScreen extends StatefulWidget {
  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  Future<List<Country>> _countryList;
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  Country _selectedCountry;
  City _selectedCity;
  CategoryModel _selectedCategory;
  CategoryModel _selectedSub;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  List<String> _genders ;
  File _imageFile;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  String _xx=null;
  String _yy=null;
  String _omar;
  String _ali;

  bool checkedValue=false;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;


  dynamic _pickImageError;
  final _picker = ImagePicker();
  AuthProvider _authProvider;
  ApiProvider _apiProvider =ApiProvider();
  bool _isLoading = false;
  String _adsTitle = '';
  String _adsPrice = '';
  String _adsPhone = '';
  String _adsWhatsapp = '';
  String _adsDescription = '';



  String _adsStars='';
  String _adsItemsNumber='';
  String _adsDoorsNumber='';
  String _adsArea='';
  String _adsAdress='';
  String _adsStreet='';
  String _adsMmsha='';
  String _adsAsasia='';
  String _adsFace='';
  String _adsLocation='';
  String _adsKithchenNumber='';
  String _adsBathNumbers='';
  String _adsHallNumbers='';
  String _adsRoomNumbers='';
  String _adsShopsNumber='';


  NavigationProvider _navigationProvider;
  LocationData _locData;






  List<String> _adsQa3at;
  String _selectedAdsQa3at;

  List<String> _adsMwaqef;
  String _selectedAdsMwaqef;


  List<String> _adsAsanser;
  String _selectedAdsAsanser;

  List<String> _adsMshb;
  String _selectedAdsMshb;


  List<String> _adsCarPath;
  String _selectedAdsCarPath;

  List<String> _adsHoosh;
  String _selectedAdsHoosh;

  List<String> _adsBeer;
  String _selectedAdsBeer;

  List<String> _adsRshashat;
  String _selectedAdsRshashat;

  List<String> _adsMsbh;
  String _selectedAdsMsbh;

  List<String> _adsMl2b;
  String _selectedAdsMl2b;

  List<String> _adsSellType;
  String _selectedAdsSellType;

  List<String> _adsCarState;
  String _selectedAdsCarState;


  List<String> _adsAqarType;
  String _selectedAdsAqarType;

  List<String> _adsQeerType;
  String _selectedAdsQeerType;

  List<String> _adsWqoodType;
  String _selectedAdsWqoodType;

  List<String> _adsDblFound;
  String _selectedAdsDblFound;





   Future<void> _getCurrentUserLocation() async {
     _locData = await Location().getLocation();
    if(_locData != null){
      print('lat' + _locData.latitude.toString());
      print('longitude' + _locData.longitude.toString());
      Commons.showToast(context, message:
        AppLocalizations.of(context).translate('detect_location'));
        setState(() {

        });
    }
  }


  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed1(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile1 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed2(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile2 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed3(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile3 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {







      _adsQa3at = ["يوجد", "لا يوجد"];
      _adsMwaqef = ["يوجد", "لا يوجد"];
      _adsAsanser = ["يوجد", "لا يوجد"];
      _adsMshb = ["يوجد", "لا يوجد"];
      _adsCarPath = ["يوجد", "لا يوجد"];
      _adsHoosh = ["يوجد", "لا يوجد"];
      _adsBeer = ["يوجد", "لا يوجد"];
      _adsRshashat = ["يوجد", "لا يوجد"];
      _adsMsbh = ["يوجد", "لا يوجد"];
      _adsMl2b = ["يوجد", "لا يوجد"];
      _adsSellType = ["تنازل", "بيع"];
      _adsCarState = ["جديدة", "مستعملة","مصدومة"];
      _adsAqarType = ["بيع ", "ايجار ","استثمار"];
      _adsQeerType =  ["اتوماتك", "عادي"];
      _adsWqoodType = ["بنزبن", "ديزل","هايبرد"];
      _adsDblFound = ["يوجد", "لا يوجد"];

      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:'6');

      _countryList = _homeProvider.getCountryList();
      _cityList = _homeProvider.getCityList(enableCountry: true,countryId:'500');
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();


      _initialRun = false;
    }
  }






  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('معرض الصور'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('الكاميرا'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet1(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('معرض الصور'),
                    onTap: (){

                      _onImageButtonPressed1(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('الكاميرا'),
                    onTap: (){
                      _onImageButtonPressed1(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet2(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('معرض الصور'),
                    onTap: (){
                      _onImageButtonPressed2(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('الكاميرا'),
                    onTap: (){
                      _onImageButtonPressed2(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet3(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('معرض الصور'),
                    onTap: (){
                      _onImageButtonPressed3(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('الكاميرا'),
                    onTap: (){
                      _onImageButtonPressed3(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }



  Widget _buildBodyItem() {


print(_yy);










    var adsQa3at = _adsQa3at.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsMwaqef = _adsMwaqef.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsAsanser = _adsAsanser.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsMshb = _adsMshb.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsCarPath = _adsCarPath.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsHoosh = _adsHoosh.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsBeer = _adsBeer.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsRshashat = _adsRshashat.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsMsbh = _adsMsbh.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsMl2b = _adsMl2b.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsSellType = _adsSellType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsCarState = _adsCarState.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

var adsAqarType = _adsAqarType.map((item) {
  return new DropdownMenuItem<String>(
    child: new Text(item),
    value: item,
  );
}).toList();


    var adsQeerType = _adsQeerType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsWqoodType = _adsWqoodType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsDblFound = _adsDblFound.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),







            Container(
              padding: EdgeInsets.fromLTRB(25,5,25,10),
              child: Text(_homeProvider.currentLang=='ar'?"صور الاعلان":"Ad photos"),
            ),

            Row(
              children: <Widget>[
                Padding(padding:EdgeInsets.fromLTRB(25,5,5,10)),

                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){

                          _settingModalBottomSheet(context);
                        },
                        child: Container(
                          height: _height * 0.1,
                          width: _width*.20,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: hintColor.withOpacity(0.4),
                            ),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: _imageFile != null
                              ?ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:  Image.file(
                                _imageFile,
                                // fit: BoxFit.fill,
                              ))
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),

                            ],
                          ),
                        )),

                    Positioned(child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                        setState(() {
                          _imageFile=null;
                        });
                      },
                    ))
                  ],
                ),

                Padding(padding: EdgeInsets.all(5)),

                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          if(_imageFile==null){
                            Commons.showToast(context, message: "عفوا يجب اختيار الصور من اليمين اولا");
                          }else{
                            _settingModalBottomSheet1(context);
                          }

                        },
                        child: Container(
                          height: _height * 0.1,
                          width: _width*.20,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: hintColor.withOpacity(0.4),
                            ),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: _imageFile1 != null
                              ?ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:  Image.file(
                                _imageFile1,
                                // fit: BoxFit.fill,
                              ))
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),

                            ],
                          ),
                        )),

                    Positioned(
                        top: 0,
                        child: GestureDetector(
                          child: Icon(Icons.delete_forever),
                          onTap: (){
                            setState(() {

                              _imageFile1=null;

                            });
                          },
                        ))
                  ],
                ),

                Padding(padding: EdgeInsets.all(5)),

                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          if(_imageFile==null || _imageFile1==null){
                            Commons.showToast(context, message: "عفوا يجب اختيار الصور من اليمين اولا");
                          }else {
                            _settingModalBottomSheet2(context);
                          }
                        },
                        child: Container(
                          height: _height * 0.1,
                          width: _width*.20,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: hintColor.withOpacity(0.4),
                            ),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: _imageFile2 != null
                              ?ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:  Image.file(
                                _imageFile2,
                                // fit: BoxFit.fill,
                              ))
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),

                            ],
                          ),
                        )),

                    Positioned(child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                        setState(() {
                          _imageFile2=null;
                        });
                      },
                    ))
                  ],
                ),

                Padding(padding: EdgeInsets.all(5)),

                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){

                          if(_imageFile==null || _imageFile1==null || _imageFile2==null){
                            Commons.showToast(context, message: "عفوا يجب اختيار الصور من اليمين اولا");
                          }else {
                            _settingModalBottomSheet3(context);
                          }
                        },
                        child: Container(
                          height: _height * 0.1,
                          width: _width*.20,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: hintColor.withOpacity(0.4),
                            ),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: _imageFile3 != null
                              ?ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:  Image.file(
                                _imageFile3,
                                // fit: BoxFit.fill,
                              ))
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),


                            ],
                          ),
                        )),
                    Positioned(child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                        setState(() {
                          _imageFile3=null;
                        });
                      },
                    ))
                  ],
                ),

              ],

            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),

              child: CustomTextFormField(
                hintTxt: AppLocalizations.of(context).translate('ad_title'),

                onChangedFunc: (text) {
                  _adsTitle = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),
            FutureBuilder<List<CategoryModel>>(
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
            ),



            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),



            (_xx=='21')?Column(
              children: <Widget>[

                FutureBuilder<List<Marka>>(
                  future: _markaList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var markaList = snapshot.data.map((item) {

                          return new DropdownMenuItem<Marka>(

                            child: new Text(item.markaName),
                            value: item,
                          );
                        }).toList();
                        markaList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: markaList,
                          marg: .07,
                          hint: _homeProvider.currentLang=='ar'?'الماركة':'Marka',
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus( FocusNode());
                            setState(() {


                              _selectedMarka = newValue;
                            });
                          },
                          value: _selectedMarka,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.02),
                ),

                FutureBuilder<List<Model>>(
                  future: _modelList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var modelList = snapshot.data.map((item) {

                          return new DropdownMenuItem<Model>(

                            child: new Text(item.modelName),
                            value: item,
                          );
                        }).toList();
                        modelList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: modelList,
                          marg: .07,
                          hint: _homeProvider.currentLang=='ar'?'الموديل':'Model',
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus( FocusNode());
                            setState(() {


                              _selectedModel = newValue;
                            });
                          },
                          value: _selectedModel,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),






              ],
            ):FutureBuilder<List<CategoryModel>>(
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
            ),


            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),

            Container(


              child: CustomTextFormField(
                hintTxt:  AppLocalizations.of(context).translate('ad_price'),
                onChangedFunc: (text) {
                  _adsPrice = text;
                },
                validationFunc: validateAdPrice,
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),

            Container(

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"رقم الجوال":"Phone",
                onChangedFunc: (text) {
                  _adsPhone = text;
                },
                validationFunc: validateAdPrice,
              ),
            ),




















































































































































            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            FutureBuilder<List<Country>>(
              future: _countryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var countryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<Country>(
                        child: new Text(item.countryName),
                        value: item,
                      );
                    }).toList();
                    return DropDownListSelector(
                      dropDownList: countryList,
                      marg: .07,
                      hint:"المدينة",
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedCountry = newValue;
                          _selectedCity=null;
                          _homeProvider.setSelectedCountry(newValue);
                          _cityList = _homeProvider.getCityList(enableCountry: true,countryId:_homeProvider.selectedCountry.countryId);
                        });
                      },

                      value: _selectedCountry,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                maxLines: 3,
                hintTxt:  AppLocalizations.of(context).translate('ad_description'),
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescription = text;
                },
              ),
            ),


         /*   Container(
                alignment: Alignment.centerRight,

              child: CheckboxListTile(

                checkColor: Colors.white,
                activeColor: mainAppColor,
                title: Text("هل تريد اضافه موقع السلعه ؟",style: TextStyle(fontSize: 15),),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                    _homeProvider.setCheckedValue(newValue.toString());
                    print(_homeProvider.checkedValue);
                  });
                },

              ),
            ),

            _homeProvider.checkedValue=="true"?Container(
                width: _locData == null ? _width * 0.5 : _width *0.55,
                child: CustomButton(
                  btnColor: mainAppColor,
                  borderColor: accentColor,
                  onPressedFunction: (){
  _getCurrentUserLocation();

                  },
                  btnStyle: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  btnLbl: _locData == null ? AppLocalizations.of(context).translate('choose_location') : AppLocalizations.of(context).translate('detect_location'),
                )):Text(' ',style: TextStyle(height: 0),),

  */

           _isLoading
      ? Center(
      child:SpinKitFadingCircle(color: mainAppColor),
    )
        :CustomButton(
              btnLbl: AppLocalizations.of(context).translate('publish_ad'),
              onPressedFunction: () async {
                if (_formKey.currentState.validate() &
                    checkAddAdValidation(context,
                    imgFile: _imageFile,
                        adMainCategory: _selectedCategory,
                    )) {

                               FocusScope.of(context).requestFocus( FocusNode());
                             setState(() => _isLoading = true);


                               String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";
                               String fileName1 = (_imageFile1!=null)?Path.basename(_imageFile1.path):"";
                               String fileName2 = (_imageFile2!=null)?Path.basename(_imageFile2.path):"";
                               String fileName3 = (_imageFile3!=null)?Path.basename(_imageFile3.path):"";




                               if(_selectedAdsCarState=='جديدة'){
                                 _omar="1";
                               }else if(_selectedAdsCarState=='مستعملة'){
                                 _omar="2";
                               }else if(_selectedAdsCarState=='مصدومة'){
                                 _omar="3";
                               }


                               if(_selectedAdsWqoodType=='بنزين'){
                                 _ali="1";
                               }else if(_selectedAdsWqoodType=='ديزل'){
                                 _ali="2";
                               }else if(_selectedAdsWqoodType=='هايبرد'){
                                 _ali="3";
                               }


                  FormData formData = new FormData.fromMap({
                    "user_id": _authProvider.currentUser.userId,
                    "ads_title": _adsTitle,
                    "ads_details": _adsDescription,
                    "ads_cat": _selectedCategory.catId,
                    "ads_sub": _selectedSub!=null?_selectedSub.catId:"0",
                    "ads_marka": _selectedMarka!=null?_selectedMarka.markaId:"0",
                    "ads_model": _selectedModel!=null?_selectedModel.modelId:"0",
                    "ads_city": _selectedCountry!=null?_selectedCountry.countryId:"0",
                    "ads_price": _adsPrice,
                    "ads_phone": _adsPhone,
                    "ads_request": "1",


                    "imgURL[0]": (_imageFile!=null)?await MultipartFile.fromFile(_imageFile.path, filename: fileName):"",
                    "imgURL[1]": (_imageFile1!=null)?await MultipartFile.fromFile(_imageFile1.path, filename: fileName1):"",
                    "imgURL[2]": (_imageFile2!=null)?await MultipartFile.fromFile(_imageFile2.path, filename: fileName2):"",
                    "imgURL[3]": (_imageFile3!=null)?await MultipartFile.fromFile(_imageFile3.path, filename: fileName3):"",
                  });
                  final results = await _apiProvider
                      .postWithDio(Urls.ADD_AD_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);


                  if (results['response'] == "1") {

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) {
                          return ConfirmationDialog(
                            title: AppLocalizations.of(context).translate('ad_has_published_successfully'),
                            message:
                                AppLocalizations.of(context).translate('ad_published_and_manage_my_ads'),
                          );
                        });
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                       Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/my_ads_screen');
                      _navigationProvider.upadateNavigationIndex(0);
                    });
                  } else {
                    Commons.showError(context, results["message"]);
                  }



                }
              },
            ),
          ],
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

      title:Text(_homeProvider.adsRequest=="1"?"اضافة طلب":"اضافة عرض",style: TextStyle(fontSize: 15,color: omarColor),),
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
    _authProvider = Provider.of<AuthProvider>(context);
    _navigationProvider = Provider.of<NavigationProvider>(context);
    return PageContainer(

      child: Scaffold(
        backgroundColor: Color(0xffF5F6F8),
        appBar: appBar,


        body: _buildBodyItem(),
      ),
    );
  }
}
