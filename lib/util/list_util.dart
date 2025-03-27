extension ListUtil<T> on List<T> {
  T? next(int currentIndex) {
    if (currentIndex + 1 < length) {
      return this[currentIndex + 1]; // Get the next value
    } else {
      return null;
    }
  }

  T? prev(int currentIndex) {
    if (currentIndex - 1 >= 0) {
      return this[currentIndex + 1]; // Get the next value
    } else {
      return null;
    }
  }
}
