import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour les appels API

void main() => runApp(const MyApp());

//Main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My IDS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Désactiver la bannière debug
    );
  }
}

//Home Page
class HomePage exten:ds StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _backendResponse = 'Chargement...';

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://back:5000/api/data'));
      setState(() {
        _backendResponse = response.body;
      });
    } catch (e) {
      setState(() {
        _backendResponse = 'Erreur: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Application')),
      body: Center(
        child: Text(
          _backendResponse,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
