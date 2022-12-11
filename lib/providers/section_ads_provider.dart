import 'package:flutter/material.dart';
import 'package:matlob/models/ad.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/utils/urls.dart';

class SectionAdsProvider extends ChangeNotifier{

  String _currentLang;

  void update(AuthProvider authProvider) {
 
    _currentLang =  authProvider.currentLang;
  }
ApiProvider _apiProvider = ApiProvider();
    Future<List<Ad>> getAdsList(String catId,String subId) async {
    final response = await _apiProvider.get(
      Urls.ADS_SECTION_URL + "cat_id=$catId&sub_id=$subId&api_lang=$_currentLang"
      );
        List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }
}