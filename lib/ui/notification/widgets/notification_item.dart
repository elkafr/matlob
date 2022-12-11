import 'package:flutter/material.dart';
import 'package:matlob/models/notification_message.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:flutter_html/flutter_html.dart';

class NotificationItem extends StatelessWidget {
    final AnimationController animationController;
  final Animation animation;
  final NotificationMsg notificationMsg;
  final bool enableDivider ;

  const NotificationItem({Key key, this.animationController, this.animation, 
  this.notificationMsg,  this.enableDivider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child:LayoutBuilder(
            builder: (context,constraints){
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight *0.5,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

      Container(
        margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth *0.02),

      ),
                      Container(

                        height: constraints.maxHeight ,
                        width: constraints.maxWidth *0.8,
                        child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Container(
                              width: constraints.maxWidth *0.60,
                            child: Html(data: notificationMsg.messageContent),),
                           Container(
                             alignment: Alignment.centerLeft,
                             child:  Text(notificationMsg.messageDate ,style: TextStyle(
                                 color:hintColor ,fontSize: 14
                             ),),
                           ),


                          ],
                        ),
                      ),

      ],
                    ),
                  ),
                Divider(
             height: constraints.maxHeight *0.05,
                  thickness: 1.2,
                  color: Colors.grey[300],
                ),

                ],
              );
            }
    )));
    }
    );

  }
}