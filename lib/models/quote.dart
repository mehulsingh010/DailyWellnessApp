class Quote {
  final int id;
  final String author;
  final String body;

  Quote({required this.id, required this.author, required this.body});

  // Simple constructor for basic usage
  Quote.simple({required this.author, required this.body}) : id = 0;

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] ?? 0,
      author: json['author'] ?? 'Unknown',
      body: json['body'] ?? '',
    );
  }
}
