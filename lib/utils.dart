extension NumberParsing on String {
  String jsonBody() {
    return substring(indexOf('{'));
  }
}
