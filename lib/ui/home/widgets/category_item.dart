import 'package:flutter/material.dart';
import 'package:matlob/models/category.dart';
import 'package:matlob/utils/app_colors.dart';
import 'package:matlob/utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
    final AnimationController animationController;
  final Animation animation;


  const CategoryItem({Key key, this.category, this.animationController, this.animation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color x;
    if(category.catId=="1"){
      x= mainAppColor;
    }else if(category.catId=="2"){
      x= Color(0xffEC90E9);
    }else if(category.catId=="3"){
      x= Color(0xff0096D5);
    }else if(category.catId=="4"){
      x= Color(0xffA076E8);
    }else if(category.catId=="0"){
      x= Color(0xff313131);
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: constraints.maxHeight *0.05),
            width: constraints.maxWidth *0.80,
            height: constraints.maxHeight *0.6,

            decoration: BoxDecoration(
              color: category.isSelected ?  mainAppColor : Color(0xff4C4C4C),
              border: Border.all(
                width: 1.0,
                color: category.isSelected ? mainAppColor: Color(0xffF3F3F3),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child:  category.catId != '0' ?
            ClipRRect(
    borderRadius: BorderRadius.all( Radius.circular(10.0)),
    child: Image.network(category.catImage,fit: BoxFit.none,cacheWidth: 37,cacheHeight: 34,)) :
            Icon(Icons.more_horiz,color: category.isSelected ?omarColor:Colors.white,),
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            alignment: Alignment.center,
            width: constraints.maxWidth,
            child: Text(category.catName,style: TextStyle(

              color: category.isSelected ?mainAppColor:Colors.black,fontSize: category.catName.length > 1 ?15 : 15,

            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,),
          ),

        ],
      );
    });
  }
}
