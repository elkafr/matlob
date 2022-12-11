import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen>
    with ValidationMixin {
  double _height = 0, _width = 0;
  String _password = '';
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: _height *0.05),
              child:  Image.asset('assets/images/fullcall.png',height:_height *0.2 ,),
            ),



            SizedBox(
              height: 80,
            ),



            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
              child:   Text(_authProvider.currentLang=="ar"?"تغيير كلمة المرور":"Change Password",style: TextStyle(color: Colors.white),),
            ),


            CustomTextFormField(
                isPassword: true,
                suffixIconIsImage: true,
                onChangedFunc: (String text) {
                  _password = text;
                },
                suffixIconImagePath: 'assets/images/key.png',
                hintTxt:  AppLocalizations.of(context).translate('new_password'),
                validationFunc: validatePassword),
            SizedBox(
              height: _height * 0.02,
            ),
            CustomTextFormField(
                isPassword: true,
                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/key.png',
                hintTxt : AppLocalizations.of(context).translate('confirm_new_password'),
                validationFunc: validateConfirmPassword),
            SizedBox(
              height: 50,
            ),

            _buildConfirmBtn()
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmBtn() {
    return _isLoading
        ? Center(
            child: SpinKitFadingCircle(color: mainAppColor),
          )
        : CustomButton(
            btnLbl: AppLocalizations.of(context).translate('confirm'),
            onPressedFunction: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  _isLoading = true;
                });
                final results = await _apiProvider
                    .post(Urls.UPDATE_PASSWORD_URL +"?api_lang=${_authProvider.currentLang}", body: {
                  "code": _authProvider.activationCode,
                  "password": _password
                });

                setState(() => _isLoading = false);
                if (results['response'] == "1") {
                  Commons.showToast(context,
                      message: results["message"], color: mainAppColor);
                  Navigator.pushNamed(context, '/login_screen');
                } else {
                  Commons.showError(context, results["message"]);
                }
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.fill,
            height: _height,
            width: _width,
          ),
          _buildBodyItem(),
          Container(

              height: 60,

              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  IconButton(
                    icon: Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return authProvider.currentLang == 'ar' ? Image.asset(
                          'assets/images/left.png',
                          color: Colors.white,
                        ): Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Image.asset(
                              'assets/images/left.png',
                              color: Colors.white,
                            ));
                      },
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),



                ],
              )),
        ],
      )),
    );
  }
}
