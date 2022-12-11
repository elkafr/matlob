
import 'package:flutter/cupertino.dart';
import 'package:matlob/custom_widgets/ad_item/seller_item.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/ui/seller/seller_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item1.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/models/category.dart';
import 'package:matlob/models/city.dart';
import 'package:matlob/models/marka.dart';
import 'package:matlob/models/model.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/ui/ad_details/ad_details_screen.dart';
import 'package:matlob/ui/home/widgets/category_item.dart';
import 'package:matlob/ui/home/widgets/map_widget.dart';
import 'package:matlob/ui/search/search_bottom_sheet.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/ui/account/account_screen.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/error.dart';
import 'package:matlob/providers/navigation_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector1.dart';
import 'package:matlob/custom_widgets/MainDrawer.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> with TickerProviderStateMixin {
  double _height = 0, _width = 0;
  NavigationProvider _navigationProvider;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  AnimationController _animationController;
  AuthProvider _authProvider;

  Future<List<City>> _cityList;
  City _selectedCity;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;

  CategoryModel _selectedSub;
  String _selectedCat;
  bool _isLoading = false;

  String _xx=null;
  String photo1="";
  String url1="";
  String photo2="";
  String url2="";
  String omar="";

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
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);


      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");


      _cityList = _homeProvider.getCityList(enableCountry: false);
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();
      _initialRun = false;
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {
    print("dddddddddddddddd");
    print(_homeProvider.photo1);
    print("dddddddddddddddd");
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[






        Container(
            height: _height * 0.13,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(5,5,5,0),
            child: FutureBuilder<List<CategoryModel>>(
                future: _categoryList,
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
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {

                                return Consumer<HomeProvider>(
                                    builder: (context, homeProvider, child) {
                                      return InkWell(
                                        onTap: (){


                                          homeProvider
                                              .updateChangesOnCategoriesList(index);

                                          homeProvider.setEnableSearch(true);

                                          homeProvider.setSelectedCat(snapshot.data[index]);
                                          print(_homeProvider.selectedCat);

                                          homeProvider.setCurrentCatName(snapshot.data[index].catName);

                                          _selectedSub=null;
                                          _selectedMarka=null;
                                          _selectedModel=null;
                                          _selectedCity=null;
                                          homeProvider.setSelectedSub(null);
                                          homeProvider.setSelectedMarka(null);
                                          homeProvider.setSelectedModel(null);
                                          homeProvider.setSelectedCity(null);


                                          homeProvider.setSelectedCat(snapshot.data[index]);
                                          homeProvider.setAge(snapshot.data[index].catId);

                                          _xx=homeProvider.selectedCat.catId;
                                          _subList = homeProvider.getSubList(enableSub: true,catId:homeProvider.age!=''?homeProvider.age:"6");



                                        },
                                        child: Container(

                                          color: Color(0xffFCFCFC),
                                          width: _width * 0.25,
                                          child: CategoryItem(
                                            category: snapshot.data[index],
                                          ),
                                        ),
                                      );
                                    });
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
        Container(height: 15,),

       Container(
         margin: EdgeInsets.only(right: _width*.03,left: _width*.03),
         child:  Row(
           children: <Widget>[


             GestureDetector(
               onTap: (){
                 _homeProvider.setEnableSearch(true);
               _homeProvider.setFilter("1");
               },
               child: Container(
                 alignment: Alignment.center,
                 width: _width*.29,
                 margin: EdgeInsets.only(left: _width*.02),
                 decoration: _homeProvider.filter!=null && _homeProvider.filter=="1"?BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                      gradient: LinearGradient(
                      colors: [
                        const Color(0xFF37D3FC),
                      const Color(0xFF049CD6),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                 ):BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                 ),

                 padding: EdgeInsets.only(right: 10,top: 8,bottom: 8,left: 10),
                 child: Text("اخر الطلبات",style: TextStyle(color: _homeProvider.filter!=null && _homeProvider.filter=="1"?Colors.white:Color(0xff4C4C4C)),),
               ),
             ),








             GestureDetector(
               onTap: (){
                 _homeProvider.setFilter("2");
                 _homeProvider.setEnableSearch(true);
               },
               child: Container(
                 alignment: Alignment.center,
                 width: _width*.28,
                 margin: EdgeInsets.only(left: _width*.02),
                 decoration: _homeProvider.filter!=null && _homeProvider.filter=="2"?BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                   gradient: LinearGradient(
                       colors: [
                         const Color(0xFF37D3FC),
                         const Color(0xFF049CD6),
                       ],
                       begin: const FractionalOffset(0.0, 0.0),
                       end: const FractionalOffset(1.0, 0.0),
                       stops: [0.0, 1.0],
                       tileMode: TileMode.clamp),
                 ):BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                 ),

                 padding: EdgeInsets.only(right: 10,top: 8,bottom: 8,left: 10),
                 child: Text("اخر العروض",style: TextStyle(color: _homeProvider.filter!=null && _homeProvider.filter=="2"?Colors.white:Color(0xff4C4C4C)),),
               ),
             ),






             GestureDetector(
               onTap: (){
                 _homeProvider.setFilter("3");
                 _homeProvider.setEnableSearch(true);
               },
               child: Container(
                 alignment: Alignment.center,
                 width: _width*.33,
                 decoration: _homeProvider.filter!=null && _homeProvider.filter=="3"?BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                   gradient: LinearGradient(
                       colors: [
                         const Color(0xFF37D3FC),
                         const Color(0xFF049CD6),
                       ],
                       begin: const FractionalOffset(0.0, 0.0),
                       end: const FractionalOffset(1.0, 0.0),
                       stops: [0.0, 1.0],
                       tileMode: TileMode.clamp),
                 ):BoxDecoration(
                   border: Border.all(
                     width: 0.1,
                     color: Color(0xffBFBFBF),
                   ),
                   borderRadius: BorderRadius.all(
                     Radius.circular(5.0),
                   ),
                   color: Colors.grey[100],
                 ),

                 padding: EdgeInsets.only(right: 10,top: 8,bottom: 8,left: 10),
                 child: Text("مقدمي الخدمات",style: TextStyle(color: _homeProvider.filter!=null && _homeProvider.filter=="3"?Colors.white:Color(0xff4C4C4C)),),
               ),
             ),



           ],
         ),
       ),




        Container(height: 15,),
        FutureBuilder<List<City>>(
          future: _cityList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData) {
                var cityList = snapshot.data.map((item) {
                  return new DropdownMenuItem<City>(
                    child: new Text(item.cityName),
                    value: item,
                  );
                }).toList();
                return DropDownListSelector1(

                  dropDownList: cityList,
                  hint: _homeProvider.currentLang=='ar'?'كافة المدن':'All Regions',
                  marg: 0.02,
                  onChangeFunc: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _selectedCity = newValue;
                      _homeProvider.setEnableSearch(true);
                      _homeProvider.setSelectedCity(newValue);
                    });
                  },
                  value: _selectedCity,
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



        _xx!='21'?Text("",style: TextStyle(height: 0),):Container(height: 5,),
        _xx!='21'?Text("",style: TextStyle(height: 0),):FutureBuilder<List<Marka>>(
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
                return DropDownListSelector1(
                  dropDownList: markaList,
                  marg: 0.02,
                  hint: _homeProvider.currentLang=='ar'?'الماركة':'Marka',
                  onChangeFunc: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _selectedMarka = newValue;
                      _homeProvider.setEnableSearch(true);
                      _homeProvider.setSelectedMarka(newValue);
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



        _xx!='21'?Text("",style: TextStyle(height: 0),):Container(height: 5,),
        _xx!='21'?Text("",style: TextStyle(height: 0),):FutureBuilder<List<Model>>(
          future: _modelList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData) {
                var cityList = snapshot.data.map((item) {
                  return new DropdownMenuItem<Model>(
                    child: new Text(item.modelName),
                    value: item,
                  );
                }).toList();
                return DropDownListSelector1(
                  marg: 0.02,
                  dropDownList: cityList,
                  hint: _homeProvider.currentLang=='ar'?'الموديل':'Model',
                  onChangeFunc: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _selectedModel = newValue;
                      _homeProvider.setEnableSearch(true);
                      _homeProvider.setSelectedModel(newValue);
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

        Container(height: 5,),
        (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId!="0" && _xx!='21')?FutureBuilder<List<CategoryModel>>(
          future: _subList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData) {
                var cityList = snapshot.data.map((item) {
                  return new DropdownMenuItem<CategoryModel>(
                    child: new Text(item.catName),
                    value: item,
                  );
                }).toList();

                return DropDownListSelector1(
                  dropDownList: cityList,
                  marg: 0.02,
                  hint: _homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub Category',
                  onChangeFunc: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _selectedSub = newValue;
                      _homeProvider.setEnableSearch(true);
                      _homeProvider.setSelectedSub(newValue);
                    });
                  },
                  value: _selectedSub,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          },
        ):Text(' ',style: TextStyle(height: 0),),

        Container(height: 2,),

        FutureBuilder<String>(
            future: Provider.of<HomeProvider>(context,
                listen: false)
                .getOmar(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: SpinKitFadingCircle(color: Colors.black),
                  );
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.waiting:
                  return Center(
                    child: SpinKitFadingCircle(color: Colors.black),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Error(
                       errorMessage: snapshot.error.toString(),
                  //    errorMessage: AppLocalizations.of(context).translate('error'),
                    );
                  } else {
                    omar=snapshot.data;

                    return  Row(
                      children: <Widget>[

                        Text("",style: TextStyle(height: 0),)
                      ],
                    );
                  }
              }
              return Center(
                child: SpinKitFadingCircle(color: mainAppColor),
              );
            }),





        Container(height: 2,),
        Container(

          margin: EdgeInsets.only(right: _width*.04,left: _width*.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _homeProvider.currentCatName!=null?Text(_homeProvider.currentCatName,style: TextStyle(color: Color(0xff4C4C4C)
              ,fontSize: 15,fontWeight: FontWeight.bold),):Text("ddd"),

             Spacer(flex: 1,),
              _homeProvider.filter!="3"?Container(
                width: _width*.06,
                height: _width*.06,
                child: GestureDetector(
                  child: Image.asset("assets/images/list.png",color: _homeProvider.view=="list"?Colors.black:mainAppColor,),
                  onTap: (){
                    _homeProvider.setView("list");
                  },
                ),
              ):Text(""),
              Padding(padding: EdgeInsets.all(10)),
              _homeProvider.filter!="3"?Container(
                width: _width*.06,
                height: _width*.06,
                child: GestureDetector(
                  child: Image.asset("assets/images/grid.png",color: _homeProvider.view=="grid"?Colors.black:mainAppColor,),
                  onTap: (){
                    _homeProvider.setView("grid");
                  },
                ),
              ):Text("")
            ],
          ),
        ),
        Container(height: 1,),




        _homeProvider.filter!=null &&_homeProvider.filter!="3"?Container(
            height: (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId=="21")?_height * 0.45:_height * 0.50,
            width: _width,
            child:
            Consumer<HomeProvider>(builder: (context, homeProvider, child) {
              return FutureBuilder<List<Ad>>(
                  future: homeProvider.enableSearch
                      ? Provider.of<HomeProvider>(context, listen: true)
                      .getAdsSearchList()
                      : Provider.of<HomeProvider>(context, listen: true)
                      .getAdsList(),
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
                            //errorMessage: "حدث خطأ ما ",
                          );
                        } else {
                          if (snapshot.data.length > 0) {

                            return _homeProvider.view==null || _homeProvider.view=="list"?ListView.builder(
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
                                            _homeProvider.setOmarKey(omar);



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
                                          )
                                      ));
                                }):GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1),
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1.6,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Consumer<HomeProvider>(

                                    builder: (context, homeProvider, child) {
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
                                      return InkWell(
                                        onTap: (){
                                          _homeProvider.setCurrentAds(snapshot
                                              .data[index].adsId);
                                          _homeProvider.setOmarKey(omar);



                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdDetailsScreen(
                                                        ad: snapshot
                                                            .data[index],
                                                      )));
                                        },
                                        child: AdItem1(
                                          animationController:
                                          _animationController,
                                          animation: animation,
                                          ad: snapshot.data[index],
                                        ),
                                      );
                                    });
                              },
                            );

                          } else {
                            return NoData(message: 'لاتوجد نتائج');
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  });
            })):Container(
            height: (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId=="21")?_height * 0.45:_height * 0.66,
            width: _width,
            child:
            Consumer<HomeProvider>(builder: (context, homeProvider, child) {
              return FutureBuilder<List<User>>(
                  future: homeProvider.enableSearch
                      ? Provider.of<HomeProvider>(context, listen: true)
                      .getProviderSearchList()
                      : Provider.of<HomeProvider>(context, listen: true)
                      .getProvidersList(),
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
                            //errorMessage: "حدث خطأ ما ",
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
                                            _homeProvider.setCurrentSeller(snapshot
                                                .data[index].userId);
                                            _homeProvider.setCurrentSellerName(snapshot
                                                .data[index].userName);

                                            _homeProvider.setCurrentSellerWasf(snapshot
                                                .data[index].userWasf);

                                            _homeProvider.setCurrentSellerJob(snapshot
                                                .data[index].userJob);

                                            _homeProvider.setCurrentSellerPhone(snapshot
                                                .data[index].userPhone);

                                            _homeProvider.setCurrentSellerPhoto(snapshot
                                                .data[index].userPhoto);

                                            _homeProvider.setOmarKey(omar);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SellerScreen(
                                                      userId: snapshot.data[index].userId,
                                                    )));
                                          },
                                          child: SellerItem(
                                            animationController:
                                            _animationController,
                                            animation: animation,
                                            user: snapshot.data[index],
                                          )
                                      ));
                                });

                          } else {
                            return NoData(message: 'اتوجد نتائج');
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  });
            }))













      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);


    
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);

    return _buildBodyItem();
  }
}
