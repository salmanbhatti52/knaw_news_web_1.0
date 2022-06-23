import 'package:flutter/material.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/dimensions.dart';
Widget container(Widget textField)

{
  return    Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              //  color:Colors.white
              BoxShadow(
                color:Colors.white,
                offset: Offset(0,0),
                blurRadius: 300,
                //   spreadRadius: 2
              )]
        ),
        child: textField
    ),
  );

}


openLoadingDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
              width: 140,
              height: 60,
              //padding: EdgeInsets.only(left:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 1, valueColor: AlwaysStoppedAnimation(Colors.black))),
              SizedBox(width: 10),
              Text(AppData().isLanguage?AppData().language!.loading:text,style: TextStyle(color: Colors.black54,fontSize: Dimensions.fontSizeDefault,decoration: TextDecoration.none,fontWeight: FontWeight.normal),)
            ]),
          ),
        );




  }
  );
}


openMessageDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Column(
          children: <Widget>[
            Text(text),
            Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 0,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ));
}
