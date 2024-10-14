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
