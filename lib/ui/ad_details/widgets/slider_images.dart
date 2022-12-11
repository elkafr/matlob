import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/utils/urls.dart';
import 'package:matlob/custom_widgets/carousel_slider/carousel_with_indicator1.dart';
import 'package:matlob/models/slider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/urls.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';

class SliderImages extends StatefulWidget {
  @override
  _SliderImagesState createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {
  // int _currentPageValue = 0;
  // int _previousPageValue = 0;
  // PageController _controller;
  ApiProvider _apiProvider = ApiProvider();
  bool _initialRun = true;
  double _height = 0, _width = 0;
  Future<List<SliderModel>> _sliderImages;

  HomeProvider _homeProvider;

  Future<List<SliderModel>> _getsliderImages() async {
    Map<String, dynamic> results = await _apiProvider.get(Urls.SLIDER_URL1+"ads_id="+_homeProvider.currentAds);
    List sliderList = List<SliderModel>();
    if (results['response'] == '1') {
      Iterable iterable = results['slider'];
      sliderList =
          iterable.map((model) => SliderModel.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sliderList;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // _controller = PageController(initialPage: _currentPageValue);
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);
      _sliderImages = _getsliderImages();
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return  FutureBuilder<List<SliderModel>>(
            future: _sliderImages,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            return Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
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
                                                snapshot.data[index].photo,
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
                                    snapshot.data[index].photo,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                            );
                          });
                    });
                // return Stack(
                //   alignment: AlignmentDirectional.bottomCenter,
                //   children: <Widget>[
                //     PageView.builder(
                //       physics: ClampingScrollPhysics(),
                //       itemCount: snapshot.data.length,
                //       onPageChanged: (int page) {
                //         getChangedPageAndMoveBar(page);
                //       },
                //       controller: _controller,
                //       itemBuilder: (context, index) {
                //         return Column(
                //           children: <Widget>[
                //             Container(
                //               margin: EdgeInsets.symmetric(
                //                   horizontal:
                //                       MediaQuery.of(context).size.width * 0.02),
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.all(
                //                   const Radius.circular(10.00),
                //                 ),
                //               ),
                //               child: Center(
                //                 child: Image.network(
                //                   snapshot.data[index].photo,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             Container(
                //                 margin: EdgeInsets.only(top: 5),
                //                 child: DotsIndicator(
                //                   dotsCount: snapshot.data.length,
                //                   position: _currentPageValue.toDouble(),
                //                   decorator: DotsDecorator(
                //                     size: const Size(24.0, 5.0),
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(3.0)),
                //                     activeSize: const Size(24.0, 5.0),
                //                     activeColor: cAccentColor,
                //                     color: Color(0xffEEEEEE),
                //                     activeShape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(3.0),
                //                     ),
                //                   ),
                //                 )),
                //           ],
                //         );
                //       },
                //     ),
                //   ],
                // );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(
                  child: SpinKitSquareCircle(color: mainAppColor, size: 25));
            });
  }

  // void getChangedPageAndMoveBar(int page) {
  //   print('page is $page');

  //   _currentPageValue = page;

  //   if (_previousPageValue == 0) {
  //     _previousPageValue = _currentPageValue;
  //   } else {
  //     if (_previousPageValue < _currentPageValue) {
  //       _previousPageValue = _currentPageValue;
  //     } else {
  //       _previousPageValue = _currentPageValue;
  //     }
  //   }

  //   setState(() {});
  // }
}
