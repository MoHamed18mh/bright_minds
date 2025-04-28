import 'package:bright_minds/core/utils/app_strings.dart';

//  check if text form field is empty for validate
String? validatFields(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.thisFieldCannotBeEmpty;
  }
  return null;
}
