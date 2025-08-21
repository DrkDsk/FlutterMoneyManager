import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get monthName {
    return [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ][month - 1];
  }

  String get dayName {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  String dateFormat({String? format = 'dd/MM/yyyy'}) {
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(this);

    return formatted;
  }
}
