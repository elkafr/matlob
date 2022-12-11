import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field1.dart';
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

class CodeActivationScreen extends StatefulWidget {
  @override
  _CodeActivationScreenState createState() => _CodeActivationScreenState();
}

class _CodeActivationScreenState extends State<CodeActivationScreen>
    with ValidationMixin {
  double _height = 0, _width = 0;
  bool _isLoading = false;
  String _activationCode1 = '';
  String _activationCode2 = '';
  String _activationCode3 = '';
  String _activationCode4 = '';
  String _activationCode5 = '';
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
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
              height: 50,
            ),




            Container(
              margin: EdgeInsets.only(bottom: _height * 0.02),
              child: Text(
                
              AppLocalizations.of(context).translate('enter_the_code_sent_on_phone_to_retrieve_password'),
                style: TextStyle(color: Color(0xffC5C5C5), fontSize: 14),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
              child: Row(
                children: <Widget>[
                  Container(

                    width: _width*.17,
                    child: CustomTextFormField1(

                      onChangedFunc: (text) {
                        _activationCode1 = text;
                      },
                     inputData: TextInputType.numberWithOptions(decimal: false),
                      maxLength: 1,
                      enableHorizontalMargin: true,

                    ),
                  ),
                  Container(

                    width: _width*.17,
                    child: CustomTextFormField1(

                      onChangedFunc: (text) {
                        _activationCode2 = text;
                      },
                      inputData: TextInputType.numberWithOptions(decimal: false),
                      maxLength: 1,
                      enableHorizontalMargin: true,

                    ),
                  ),
                  Container(

                    width: _width*.17,
                    child: CustomTextFormField1(

                      onChangedFunc: (text) {
                        _activationCode3= text;
                      },
                      inputData: TextInputType.numberWithOptions(decimal: false),
                      maxLength: 1,
                      enableHorizontalMargin: true,

                    ),
                  ),
                  Container(

                    width: _width*.17,
                    child: CustomTextFormField1(

                      onChangedFunc: (text) {
                        _activationCode4 = text;
                      },
                      inputData: TextInputType.numberWithOptions(decimal: false),
                      maxLength: 1,
                      enableHorizontalMargin: true,

                    ),
                  ),
                  Container(

                    width: _width*.17,
                    child: CustomTextFormField1(

                      onChangedFunc: (text) {
                        _activationCode5 = text;
                      },
                      inputData: TextInputType.numberWithOptions(decimal: false),
                      maxLength: 1,
                      enableHorizontalMargin: true,

                    ),
                  )
                ],
              ),

            ),
            SizedBox(
              height: 50,
            ),
            _buildRecoveryBtn(),
            
            
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
               Navigator.pop(context);
              },
              child: Text(_authProvider.currentLang=="ar"?"تغيير رقم الجوال":"Change phone",style: TextStyle(color: mainAppColor,fontSize: 14),),
            ),

            SizedBox(
              height: 20,
            ),


            _buildResendCodeBtn()
          ],
        ),
      ),
    );
  }

  Widget _buildRecoveryBtn() {
    return  CustomButton(
            btnLbl: AppLocalizations.of(context).translate('restore_now'),
            onPressedFunction: () async {
              print(_activationCode5+_activationCode4+_activationCode3+_activationCode2+_activationCode1);
              if (_formKey.currentState.validate()) {
                setState(() {
                  _isLoading = true;
                });
                final results =
                    await _apiProvider.post(Urls.CHECK_CODE_URL + "?api_lang=${_authProvider.currentLang}", body: {
                  "code": _activationCode5+_activationCode4+_activationCode3+_activationCode2+_activationCode1,
                });

                setState(() => _isLoading = false);
                if (results['response'] == "1") {
                  _authProvider.setActivationCode(_activationCode5+_activationCode4+_activationCode3+_activationCode2+_activationCode1);
                  Commons.showToast(context, message: results["message"],color: mainAppColor);
                  Navigator.pushNamed(context, '/new_password_screen');
                } else {
                  Commons.showError(context, results["message"]);
                }
              }
            },
          );
  }

  Widget _buildResendCodeBtn() {
    return GestureDetector(
            child: Text(AppLocalizations.of(context).translate('Ididn’t_get_resend'),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
            onTap: () async {

              setState(() {
                _isLoading = true;
              });
              final results =
                  await _apiProvider.post(Urls.PASSSWORD_RECOVERY_URL + "?api_lang=${_authProvider.currentLang}", body: {
                "user_phone": _authProvider.userPhone,
              });

              setState(() => _isLoading = false);
              if (results['response'] == "1") {
                Commons.showToast(context, message: results["message"]);
              } else {
                Commons.showError(context, results["message"]);
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
        children: <Widget>[          Image.asset(
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
        _isLoading
        ? Center(
            child: SpinKitFadingCircle(color: mainAppColor),
          )
        :Container()
        ],
      )),
    );
  }
}
