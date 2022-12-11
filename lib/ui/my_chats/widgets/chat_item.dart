import 'package:flutter/material.dart';
import 'package:matlob/models/chat_message.dart';
import 'package:matlob/networking/api_provider.dart';
import 'package:matlob/providers/auth_provider.dart';
import 'package:matlob/providers/received_msgs_provider.dart';
import 'package:matlob/ui/auth/login_screen.dart';
import 'package:matlob/ui/chat/chat_screen.dart';
import 'package:matlob/ui/my_chats/my_chats_screen.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:matlob/utils/commons.dart';
import 'package:matlob/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:matlob/custom_widgets/buttons/custom_button.dart';

class ChatItem extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final ChatMessage chatMessage;

  const ChatItem(
      {Key key, this.animationController, this.animation, this.chatMessage})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  ApiProvider _apiProvider = ApiProvider();
  ReceivedMsgsProvider _receivedMsgsProvider;
  AuthProvider _authProvider ;
  String messageValue;

  @override
  Widget build(BuildContext context) {
    _receivedMsgsProvider = Provider.of<ReceivedMsgsProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: widget.animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 50 * (1.0 - widget.animation.value), 0.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(


                      child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          margin: EdgeInsets.only(
                              left: constraints.maxWidth * 0.04,
                              right: constraints.maxWidth * 0.04,
                              bottom: constraints.maxHeight * 0.1),
                          decoration: BoxDecoration(


                            border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1)),
                            color: Colors.white,


                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03),
                                    child: CircleAvatar(
                                      radius: constraints.maxHeight * 0.25,
                                      backgroundImage: NetworkImage(
                                          widget.chatMessage.messageSenderImage),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.chatMessage.messageSender,
                                            style: TextStyle(
                                                color: mainAppColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                          GestureDetector(
                                            onTap: (){

                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("محتوى الرسالة"),
                                                    content: Text(
                                                      widget.chatMessage.messageContent,
                                                      style: TextStyle(
                                                          color: omarColor,
                                                          fontWeight: FontWeight.w700,

                                                          fontSize: 18),
                                                    ),

                                                  );
                                                },
                                              );



                                            },
                                            child: Text(
                                              widget.chatMessage.messageTitle,
                                              style: TextStyle(
                                                  color: omarColor,
                                                  fontWeight: FontWeight.w700,

                                                  fontSize: 18),
                                              maxLines: 2,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: constraints.maxHeight * 0.02),
                                            child: Row(
                                              children: <Widget>[

                                                Text(
                                                  widget.chatMessage.messageDate,
                                                  style: TextStyle(
                                                      color: hintColor, fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.02),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            child: Text("رد",style: TextStyle(color: Colors.white,fontSize: 17),),
                                            color: mainAppColor,
                                            alignment: Alignment.center,
                                            width: 45,
                                          ),
                                          onTap: (){

                                            if(_authProvider.currentUser!=null){

                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,

                                                  builder: (context) {

                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[

                                                            Padding(padding: EdgeInsets.all(15)),
                                                            Container(

                                                              child: Text("رسالة خاصة",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                                            ),
                                                            Padding(padding: EdgeInsets.all(15)),
                                                            Container(

                                                              child: CustomTextFormField(
                                                                maxLines: 4,
                                                                hintTxt: "محتوى الرسالة",

                                                                onChangedFunc: (text) async{
                                                                  messageValue = text;
                                                                },
                                                              ),

                                                            ),

                                                            CustomButton(
                                                              btnColor: mainAppColor,
                                                              btnLbl:"ارسال",
                                                              onPressedFunction: () async{

                                                                if(messageValue!=null) {

                                                                  final results = await _apiProvider
                                                                      .post(Urls.SEND_URL , body: {
                                                                    "message_sender": _authProvider.currentUser.userId,
                                                                    "message_recever": widget.chatMessage.senderUserId,
                                                                    "message_title": "رد : "+widget.chatMessage.messageContent,
                                                                    "message_content": messageValue,
                                                                    "message_type": "message",
                                                                  });


                                                                  if (results['response'] == "1") {
                                                                    Commons.showToast(context, message: results["message"]);
                                                                    Navigator.pop(context);
                                                                  } else {
                                                                    Commons.showError(context, results["message"]);
                                                                  }

                                                                }else{
                                                                  Commons.showError(context, "يجب ادخال الرسالة");
                                                                }

                                                              },
                                                            ),

                                                            Padding(padding: EdgeInsets.all(10)),




                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });

                                            }else{
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            }


                                          },
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            _receivedMsgsProvider.setIsLoading(true);
                                            final results = await _apiProvider
                                                .get(Urls.DELETE_MESSAGE_URL +"?user1_id=${widget.chatMessage.senderUserId}&user_id=${_authProvider.currentUser.userId}");
                                            _receivedMsgsProvider.setIsLoading(false);

                                            if (results['response'] == "1") {
                                              Commons.showToast(context,
                                                  message: results["message"]);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MyChatsScreen()));
                                            } else {
                                              Commons.showError(
                                                  context, results["message"]);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey[400],
                                            size: constraints.maxHeight * 0.2,
                                          ),
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    );
                  })));
        });
  }
}
