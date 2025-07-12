import 'package:intl/intl.dart';

String getDay(String date) {
  String rawData =
      DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(date));

  String finalData = '';

  switch (rawData.toLowerCase()) {
    case 'monday':
      finalData = 'Senin';
      break;
    case 'tuesday':
      finalData = 'Selasa';
      break;
    case 'wednesday':
      finalData = 'Rabu';
      break;
    case 'thursday':
      finalData = 'Kamis';
      break;
    case 'friday':
      finalData = "Jum'at";
      break;
    case 'saturday':
      finalData = 'Sabtu';
      break;
    case 'sunday':
      finalData = 'Minggu';
      break;

    default:
  }

  return finalData;
}

String dateToReadable(String date) {
  String finalString = '';

  List<String> breakDate = date.split('-');

  finalString = "${breakDate[2]} ";

  switch (breakDate[1]) {
    case '01':
      finalString = '${finalString}Jan';
      break;
    case '02':
      finalString = '${finalString}Feb';
      break;
    case '03':
      finalString = '${finalString}Mar';
      break;
    case '04':
      finalString = '${finalString}Apr';
      break;
    case '05':
      finalString = '${finalString}Mei';
      break;
    case '06':
      finalString = '${finalString}Jun';
      break;
    case '07':
      finalString = '${finalString}Jul';
      break;
    case '08':
      finalString = '${finalString}Agu';
      break;
    case '09':
      finalString = '${finalString}Sep';
      break;
    case '10':
      finalString = '${finalString}Okt';
      break;
    case '11':
      finalString = '${finalString}Nov';
      break;
    case '12':
      finalString = '${finalString}Des';
      break;
    default:
  }

  finalString = "$finalString ${breakDate[0]}";

  return finalString;
}
