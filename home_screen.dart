import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  double _qrSize = 200.0;
  String _qrData = '';

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _qrData = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _textController.clear();
    setState(() {
      _qrData = '';
      _qrSize = 200.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.brightness_6, size: 20),
                const SizedBox(width: 8),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: widget.onThemeChanged,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter the link',
                      hintText: 'https://example.com',
                      prefixIcon: Icon(Icons.link),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Put the link. This box can not be empty';
                      }
                      if (v.length > 250) {
                        return 'Text is very long';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(_qrData),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _qrData.isEmpty
                    ? SizedBox(
                        height: _qrSize,
                        width: _qrSize,
                        child: const Center(
                          child: Text(
                            'Here will be your QR-code',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: _qrSize,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: colorScheme.primary,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: colorScheme.primary,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Size of the QR-code: ${_qrSize.toInt()} px'),
            Slider(
              min: 100.0,
              max: 300.0,
              value: _qrSize,
              onChanged: (newSize) {
                setState(() {
                  _qrSize = newSize;
                });
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _resetForm,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}