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

  Map<TKey, List<T>> groupBy<TKey>({required TKey Function(T) groupBy}) {
    final List<T> source = this;

    final Map<TKey, List<T>> result = {};

    for (final ayah in source) {
      final key = groupBy(ayah);
      if (key == null) continue;

      final List<T> values = [...(result[key] ?? [])];
      values.add(ayah);

      result[key] = values;
    }

    return result;
  }
}
