import 'package:intl/intl.dart';

class NumberFormatHelper {
  static String numberFormat(int param) => new NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
}