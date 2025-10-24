import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'scan_result_screen.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _hasScanned = false;

  void _fetchProductInfo(String barcode) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.105:5000/scan/barcode-info'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'barcode': barcode}),
      );

      if (response.statusCode == 200) {
        final product = jsonDecode(response.body);
        final productName = product['name'] ?? 'Unknown Product';

        // Save to backend
        await http.post(
          Uri.parse('http://192.168.1.105:5000/scan/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'barcode': barcode,
            'email': 'aymane@gmail.com',
            'product_name': productName,
          }),
        );

        // Navigate to result screen (but don't auto-redirect anywhere after)
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScanResultScreen(product: product),
          ),
        );

        setState(() => _hasScanned = false);
      } else {
        _showError('Product not found or server error.');
      }
    } catch (e) {
      _showError('Connection error: $e');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _hasScanned = false);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E8),
      appBar: AppBar(
        title: const Text('Scan Moroccan Product', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF426850),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                ),
                onDetect: (capture) {
                  if (!_hasScanned && capture.barcodes.isNotEmpty) {
                    final String code = capture.barcodes.first.rawValue ?? '';
                    if (code.isNotEmpty) {
                      setState(() => _hasScanned = true);
                      _fetchProductInfo(code);
                    }
                  }
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Point your camera at a barcode to scan',
              style: TextStyle(
                color: Color(0xFF426850),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
