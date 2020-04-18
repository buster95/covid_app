formatNumber(int number) {
  String dec = number.toString();
  StringBuffer aux = new StringBuffer();
  if (dec.length > 3) {
    int cont = 0;
    for (var i = dec.length - 1; i >= 0; i--) {
      if (cont == 3) {
        aux.write(",${dec[i]}");
        cont = 0;
      } else {
        aux.write(dec[i]);
      }
      cont++;
    }
    return reverseString(aux.toString());
  } else {
    return dec;
  }
}

reverseString(String str) {
  StringBuffer word = StringBuffer();
  for (var x = str.length - 1; x > -1; x--) {
    word.write(str[x]);
  }
  return word.toString();
}
