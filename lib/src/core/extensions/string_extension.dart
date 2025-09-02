extension StringExtension on String {
  String firstUpper() {
    if (isEmpty) return "";

    return this[0].toUpperCase() + substring(1);
  }
}
