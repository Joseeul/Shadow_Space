class Topic {
  int index;
  String title;

  Topic({
    required this.index,
    required this.title,
  });

  void reset() {
    index = 51;
    title = '';
  }
}
