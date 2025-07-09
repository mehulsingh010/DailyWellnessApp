import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  static const String baseUrl = 'https://favqs.com/api/qotd';

  static Future<Quote> fetchQuote() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quoteData = data['quote'];
        if (quoteData != null) {
          return Quote.fromJson(quoteData);
        } else {
          throw Exception('No quote data found');
        }
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      // Return fallback quote on error
      return Quote.simple(
        body: 'Every day is a new opportunity to grow and improve.',
        author: 'Daily Wellness',
      );
    }
  }
}

// class QuoteService {
//   static Future<String> fetchQuote() async {
//     final url = Uri.parse('https://favqs.com/api/qotd');

//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       final quote = json['quote']['body'];
//       final author = json['quote']['author'];
//       return '"$quote"\n— $author';
//     } else {
//       throw Exception('Failed to load quote');
//     }
//   }
// }
