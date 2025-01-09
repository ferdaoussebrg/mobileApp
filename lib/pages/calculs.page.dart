import 'package:flutter/material.dart';

class CalculsPage extends StatefulWidget {
  const CalculsPage({Key? key}) : super(key: key);

  @override
  State<CalculsPage> createState() => _CalculsPageState();
}

class _CalculsPageState extends State<CalculsPage> {
  final TextEditingController _nombre1Controller = TextEditingController();
  final TextEditingController _nombre2Controller = TextEditingController();
  String _operation = '+';
  double? _resultat;

  void _calculer() {
    final double? nombre1 = double.tryParse(_nombre1Controller.text);
    final double? nombre2 = double.tryParse(_nombre2Controller.text);

    if (nombre1 == null || nombre2 == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Veuillez saisir des nombres valides.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      switch (_operation) {
        case '+':
          _resultat = nombre1 + nombre2;
          break;
        case '-':
          _resultat = nombre1 - nombre2;
          break;
        case '*':
          _resultat = nombre1 * nombre2;
          break;
        case '/':
          if (nombre2 == 0) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Erreur'),
                content: const Text('La division par zéro est impossible.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            _resultat = null; // Annuler le calcul si division par zéro
          } else {
            _resultat = nombre1 / nombre2;
          }
          break;
        default:
          _resultat = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Entrez deux nombres et choisissez une opération à effectuer :',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nombre1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nombre 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nombre2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nombre 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _operation,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: '+', child: Text('Addition (+)')),
                DropdownMenuItem(value: '-', child: Text('Soustraction (-)')),
                DropdownMenuItem(value: '*', child: Text('Multiplication (*)')),
                DropdownMenuItem(value: '/', child: Text('Division (/)')),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _calculer,
              icon: const Icon(Icons.calculate),
              label: const Text('Calculer'),
            ),
            const SizedBox(height: 16),
            if (_resultat != null)
              Text(
                'Résultat : $_resultat',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}