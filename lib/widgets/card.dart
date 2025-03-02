import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';


class CurrencyCardSection extends StatelessWidget {
  final String title;
  final String currency;
  final String Function(String) getCountryCode;

  const CurrencyCardSection({
    super.key,
    required this.title,
    required this.currency,
    required this.getCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[700])),
        Divider(color: Colors.grey.withOpacity(0.5), thickness: 2),
        Row(
          children: [
            CountryFlag.fromCountryCode(shape: Circle(),
              getCountryCode(currency),
              height: 25,
              width: 35,
            ),
            const SizedBox(width: 10),
            Text(currency,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}