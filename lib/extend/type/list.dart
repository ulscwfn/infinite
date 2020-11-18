/// List 类型扩展
extension ListTExt<T> on List<T> {
  /// 返回满足条件的第一个元素（没有则返回null）
  T find(bool Function(T item) condition) {
    T value;
    try {
      value = firstWhere(condition);
    } catch (e) {
      value = null;
    }
    return value;
  }
}
