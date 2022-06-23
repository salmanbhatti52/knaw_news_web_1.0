import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';

class LanguageCard extends StatelessWidget {
  String icon;
  String title;
  void Function()? onTapSelect;
  LanguageCard({Key? key, required this.icon,required this.title,this.onTapSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toUpperCase(),style: openSansBold.copyWith(color: Colors.black,),),
              GestureDetector(
                onTap: onTapSelect,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppData().language!.currentLanguage==title?Colors.black:Colors.amber
                  ),
                  child: Center(child: Text(AppData().language!.currentLanguage==title?AppData().language!.selected:AppData().language!.select,style: openSansBold.copyWith(color:Colors.white),)),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).disabledColor.withOpacity(0.5),
          width: MediaQuery.of(context).size.width*0.9,
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 1,
        ),
      ],
    );
  }
}
