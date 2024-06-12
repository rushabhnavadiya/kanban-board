import 'package:flutter/material.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return "Required Field";
    // return S.of(context!).required_field;
  }

  @override
  bool validate(String value) {
    return value.isNotEmpty;
  }
}