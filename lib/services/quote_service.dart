import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  static const String baseUrl = 'https://favqs.com/api/qotd';

  static Future<Quote> fetchQuote() async {
    try {
      final response = await http
          .get(
            Uri.parse(baseUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
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
