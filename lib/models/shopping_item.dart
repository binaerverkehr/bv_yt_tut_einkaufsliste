
class ShoppingItem {
  final String name;
  bool done;

  ShoppingItem({
    required this.name,
    required this.done,
  });

  void setDone(newValue) {
    this.done = newValue;
  }

  ShoppingItem copyWith({
    String? name,
    bool? done,
  }) {
    return ShoppingItem(
      name: name ?? this.name,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingItem && other.name == name && other.done == done;
  }

  @override
  int get hashCode => name.hashCode ^ done.hashCode;
}
