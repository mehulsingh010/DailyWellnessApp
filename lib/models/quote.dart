class Quote {
  final int id;
  final String author;
  final String body;
  final List<String> tags;
  final String url;
  final int favoritesCount;
  final int upvotesCount;
  final int downvotesCount;

  Quote({
    required this.id,
    required this.author,
    required this.body,
    required this.tags,
    required this.url,
    required this.favoritesCount,
    required this.upvotesCount,
    required this.downvotesCount,
  });

  // Simple constructor for basic usage
  Quote.simple({required this.author, required this.body})
    : id = 0,
      tags = [],
      url = '',
      favoritesCount = 0,
      upvotesCount = 0,
      downvotesCount = 0;

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] ?? 0,
      author: json['author'] ?? 'Unknown',
      body: json['body'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      url: json['url'] ?? '',
      favoritesCount: json['favorites_count'] ?? 0,
      upvotesCount: json['upvotes_count'] ?? 0,
      downvotesCount: json['downvotes_count'] ?? 0,
    );
  }
}
