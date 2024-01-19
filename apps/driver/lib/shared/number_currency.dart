import 'package:intl/intl.dart';

String intlNumberCurrency(dynamic value) {
  if (value == null || value == "") {
    return "";
  }
  return NumberFormat.simpleCurrency(locale: 'id_ID').format(value);
}
