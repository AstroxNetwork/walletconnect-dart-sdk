class Event<T> {
  final String name;
  final T data;

  Event(this.name, this.data);

  @override
  String toString() {
    return 'Event(name: $name, data: $data)';
  }
}
