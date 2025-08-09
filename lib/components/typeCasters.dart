
Map<String, dynamic> deepCastMap(Map<dynamic, dynamic> map) {
  return map.map((key, value) {
    if (value is Map) {
      return MapEntry(key.toString(), deepCastMap(value));
    } else if (value is List) {
      return MapEntry(
        key.toString(),
        value.map((e) {
          if (e is Map) return deepCastMap(e as Map);
          return e;
        }).toList(),
      );
    } else {
      return MapEntry(key.toString(), value);
    }
  });
}