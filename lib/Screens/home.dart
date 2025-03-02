import 'package:currency_converter/services/currency_exhange_service.dart';
import 'package:currency_converter/widgets/card.dart';
import 'package:currency_converter/widgets/custom_textfield.dart';
import 'package:currency_converter/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double result = 0;
  final List<String> currencies = [
    "EUR",
    "USD",
    "JPY",
    "BGN",
    "CZK",
    "DKK",
    "GBP",
    "HUF",
    "PLN",
    "RON",
    "SEK",
    "CHF",
    "ISK",
    "NOK",
    "HRK",
    "RUB",
    "TRY",
    "AUD",
    "BRL",
    "CAD",
    "CNY",
    "HKD",
    "IDR",
    
    "INR",
    "KRW",
    "MXN",
    "MYR",
    "NZD",
    "PHP",
    "SGD",
    "THB",
    "ZAR",
  ];

  String fromCurrency = 'USD';
  String toCurrency = 'JPY';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEDED),
      body: SafeArea(
        top: true,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 8, 73, 126),
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.rotate(
                          angle: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: const Color(0xff145996),
                            ),
                            child: const Icon(
                              Icons.compare_arrows,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Currency Exchange',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Converter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CurrencyDropdown(
                              currencies: currencies,
                              getCountryCode: getCountryCode,
                              value: fromCurrency,
                              onChanged: (value) {
                                setState(() {
                                  fromCurrency = value!;
                                  result = 0;
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            const Icon(
                              size: 33,
                              Icons.sync_alt,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 20),
                            CurrencyDropdown(
                              currencies: currencies,
                              getCountryCode: getCountryCode,
                              value: toCurrency,
                              onChanged: (value) {
                                setState(() {
                                  toCurrency = value!;
                                  controller.clear();
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 250,
              left: 20,
              right: 20,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CurrencyCardSection(
                        title: 'From',
                        currency: fromCurrency,
                        getCountryCode: getCountryCode,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: controller,
                        onSubmitted: (value) async {
                          await CurrencyExchangeService()
                              .getExchangeRate(
                                  currency: toCurrency,
                                  baseCurrency: fromCurrency)
                              .then((rate) {
                            setState(() {
                              result = rate * double.parse(value);
                            });
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CurrencyCardSection(
                        title: 'To',
                        currency: toCurrency,
                        getCountryCode: getCountryCode,
                      ),
                      const SizedBox(height: 10),
                      Text(result.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCountryCode(String currency) {
    Map<String, String> currencyToCountry = {
      "EUR": "EU",
      "USD": "US",
      "JPY": "JP",
      "BGN": "BG",
      "CZK": "CZ",
      "DKK": "DK",
      "GBP": "GB",
      "HUF": "HU",
      "PLN": "PL",
      "RON": "RO",
      "SEK": "SE",
      "CHF": "CH",
      "ISK": "IS",
      "NOK": "NO",
      "HRK": "HR",
      "RUB": "RU",
      "TRY": "TR",
      "AUD": "AU",
      "BRL": "BR",
      "CAD": "CA",
      "CNY": "CN",
      "HKD": "HK",
      "IDR": "ID",
      
      "INR": "IN",
      "KRW": "KR",
      "MXN": "MX",
      "MYR": "MY",
      "NZD": "NZ",
      "PHP": "PH",
      "SGD": "SG",
      "THB": "TH",
      "ZAR": "ZA",
    };
    return currencyToCountry[currency] ?? 'US';
  }
}
