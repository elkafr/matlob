import 'package:flutter/material.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/utils/urls.dart';

class AboutAppProvider extends ChangeNotifier{
   ApiProvider _apiProvider = ApiProvider();
 String _currentLang;


  void update(AuthProvider authProvider) {
 
    _currentLang = authProvider.currentLang;
  }
  Future<String> getAboutApp() async {
    final response =
        await _apiProvider.get(Urls.ABOUT_APP_URL +"?api_lang=$_currentLang");
    String aboutApp = '';
    if (response['response'] == '1') {
      aboutApp = response['messages'];
    }
    return aboutApp;
  }
}