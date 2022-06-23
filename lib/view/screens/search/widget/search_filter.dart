import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/screens/search/widget/date_widget.dart';
import 'package:knaw_news/view/screens/search/widget/filter_type.dart';
import 'package:intl/intl.dart';

class SearchFilter extends StatefulWidget {
  String order;
  String tag;
  String loc;
  String datePreset;
  bool isCustom;
  int selected;
  Function(String tagFilter,String dateFilter,int selected,String orderBy,String location,String dateRange,bool isCustomDate)? applyFilter;
  SearchFilter({Key? key,this.applyFilter,this.tag="",this.selected=-1,this.order="DESC",this.loc="",this.datePreset="",this.isCustom=false}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  int selectedTag=0;
  int selectedDate=0;
  String dateType="";
  String location="";
  bool isDate=false;
  String tag="";
  String date="";
  String order="";
  DateTime current=DateTime.now();
  String month = DateFormat("MMM,yyyy").format(DateTime.now());
  String now = DateFormat("dd").format(DateTime.now());
  int index=-1;
  List<String> tagList=["Most Commented","Saddest","Most Popular","Happiest"];
  List<String> dateList=["Any Time","Past Hour","Past 24 Hours","Past Week","Past Month","Past Year","Custom Range",];
  TextEditingController _locationController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order=widget.order;
    if(widget.selected>0){
      index=widget.selected;
    }
    if(widget.tag.isNotEmpty){
      tag=widget.tag;
      selectedTag=tagList.indexOf(widget.tag)+1;
    }
    if(widget.loc.isNotEmpty){
      location=widget.loc;
      _locationController.text=widget.loc;
    }
    if(widget.datePreset.isNotEmpty){
      dateType=widget.datePreset;
      selectedDate=dateList.indexOf(widget.datePreset)+1;
    }
    isDate=selectedDate==7;
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:
      // isPickDate?
      //     Container(
      //       height: MediaQuery.of(context).size.height,
      //       width: MediaQuery.of(context).size.width*0.7,
      //       child: DatePickerDialog(
      //         initialEntryMode: DatePickerEntryMode.calendarOnly,
      //         confirmText: "Ok",
      //           cancelText: "Cancel",
      //           currentDate: DateTime.now(),
      //           initialDate: DateTime.now(),
      //           firstDate: DateTime(2020),
      //           lastDate: DateTime.now(),
      //       ),
      //     )
      //     :
      Container(
        width: MediaQuery.of(context).size.width*0.7,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 10,right: 10,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(Images.close),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppData().language!.filters,style: openSansBold.copyWith(color:Colors.black),),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.01,bottom: MediaQuery.of(context).size.height*0.01),
                        child: Text(AppData().language!.dateFilter,style: openSansBold.copyWith(color: Colors.black87),),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: 5),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            FilterType(title: AppData().language!.anyTime,isSelected: selectedDate==1,onTap: (){dateType="Any Time";selectedDate=1;setState(() {});}),
                            FilterType(title: AppData().language!.pastHour,isSelected: selectedDate==2,onTap: (){dateType="Past Hour";selectedDate=2;setState(() {});}),
                            FilterType(title: AppData().language!.past24Hour,isSelected: selectedDate==3,onTap: (){dateType="Past 24 Hours";selectedDate=3;setState(() {});}),
                            FilterType(title: AppData().language!.pastWeek,isSelected: selectedDate==4,onTap: (){dateType="Past Week";selectedDate=4;setState(() {});}),
                            FilterType(title: AppData().language!.pastMonth,isSelected: selectedDate==5,onTap: (){dateType="Past Month";selectedDate=5;setState(() {});}),
                            FilterType(title: AppData().language!.pastYear,isSelected: selectedDate==6,onTap: (){dateType="Past Year";selectedDate=6;setState(() {});}),
                            FilterType(title: AppData().language!.customRange,isSelected: selectedDate==7,onTap: (){dateType="Custom Range";selectedDate=7;setState(() {});}),
                          ],
                        ),
                      ),

                      selectedDate==7?Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: (){
                                  current=current.add(Duration(days: -30));
                                  month=DateFormat("MMM,yyyy").format(current);
                                  setState(() {

                                  });
                                },
                                child: Icon(Icons.arrow_left,size: 30,color: Colors.amber,)
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(month,style: openSansBold.copyWith(color: Colors.black),)
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  current=current.add(Duration(days: 30));
                                  month=DateFormat("MMM,yyyy").format(current);
                                  setState(() {

                                  });
                                },
                                child: Icon(Icons.arrow_right,size: 30,color: Colors.amber,)
                            ),
                          ],
                        ),
                      ):SizedBox(),

                      selectedDate==7?SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),

                          child: Row(
                            children: [
                              for(int i=1;i<31;i++)
                                DateItem(date: i.toString().length==1?"0"+i.toString():i.toString(),isActive: i==index?true:false,
                                  onTap: (){
                                    date=DateFormat("yyyy-MM").format(current);
                                    date=date+"-"+(i.toString().length==1?"0"+i.toString():i.toString());
                                    setState(() {
                                      index==i?index=-1:index=i;
                                    });

                                  },
                                ),


                            ],
                          ),
                        ),
                      ):SizedBox(),

                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,top: 5),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            FilterType(title: AppData().language!.mostCommented,isSelected: selectedTag==1?true:false,onTap: (){tag="Most Commented";selectedTag=1;setState(() {});}),
                            FilterType(title: AppData().language!.gloomiest,isSelected: selectedTag==2?true:false,onTap: (){tag="Saddest";selectedTag=2;setState(() {});}),
                            FilterType(title: AppData().language!.trending,isSelected: selectedTag==3?true:false,onTap: (){tag="Most Popular";selectedTag=3;setState(() {});}),
                            FilterType(title: AppData().language!.happiest,isSelected: selectedTag==4?true:false,onTap: (){tag="Happiest";selectedTag=4;setState(() {});}),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.01,bottom: MediaQuery.of(context).size.height*0.01),
                        child: Text(AppData().language!.orderBy,style: openSansBold.copyWith(color: Colors.black87),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.09),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FilterType(title: AppData().language!.ascending,isSelected: order=="ASC"?true:false,onTap: (){order="ASC";setState(() {});}),
                            FilterType(title: AppData().language!.descending,isSelected: order=="DESC"?true:false,onTap: (){order="DESC";setState(() {});}),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.01,),
                        child: Text(AppData().language!.location,style: openSansBold.copyWith(color: Colors.black87),),
                      ),

                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.6,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: _locationController,
                          style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).primaryColor,
                          autofocus: false,
                          decoration: InputDecoration(
                            focusColor: const Color(0XF7F7F7),
                            hoverColor: const Color(0XF7F7F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            isDense: true,
                            hintText: AppData().language!.location,
                            fillColor: Color(0XFFF0F0F0),
                            hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.6,
                        margin: EdgeInsets.only(top: 10),
                        child: TextButton(
                          onPressed: (){
                            print(date+tag+order);
                            location=_locationController.text;
                            widget.applyFilter!(tag,date,index,order,location,dateType,selectedDate==7);
                            Get.back();
                          },
                          style: flatButtonStyle,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(AppData().language!.apply, textAlign: TextAlign.center, style: openSansBold.copyWith(
                              color: textBtnColor,
                              fontSize: Dimensions.fontSizeDefault,
                            )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
