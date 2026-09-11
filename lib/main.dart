import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Country',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ctrl = TextEditingController();
  String _result = "Ready to scan";
  String _hash = "";
  void _scan() {
    if (_ctrl.text.isEmpty) return;
    var h = sha256.convert(utf8.encode(_ctrl.text)).toString();
    setState(() {
      _hash = h;
      _result = _ctrl.text.toLowerCase().contains("scam") ? "⚠️ SUSPECT" : "✅ SAFE - Clean";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clean Country - Safe Scan"), backgroundColor: Colors.green, foregroundColor: Colors.white, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.verified_user, size: 80, color: Colors.green),
            const SizedBox(height: 10),
            const Text("SUSPECT SAFE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _ctrl, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Enter text or link", prefixIcon: Icon(Icons.search))),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _scan, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text("SCAN NOW")),
            const SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(_hash, style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
