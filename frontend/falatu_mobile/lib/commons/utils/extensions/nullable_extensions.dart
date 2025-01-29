extension NullableExtension<T> on T? {
  R? let<R>(R Function(T) callback) {
    if (this != null) {
      return callback(this as T);
    }
    return null;
  }
}