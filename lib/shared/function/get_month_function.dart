String getMonth(int month, {bool isSingkat = false}) {
  if (month == 1) {
    return isSingkat ? 'Jan' : 'Januari';
  } else if (month == 2) {
    return isSingkat ? 'Feb' : 'Februari';
  } else if (month == 3) {
    return isSingkat ? 'Mar' : 'Maret';
  } else if (month == 4) {
    return isSingkat ? 'Apr' : 'April';
  } else if (month == 5) {
    return 'Mei';
  } else if (month == 6) {
    return isSingkat ? 'Jun' : 'Juni';
  } else if (month == 7) {
    return isSingkat ? 'Jul' : 'Juli';
  } else if (month == 8) {
    return isSingkat ? 'Agu' : 'Agustus';
  } else if (month == 9) {
    return isSingkat ? 'Sep' : 'September';
  } else if (month == 10) {
    return isSingkat ? 'Okt' : 'Oktober';
  } else if (month == 11) {
    return isSingkat ? 'Nov' : 'November';
  } else if (month == 12) {
    return isSingkat ? 'Des' : 'Desember';
  } else {
    return '';
  }
}
