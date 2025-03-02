import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String value;
  final List<String> currencies;
  final Function(String?) onChanged;
  final String Function(String) getCountryCode;

  const CurrencyDropdown({
    super.key,
    required this.value,
    required this.currencies,
    required this.onChanged,
    required this.getCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButton<String>(
        value: value,
        items: currencies.map((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CountryFlag.fromCountryCode(
                    shape: Circle(),
                    getCountryCode(currency),
                    height: 25,
                    width: 35,
                  ),
                ),
                const SizedBox(width: 10),
                Text(currency),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
