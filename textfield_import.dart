import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  //
  AppTextField({
    this.controller,
    this.textInputType,
    this.hintText,
    this.helpText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixtText,
    this.isPassword,
    this.enabled,
    this.onEditingComplete,
    this.onSaved,
    this.readOnly,
    this.textInputAction,
    this.textCapitalization,
    this.validator,
    // this.borderColor,
  });
  final FormFieldValidator validator;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String hintText;
  final String helpText;
  final String labelText;
  final String suffixtText;
  final VoidCallback onEditingComplete;
  final FormFieldSetter onSaved;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  //final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(
          hintColor: Colors.blue,
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: TextFormField(
            autofocus: true,
            cursorColor: Colors.green,
            cursorWidth: 2.0,
            controller: controller,
            keyboardType: textInputType,
            readOnly: null == readOnly ? false : true,
            obscureText: null == isPassword ? false : true,
            onEditingComplete: onEditingComplete,
            onSaved: onSaved,
            style: TextStyle(height: 1.2),
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            validator: validator,
            // Decoration
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 2.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  // color: null == borderColor ? Colors.teal : borderColor,
                  width: 1.0,
                ),
              ),
              labelText: null == labelText ? '' : labelText,
              hintText: null == hintText ? '' : hintText,
              helperText: null == helpText ? '' : helpText,
              prefixIcon: null == prefixIcon
                  ? null
                  : Icon(prefixIcon, color: Colors.blue),
              prefixText: ' ',
              suffix: null == suffixIcon
                  ? null
                  : Icon(
                      suffixIcon,
                      color: Colors.blue,
                    ),
              suffixText: null == suffixtText ? '' : suffixtText,
              enabled: null == enabled ? true : false,
            ),
          ),
        ),
      ),
    );
  }
}
