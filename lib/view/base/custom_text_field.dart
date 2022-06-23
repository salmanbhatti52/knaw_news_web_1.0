import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';


class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  //final FocusNode focusNode;
  //final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  //final Function onChanged;
  //final Function onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String prefixIcon;
  final bool divider;

  CustomTextField(
      {this.hintText = 'Write something...',
      required this.controller,
      //this.focusNode,
      //this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.prefixIcon=Images.logo,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false,
        //this.onChanged,
        //this.onSubmit
      }
  );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          //focusNode: widget.focusNode,
          style: openSansBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            focusColor: const Color(0XF7F7F7),
            hoverColor: const Color(0XF7F7F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: Color(0XBBF0F0F0),
            hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            filled: true,

            prefixIcon: widget.prefixIcon != null ? Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              child: Image.asset(widget.prefixIcon, height: 10, width: 20,color: Get.isDarkMode ? Colors.white : Colors.black),
            ) : null,
            // suffixIcon: widget.isPassword ? GestureDetector(
            //   child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,size: 20, color: Theme.of(context).hintColor.withOpacity(0.3)),
            //   onTap: _toggle,
            // ) : null,
          ),
          // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          //     : widget.onSubmit != null ? widget.onSubmit(text) : null,
          // onChanged: widget.onChanged,
        ),

        //widget.divider ? Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider()) : SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
