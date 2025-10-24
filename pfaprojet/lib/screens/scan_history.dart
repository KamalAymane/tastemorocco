import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScanHistoryScreen extends StatefulWidget {
  @override
  _ScanHistoryScreenState createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  List<dynamic> history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.105:5000/scan/history?email=aymane@gmail.com'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          history = data['history'];
          isLoading = false;
        });
      } else {
        print('Failed to load history');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Widget buildHistoryCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFEFEBE9),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF426850),
          child: const Icon(Icons.qr_code, color: Colors.white),
        ),
        title: Text(
          item['product_name'] ?? 'Unknown Product',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF426850),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Barcode: ${item['barcode']}'),
            Text('Scanned: ${item['scanned_at']?.substring(0, 10) ?? 'N/A'}'),
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E8),
      appBar: AppBar(
        title: const Text('Scan History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF426850),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : history.isEmpty
          ? const Center(child: Text('No scanned products yet.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) => buildHistoryCard(history[index]),
      ),
    );
  }
}
