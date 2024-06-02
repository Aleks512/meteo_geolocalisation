import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    try {
      // Vérifiez si les services de localisation sont activés
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Affiche un message à l'utilisateur si les services de localisation sont désactivés
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Services de localisation désactivés'),
              content: Text('Veuillez activer les services de localisation.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Vérifiez les permissions de localisation
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Affiche un message à l'utilisateur si les permissions sont refusées
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Permissions refusées'),
                content: Text('L\'accès à la localisation est nécessaire pour cette application.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Affiche un message à l'utilisateur si les permissions sont refusées de manière permanente
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permissions refusées de manière permanente'),
              content: Text('Veuillez autoriser l\'accès à la localisation dans les paramètres.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Obtenez la position actuelle
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position); // ici vous obtiendrez votre latitude et longitude

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Obtenez la localisation actuelle
            getLocation();
          },
          child: Text('GET Location'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(),
  ));
}
