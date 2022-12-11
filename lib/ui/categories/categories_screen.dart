
import 'package:matlob/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/ui/section_ads/section_ads_screen.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/custom_widgets/ad_item/ad_item.dart';
import 'package:matlob/custom_widgets/no_data/no_data.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/models/category.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/ui/ad_details/ad_details_screen.dart';
import 'package:matlob/ui/home/widgets/category_item.dart';
import 'package:matlob/ui/home/widgets/map_widget.dart';
import 'package:matlob/ui/search/search_bottom_sheet.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/error.dart';

import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/ui/home/cats_screen.dart';

class CategoriesScreen extends StatefulWidget {


  CategoriesScreen();
  @override
  State<StatefulWidget> createState() {
    return new _CategoriesScreenState();
  }
}


class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  double _height = 0, _width = 0;

  Future<List<CategoryModel>> _categoryList;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  AnimationController _animationController;
  AuthProvider _authProvider;
  Future<List<CategoryModel>> _subList;


  _CategoriesScreenState();

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

      //_homeProvider.updateSelectedCategory(iddd1);
      _categoryList = _homeProvider.getCategoryList1(enableSub: false);

      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");


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
        Container(
            height: _height,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(5,15,10,0),
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
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {

                                print(snapshot.data[index].catId);
                                _subList = _homeProvider.getSubList(enableSub: true,catId:snapshot.data[index].catId);
                                return Consumer<HomeProvider>(

                                    builder: (context, homeProvider, child) {
                                      return InkWell(


                                        child: Container(
                                          width: _width,
                                          height: _height*.70,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    color: mainAppColor,
                                                    child: Image.network(snapshot.data[index].catImage,color: Colors.white,width: _width*.1,height: _width*.1,),
                                                    padding: EdgeInsets.all(10),

                                                  ),
                                                  Padding(padding: EdgeInsets.all(5)),
                                                  Container(

                                                    child: Text(snapshot.data[index].catName,style: TextStyle(
                                                        color: Colors.black,fontSize: snapshot.data[index].catName.length > 1 ?18 : 18
                                                    ),

                                                      overflow: TextOverflow.clip,
                                                      maxLines: 1,),
                                                    width: _width*.7,
                                                  ),
                                                ],
                                              ),

                                              Container(
                                                height: 2,
                                                color: Color(0xffFBFBFB),
                                              ),

                                              Padding(padding: EdgeInsets.all(10)),


                                              FutureBuilder<List<CategoryModel>>(
                                                future: _subList,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.hasData) {

                                                      return Container(
                                                        height: _height-_height*.41,
                                                        child: GridView.builder(
                                                          itemCount: snapshot.data.length,
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio: (6 / 5),
                                                            crossAxisSpacing: 25,
                                                            mainAxisSpacing: 25,
                                                          ),
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return Consumer<HomeProvider>(
                                                                builder: (context, homeProvider, child) {
                                                                  return InkWell(
                                                                    onTap: (){
                                                                      _homeProvider.setCurrentCatId(snapshot.data[index].catParent);
                                                                      print("sssssssssssssssssssssss");
                                                                      print(snapshot.data[index].catId);
                                                                      print("sssssssssssssssssssssss");
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => SectionAdsScreen(
                                                                                catId: _homeProvider.currentCatId,
                                                                                subId: snapshot.data[index].catId,
                                                                                adCatName: snapshot.data[index].catName,
                                                                              )));

                                                                    },
                                                                    child: Container(
                                                                      height: _height*.3,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Image.network(snapshot.data[index].catImage,height: _width*.18,),
                                                                          Text(snapshot.data[index].catName)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                      );

                                                    } else if (snapshot.hasError) {
                                                      return Text("${snapshot.error}");
                                                    }
                                                  } else if (snapshot.hasError) {
                                                    return Text("${snapshot.error}");
                                                  }

                                                  return Center(child: CircularProgressIndicator());
                                                },
                                              )

                                            ],
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







      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);

    final appBar = AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: _authProvider.currentLang == 'ar' ? Text("اختر القسم",style: TextStyle(fontSize: 18,color: Colors.black),) :Text("Select category",style: TextStyle(fontSize: 18)),



    );
    _height =  MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyItem(),

      ),
    );
  }
}
