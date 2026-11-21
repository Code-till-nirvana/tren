String foldText(String s) {
  const from = 'áàâäãåąéèêëęíìîïıóòôöõőøúùûüűñńçćčłśşšźżžğýÿёيكةأإآ';
  const to = 'aaaaaaaeeeeeiiiiiooooooouuuuunnccclssszzzgyyеیکهااا';
  final b = StringBuffer();
  for (final r in s.toLowerCase().runes) {
    final c = String.fromCharCode(r);
    final i = from.indexOf(c);
    b.write(i < 0 ? c : to[i]);
  }
  return b.toString();
}
