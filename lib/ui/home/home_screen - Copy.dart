import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';

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
import 'package:matlob/custom_widgets/MainDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
      _homeProvider.currentLang=="ar"?"????????":"All",catImage: 'assets/images/all.png'),enableSub: false);


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
    return ListView(
      children: <Widget>[
        FutureBuilder<String>(
            future: Provider.of<HomeProvider>(context,
                listen: false)
                .getOmar() ,
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
                      //  errorMessage: snapshot.error.toString(),
                      errorMessage: AppLocalizations.of(context).translate('error'),
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
                          errorMessage: "?????? ?????? ???? ",
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

                                          homeProvider.setEnableSearch(false);

                                          _homeProvider.setSelectedCat(snapshot.data[index]);
                                          print(_homeProvider.selectedCat);

                                          _selectedSub=null;
                                          _selectedMarka=null;
                                          _selectedModel=null;
                                          _selectedCity=null;
                                          _homeProvider.setSelectedSub(_selectedSub);
                                          _homeProvider.setSelectedMarka(_selectedMarka);
                                          _homeProvider.setSelectedModel(_selectedModel);
                                          _homeProvider.setSelectedCity(_selectedCity);



                                          _homeProvider.setSelectedCat(snapshot.data[index]);
                                          _homeProvider.setAge(snapshot.data[index].catId);

                                          _xx=_homeProvider.selectedCat.catId;
                                          _subList = _homeProvider.getSubList(enableSub: true,catId:_homeProvider.age!=''?_homeProvider.age:"6");



                                        },
                                        child: Container(

                                          color: Color(0xffFCFCFC),
                                          width: _width * 0.20,
                                          child: CategoryItem(
                                            category: snapshot.data[index],
                                          ),
                                        ),
                                      );
                                    });
                              });
                        } else {
                          return NoData(message: '???????????? ??????????');
                        }
                      }
                  }
                  return Center(
                    child: SpinKitFadingCircle(color: mainAppColor),
                  );
                })),
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
                return DropDownListSelector(
                  dropDownList: cityList,
                  hint: _homeProvider.currentLang=='ar'?'???????? ??????????????':'All Regions',
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



        _xx!='7'?Text("",style: TextStyle(height: 0),):Container(height: 5,),
        _xx!='7'?Text("",style: TextStyle(height: 0),):FutureBuilder<List<Marka>>(
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
                return DropDownListSelector(
                  dropDownList: markaList,
                  marg: 0.02,
                  hint: _homeProvider.currentLang=='ar'?'??????????????':'Marka',
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



        _xx!='7'?Text("",style: TextStyle(height: 0),):Container(height: 5,),
        _xx!='7'?Text("",style: TextStyle(height: 0),):FutureBuilder<List<Model>>(
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
                return DropDownListSelector(
                  marg: 0.02,
                  dropDownList: cityList,
                  hint: _homeProvider.currentLang=='ar'?'??????????????':'Model',
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
        (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId!="0")?FutureBuilder<List<CategoryModel>>(
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
                cityList.removeAt(0);
                return DropDownListSelector(
                  dropDownList: cityList,
                  marg: 0.02,
                  hint: _homeProvider.currentLang=='ar'?'?????????? ????????????':'Sub Category',
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


        Container(height: 15,),
        Container(
            height: (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId=="7")?_height * 0.45:_height * 0.66,
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
                            //errorMessage: "?????? ?????? ???? ",
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
                                          )));
                                });

                          } else {
                            return NoData(message: '???????????? ??????????');
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

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Image.asset("assets/images/menu.png"),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      title:Text(_homeProvider.currentLang=="ar"?"????????????????":"Home",style: TextStyle(fontSize: 15,color: omarColor),),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  context: context,
                  builder: (builder) {
                    return Container(
                        width: _width,
                        height: _height * 0.9,
                        child: SearchBottomSheet());
                  });
            },
            child: Image.asset('assets/images/search.png')),


      ],
    );
    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);

    return PageContainer(
      child: Scaffold(

        appBar: appBar,
        drawer: MainDrawer(),
        body: _buildBodyItem(),
      ),
    );
  }
}
