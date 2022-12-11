import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/models/user.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/shared_preferences/shared_preferences_helper.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:matlob/custom_widgets/MainDrawer.dart';
import 'dart:math' as math;

class EditPasswordScreen extends StatefulWidget {
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> with ValidationMixin {
  double _height = 0, _width = 0;
     final _formKey = GlobalKey<FormState>();
      AuthProvider _authProvider;
      ApiProvider _apiProvider=  ApiProvider();
      String _oldPassword = '',_newPassword ='';

 bool _isLoading = false;

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Container(
        height: _height,
        width: _width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              CustomTextFormField(
                isPassword: true,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/key.png',
                hintTxt: AppLocalizations.of(context).translate('old_password'),
                onChangedFunc: (text){
                  _oldPassword =text;
                },
                validationFunc: validatePassword
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                child: CustomTextFormField(
                  isPassword: true,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/key.png',
                  hintTxt: AppLocalizations.of(context).translate('new_password'),
                     onChangedFunc: (text){
                  _newPassword =text;
                },
                  validationFunc: validatePassword
                ),
              ),
              CustomTextFormField(
                isPassword: true,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/key.png',
                hintTxt:  AppLocalizations.of(context).translate('confirm_new_password'),
                validationFunc: validateConfirmPassword
              ),
              Spacer(),
              CustomButton(
                btnLbl: AppLocalizations.of(context).translate('save'),
                onPressedFunction: () async{
                             
if (_formKey.currentState.validate() 
){
setState(() => _isLoading = true);
                    FormData formData = new FormData.fromMap({
                      "user_id": _authProvider.currentUser.userId,
                      "user_name":  _authProvider.currentUser.userName,        
                      "user_phone" : _authProvider.currentUser.userPhone,
                      "user_email":  _authProvider.currentUser.userEmail,
                      "old_pass":_oldPassword,
                      "user_pass":_newPassword,
                      "user_pass_confirm":_newPassword,
                     "user_country":_authProvider.currentUser.userCountry,
                    
                    });
                    final results = await _apiProvider
                        .postWithDio(Urls.PROFILE_URL+ "?api_lang=${_authProvider.currentLang}", body: formData);
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
                }
              
              ),
              SizedBox(
                height: _height * 0.02,
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
      title:Text(AppLocalizations.of(context).translate('edit_password'),style: TextStyle(fontSize: 15,color: omarColor),),
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
