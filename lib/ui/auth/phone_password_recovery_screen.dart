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
class PhonePasswordRecoveryScreen extends StatefulWidget {
  @override
  _PhonePasswordRecoveryScreenState createState() => _PhonePasswordRecoveryScreenState();
}

class _PhonePasswordRecoveryScreenState extends 
State<PhonePasswordRecoveryScreen>  with ValidationMixin{
 double _height = 0 , _width = 0;
 ApiProvider _apiProvider = ApiProvider();
 AuthProvider _authProvider;
 bool _isLoading = false;
 String _userPhone ='';
 final _formKey = GlobalKey<FormState>();

Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      
          SizedBox(
            height: _height*.55,
          ),



          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
            child:   Text(AppLocalizations.of(context).translate('password_recovery'),style: TextStyle(color: mainAppColor),),
          ),

          CustomTextFormField(
                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/call.png',
                hintTxt: AppLocalizations.of(context).translate('phone_no'),
                onChangedFunc: (text){
                  _userPhone = text;
                },
                   validationFunc: validateUserPhone
              ),
          
           SizedBox(
             height: _height *0.02,
           ),
          _buildRetrievalCodeBtn()
          
          
         
        
       
        ],
      ),
    ),
  );
}


 Widget _buildRetrievalCodeBtn() {
    return _isLoading
        ? Center(
            child:SpinKitFadingCircle(color: mainAppColor),
          )
        :  CustomButton(
           btnLbl: AppLocalizations.of(context).translate('send_recovery_code'),
           onPressedFunction: () async {
              
             if(_formKey.currentState.validate()){
                 setState(() {
                    _isLoading = true;
                  });
                 final results = await _apiProvider
                      .post(Urls.PASSSWORD_RECOVERY_URL +"?api_lang=${_authProvider.currentLang}", body: {
                    "user_phone":  _userPhone,
               
                   
                  });
               
            setState(() => _isLoading = false);
                  if (results['response'] == "1") {
_authProvider.setUserPhone(_userPhone);
                      Navigator.pushNamed(context,   '/code_activation_screen');
                      
                  } else {
                    Commons.showError(context, results["message"]);
                
                  }
         
             } 
           },
         );
         }
  @override
  Widget build(BuildContext context) {
         _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
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
        ],
      )
      ),
    );
  }
}