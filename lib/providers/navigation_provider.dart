import 'package:flutter/material.dart';
import 'package:matlob/ui/categories/categories_screen.dart';
import 'package:matlob/ui/my_chats/my_chats_screen.dart';
import 'package:matlob/ui/add_ad/add_ad_screen.dart';
import 'package:matlob/ui/favourite/favourite_screen.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:matlob/ui/notification/notification_screen.dart';

class NavigationProvider extends ChangeNotifier {
  int _navigationIndex = 0;

  void upadateNavigationIndex(int value) {
    _navigationIndex = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;

  List<Widget> _screens = [
    HomeScreen() ,
    CategoriesScreen(),
    AddAdScreen(),
    NotificationScreen(),
    MyChatsScreen()
  ];

  Widget get selectedContent => _screens[_navigationIndex];

  bool _mapIsActive = false;

  void setMapIsActive(bool value) {
    _mapIsActive = value;
    notifyListeners();
  }

  bool get mapIsActive => _mapIsActive;
}
