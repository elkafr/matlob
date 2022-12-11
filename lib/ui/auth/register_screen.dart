
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';
import 'package:matlob/custom_widgets/custom_selector/custom_selector.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:matlob/custom_widgets/dialogs/confirmation_dialog.dart';
import 'package:matlob/custom_widgets/safe_area/page_container.dart';
import 'package:matlob/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:matlob/locale/app_localizations.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/home_provider.dart';
import 'package:matlob/providers/register_provider.dart';
import 'package:matlob/providers/terms_provider.dart';
import 'package:matlob/ui/auth/widgets/select_country_bottom_sheet.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:matlob/ui/account/active_account_screen.dart';
import 'dart:math' as math;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  RegisterProvider _registerProvider;
  HomeProvider _homeProvider;
  bool _initalRun = true;
  bool _isLoading = false;
  ApiProvider _apiProvider = ApiProvider();
  TermsProvider _termsProvider = TermsProvider();
  String _userName = '', _userPhone = '', _userEmail = '', _userPassword = '', _userJob = '', _userWasf = '';


  List<String> _userType;
  String _selectedUserType;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initalRun) {

      _registerProvider = Provider.of<RegisterProvider>(context);
      _homeProvider = Provider.of<HomeProvider>(context);
      _registerProvider.getCountryList();
      _userType =["العميل", "مقدم خدمة"];
      _termsProvider.getTerms();
    }
  }

  Widget _buildBodyItem() {

    var userType= _userType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height*.33,
            ),






            Container(

              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
              child:   Text(AppLocalizations.of(context).translate('register'),style: TextStyle(color: mainAppColor),),
            ),

            CustomTextFormField(
              suffixIconIsImage: true,
              suffixIconImagePath: 'assets/images/user.png',
              hintTxt: AppLocalizations.of(context).translate('user_name'),
              validationFunc: validateUserName,
              onChangedFunc: (text) {
                _userName = text;
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/call.png',
                hintTxt: AppLocalizations.of(context).translate('phone_no'),
                validationFunc: validateUserPhone,
                onChangedFunc: (text) {
                  _userPhone = text;
                },
              ),
            ),
            CustomTextFormField(
              suffixIconIsImage: true,
              suffixIconImagePath: 'assets/images/mail.png',
              hintTxt:AppLocalizations.of(context).translate('email'),
              validationFunc: validateUserEmail,
              onChangedFunc: (text) {
                _userEmail = text;
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _width * 0.07, vertical: _height * 0.02),
              height: 50,
              width: _width,

              child: InkWell(
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (builder) {
                        return SelectCountryBottomSheet();
                      });
                },
                child: CustomSelector(
                  title: Consumer<RegisterProvider>(
                      builder: (context, registerProvider, child) {
                    return Text(
                        registerProvider.userCountry != null
                            ? registerProvider.userCountry.countryName
                            : "المدينة",
                        style: TextStyle(
                            fontSize: 14,
                            color: registerProvider.userCountry != null
                                ?hintColor
                                : hintColor));
                  }),
                  icon: Image.asset('assets/images/city.png'),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(

                marg: .07,
                dropDownList: userType,
                hint: "نوعية التسجيل",
                onChangeFunc: (newValue) {

                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _homeProvider.setUserType(newValue);
                    _selectedUserType = newValue;
                     print(_homeProvider.userType);
                  });
                },
                value: _selectedUserType,
              ),
            ),
            ( _homeProvider.userType=="مقدم خدمة" )?SizedBox(height: _width*.02,):Text("",style: TextStyle(height: 0),),



            ( _homeProvider.userType=="مقدم خدمة" )?CustomTextFormField(

              hintTxt: "المهنة",
              validationFunc: validateUserName,
              onChangedFunc: (text) {
                _userJob = text;
              },
            ):Text("",style: TextStyle(height: 0),),

            ( _homeProvider.userType=="مقدم خدمة" )?SizedBox(height: _width*.04,):Text("",style: TextStyle(height: 0),),


            ( _homeProvider.userType=="مقدم خدمة" )?CustomTextFormField(
              hintTxt: "وصف تسويقي",
              maxLines: 6,
              validationFunc: validateUserName,
              onChangedFunc: (text) {
                _userWasf = text;
              },
            ):Text("",style: TextStyle(height: 0),),
            SizedBox(height: _width*.04,),

            Container(
              margin: EdgeInsets.only(bottom: _height * 0.02),
              child: CustomTextFormField(
                isPassword: true,
                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/key.png',
                hintTxt: AppLocalizations.of(context).translate('password'),
                validationFunc: validatePassword,
                onChangedFunc: (text) {
                  _userPassword = text;
                },
              ),
            ),
            CustomTextFormField(
              isPassword: true,
              suffixIconIsImage: true,
              suffixIconImagePath: 'assets/images/key.png',
              hintTxt:  AppLocalizations.of(context).translate('confirm_password'),
              validationFunc: validateConfirmPassword,
            ),

            SizedBox(height: 15,),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: _height * 0.01, horizontal: _width * 0.07),
                child: Row(
                  children: <Widget>[
                    Consumer<RegisterProvider>(
                        builder: (context, registerProvider, child) {
                      return GestureDetector(
                        onTap: () => registerProvider
                            .setAcceptTerms(!registerProvider.acceptTerms),
                        child: Container(
                          width: 25,
                          height: 25,
                          child: registerProvider.acceptTerms
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 17,
                                )
                              : Container(),
                          decoration: BoxDecoration(
                            color: registerProvider.acceptTerms
                                ? Color(0xffA8C21C)
                                : Colors.white,
                            border: Border.all(
                              color: registerProvider.acceptTerms
                                  ? Color(0xffA8C21C)
                                  : hintColor,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) {
                                  return ConfirmationDialog(
                                    title: AppLocalizations.of(context).translate('rules_and_terms'),
                                    message: "موافق على الشروط والاحكام",
                                  );
                                });
                          },
                          child: RichText(

                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Cairo',
                                  color: mainAppColor),
                              children: <TextSpan>[
                                TextSpan(text:  AppLocalizations.of(context).translate('accept_to_all')),
                                TextSpan(text: ' '),
                                TextSpan(
                                    text: AppLocalizations.of(context).translate('rules_and_terms'),
                                    style:  TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Cairo',
                                        color: Color(0xffA8C21C))),
                              ],
                            ),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: 15,),
            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('make_account'),
              onPressedFunction: () async {
           
                if (_formKey.currentState.validate()) {
                  if (_registerProvider.userCountry != null) {
                    if (_registerProvider.acceptTerms) {
                      setState(() {
                        _isLoading = true;
                      });
                      final results =
                          await _apiProvider.post(Urls.REGISTER_URL, body: {
                            "user_name":_userName,
                        "user_phone": _userPhone,
                        "user_pass": _userPassword,
                        "user_pass_confirm":_userPassword,
                        "user_country":_registerProvider.userCountry.countryId,
                        "user_email":_userEmail,
                        "user_job":_userJob,
                        "user_wasf":_userWasf,
                            "user_type":_homeProvider.userType
                      });

                      setState(() => _isLoading = false);
                      if (results['response'] == "1") {
                        _register();
                      } else {
                        Commons.showError(context, results["message"]);
                      }
                    } else {
                      Commons.showToast(context,
                          message:  AppLocalizations.of(context).translate('accept_rules_and_terms'),color: Colors.red);
                    }
                  } else {
                    Commons.showToast(context, message: AppLocalizations.of(context).translate('country_validation'));
                  }
                }
              },
            ),



          ],
        ),
      ),
    );
  }

  _register() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return ConfirmationDialog(
            title:  AppLocalizations.of(context).translate('account_has created_successfully'),
            message:  AppLocalizations.of(context).translate('account_has created_successfully_use_app_now'),
          );
        });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[

          Image.asset(
            'assets/images/splash1.png',
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
                          color: mainAppColor,
                        ): Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Image.asset(
                              'assets/images/left.png',
                              color: mainAppColor,
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
              : Container()
        ],
      )),
    );
  }
}
