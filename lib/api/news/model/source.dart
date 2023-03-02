class Source {
  final String? id;
  final String name;
  const Source._({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source._(id: json['id'], name: json['name']);
  }
}
