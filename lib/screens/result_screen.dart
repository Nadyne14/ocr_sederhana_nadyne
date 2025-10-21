import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResultScreen extends StatefulWidget {
  final String ocrText;

  const ResultScreen({super.key, required this.ocrText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
  }

  Future<void> _initTts() async {
    // 🔹 Set bahasa ke Bahasa Indonesia
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setSpeechRate(0.5); // kecepatan bicara sedang
    await flutterTts.setPitch(1.0);
  }

  // 🔹 Fungsi untuk membacakan teks hasil OCR
  Future<void> _speak() async {
    if (widget.ocrText.isEmpty) return;
    await flutterTts.speak(widget.ocrText);
  }

  @override
  void dispose() {
    // 🔹 Hentikan suara saat halaman ditutup
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil OCR')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(
            widget.ocrText.isEmpty ? 'Tidak ada teks ditemukan.' : widget.ocrText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      // 🔹 FloatingActionButton untuk memutar suara
      floatingActionButton: FloatingActionButton(
        heroTag: 'ttsButton',
        onPressed: _speak,
        child: const Icon(Icons.volume_up),
      ),
    );
  }
}
