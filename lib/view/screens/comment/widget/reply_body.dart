import 'package:flutter/material.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';

class ReplyBody extends StatelessWidget {
  String? text;
  String? timeAgo;
  ReplyBody({this.text,this.timeAgo,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Icon(Icons.favorite,color: Colors.red,size: 15,),
          Wrap(
            children: [
              Text(text??'',style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(timeAgo??'',style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black.withOpacity(0.5)),),
          //     //Text("Views replies ("+totalReplies.toString()+")",style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black.withOpacity(0.5)),),
          //
          //   ],
          // )
        ],
      ),
    );
  }

}

