import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyExchangeService {
  Future<double> getExchangeRate({required String currency,required String baseCurrency}) async {
    final url = Uri.parse(
        'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_dxQSqZR5qyUcaFgLUbM9ssFsZI6kUIKzErOun2QN&currencies=$currency&base_currency=$baseCurrency');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'][currency] != null) {
        return (data['data'][currency] as num).toDouble();
      } else {
        throw Exception('Invalid currency or missing data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
