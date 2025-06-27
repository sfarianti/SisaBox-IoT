import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File? _imageFile; // untuk mobile
  XFile? _xfile;    // untuk web
  String _result = '';
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  final String _apiKey = 'AIzaSyDLov6DLYI4EsKClmNCpG91kmcNrKdI_nY'; 
  final Color greenColor = const Color(0xFF00C853); 

  Future<void> _getImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 70);
    if (picked == null) return;

    setState(() {
      _xfile = picked;
      _imageFile = !kIsWeb ? File(picked.path) : null;
      _result = '';
    });

    await _analyzeImage(picked);
  }

  Future<void> _analyzeImage(XFile file) async {
    setState(() {
      _loading = true;
    });

    try {
      final Uint8List imageBytes = await file.readAsBytes();

      final model = GenerativeModel(
        model: 'gemini-1.5-flash', 
          apiKey: _apiKey,
      );


      final content = [
        Content.multi([
          TextPart(
              'Analisis gambar ini dan jelaskan jenis sampahnya (organik atau anorganik), dan berikan tips untuk mendaur ulangnya dalam bahasa Indonesia.'),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await model.generateContent(content);
      setState(() {
        _result = response.text ?? 'Tidak ada hasil.';
      });
    } catch (e) {
      setState(() {
        _result = 'Gagal menganalisis: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: Colors.white,
    onPressed: () {
      Navigator.pop(context); 
    },
  ),
  title: const Text('Scan Sampah'),
  backgroundColor: greenColor,
  foregroundColor: Colors.white,
  centerTitle: true,
),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_xfile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: kIsWeb
                    ? Image.network(
                        _xfile!.path,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _imageFile!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              )
            else
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: greenColor),
                ),
                child: const Center(
                  child: Text('Belum ada gambar', style: TextStyle(color: Colors.grey)),
                ),
              ),

            const SizedBox(height: 16),

            if (_loading)
              const CircularProgressIndicator()
            else if (_result.isNotEmpty)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _result,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Kamera"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text("Galeri"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
