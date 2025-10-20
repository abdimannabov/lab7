import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UZS Currency Rates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: CurrencyHomePage(),
    );
  }
}

class CurrencyHomePage extends StatefulWidget {
  @override
  State<CurrencyHomePage> createState() => _CurrencyHomePageState();
}

class _CurrencyHomePageState extends State<CurrencyHomePage> {
  final _dateController = TextEditingController();
  final _currencyController = TextEditingController(text: 'all');
  List<dynamic> _currencies = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> fetchRates() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _currencies = [];
    });

    try {
      final date = _dateController.text.trim();
      final code = _currencyController.text.trim().toUpperCase();

      // Build the proper endpoint
      String url = 'https://cbu.uz/ru/arkhiv-kursov-valyut/json/';
      if (date.isNotEmpty && code.isNotEmpty) {
        url += '$code/$date/';
      } else if (date.isNotEmpty) {
        url += 'all/$date/';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _currencies = data is List ? data : [data];
        });
      } else {
        setState(() => _errorMessage = 'Failed: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Rates (CBU)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Date (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _currencyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Currency Code (USD, RUB, all)',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchRates,
              child: const Text('Fetch Rates'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errorMessage != null)
              Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red))
            else if (_currencies.isEmpty)
              const Text('No data yet.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _currencies.length,
                  itemBuilder: (context, index) {
                    final item = _currencies[index];
                    return ListTile(
                      title: Text(item['CcyNm_RU'] ?? 'No name'),
                      subtitle: Text('Code: ${item['Ccy']}'),
                      trailing: Text('${item['Rate']} UZS'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _currencyController.dispose();
    super.dispose();
  }
}
