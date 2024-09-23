import 'package:flutter/material.dart';

class Punto1Page extends StatefulWidget {
  const Punto1Page({super.key});

  @override
  State<Punto1Page> createState() => _Punto1PageState();
}

class _Punto1PageState extends State<Punto1Page> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';

  // Lista de monedas: USD, EUR y COP
  final List<String> _currencies = ['USD', 'EUR', 'COP'];

  Future<void> _convertCurrency() async {
    String amount = _amountController.text;
    if (amount.isEmpty) {
      setState(() {
        _result = 'Ingrese una cantidad válida.';
      });
      return;
    }

    double amountDouble = double.parse(amount);
    double rate = await _getExchangeRate(_fromCurrency, _toCurrency);
    double convertedAmount = amountDouble * rate;

    setState(() {
      _result =
      '${amount} $_fromCurrency = ${convertedAmount.toStringAsFixed(2)} $_toCurrency';
    });
  }

  // Actualiza las tasas de cambio con USD, EUR, y COP
  Future<double> _getExchangeRate(String from, String to) async {
    if (from == 'USD' && to == 'EUR') return 0.85;
    if (from == 'USD' && to == 'COP') return 4000.0;
    if (from == 'EUR' && to == 'USD') return 1.18;
    if (from == 'EUR' && to == 'COP') return 4700.0;
    if (from == 'COP' && to == 'USD') return 0.00025;
    if (from == 'COP' && to == 'EUR') return 0.00021;
    // Si no se encuentra la tasa, retorna 1.0 por defecto
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Monedas'),
        backgroundColor: Colors.green[300],
      ),
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  items: _currencies
                      .map((currency) => DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  ))
                      .toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  items: _currencies
                      .map((currency) => DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}


