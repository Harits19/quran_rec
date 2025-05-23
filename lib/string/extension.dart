extension StringExtension on String {
  String toArabicNumber() {
    const westernToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return split('').map((char) {
      return westernToArabicDigits[char] ?? char;
    }).join();
  }

  String capitalize() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}
