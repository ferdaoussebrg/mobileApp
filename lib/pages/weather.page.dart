import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String _ville = 'Rabat'; // par défaut
  String _temp = '0';
  String _weatherDescription = 'Unknown';
  String _hum = '0';
  String _pressure = '0';
  String _pays = 'MA'; // Code ISO du pays (Maroc par exemple)

  String _weatherIcon = 'assets/sun.jpg'; // Par défaut
  bool _isLoading = true;

  final String _apiKey = '064de5450d646439947ff36a7c2e81f9';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  // récupérer les data
  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$_ville&appid=$_apiKey&units=metric&lang=fr'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _temp = data['main']['temp'].toString(); // Température
          _weatherDescription = data['weather'][0]['description']; // Description météo
          _hum = data['main']['humidity'].toString(); // Humidité
          _pressure = data['main']['pressure'].toString(); // Pression
          _pays = data['sys']['country'].toString(); //pays (code ISO)

          _updateWeatherIcon(_weatherDescription);
          _isLoading = false;
        });
      } else {
        setState(() {
          _weatherDescription = 'Erreur de récupération des données';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _weatherDescription = 'Erreur réseau';
        _isLoading = false;
      });
    }
  }

  void _updateWeatherIcon(String description) {
    print('Description météo reçue : $description');
    description = description.toLowerCase();
    setState(() {
      if (description.contains('clear') || description.contains('ensoleillé')) {
        _weatherIcon = 'assets/sun.jpg';
      } else if (description.contains('cloud') || description.contains('nuage')) {
        _weatherIcon = 'assets/cloud.png';
      } else if (description.contains('rain') || description.contains('pluie')) {
        _weatherIcon = 'assets/rain.jpg';
      } else if (description.contains('storm') || description.contains('orage')) {
        _weatherIcon = 'assets/storm.jpg';
      } else if (description.contains('snow') || description.contains('neige')) {
        _weatherIcon = 'assets/snow.jpg';
      } else {
        _weatherIcon = 'assets/sun.jpg'; // Icône par défaut
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Générer l'URL du drapeau
    String flagUrl = 'https://flagsapi.com/$_pays/flat/64.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherApp'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Afficher un indicateur de chargement
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Afficher le drapeau
            Image.network(
              flagUrl,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 50, color: Colors.red);
              },
            ),
            const SizedBox(height: 20),
            // Afficher l'icône de la météo
            Image.asset(_weatherIcon, height: 100, errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 150, color: Colors.red);
            }),
            const SizedBox(height: 20),
            // Description de la météo
            Text(
              _weatherDescription,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // Row pour aligner les 3 icônes sur une même ligne
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône de température avec GestureDetector pour afficher la valeur
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Température'),
                          content: Text('$_temp°C'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Fermer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.thermostat, // Icône de thermomètre standard
                    size: 50, // Taille de l'icône
                    color: Colors.blue, // Couleur de l'icône
                  ),
                ),
                const SizedBox(width: 20), // Espacement entre les icônes
                // Icône d'humidité avec GestureDetector pour afficher la valeur
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Humidité'),
                          content: Text('$_hum%'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Fermer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.water_drop, // Icône représentant l'humidité
                    size: 50, // Taille de l'icône
                    color: Colors.blue, // Couleur de l'icône
                  ),
                ),
                const SizedBox(width: 20), // Espacement entre les icônes
                // Icône de pression avec GestureDetector pour afficher la valeur
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pression'),
                          content: Text('$_pressure hPa'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Fermer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.compress, // Icône représentant la pression
                    size: 50, // Taille de l'icône
                    color: Colors.blue, // Couleur de l'icône
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Champ de texte pour changer de ville
            TextField(
              decoration: const InputDecoration(
                labelText: 'Entrez une ville',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String value) {
                setState(() {
                  _ville = value;
                  _isLoading = true;
                });
                fetchWeatherData();
              },
            ),
          ],
        ),
      ),
    );
  }
}