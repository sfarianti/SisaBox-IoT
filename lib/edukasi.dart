import 'package:flutter/material.dart';
import '../widgets/navbar.dart'; 

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  final List<Map<String, String>> articles = const [
    {
      'title': 'Bank Sampah: Inovasi Daur Ulang Ramah Lingkungan',
      'image': 'assets/edukasi/bank-sampah.jpg',
      'source': 'mojok.co',
    },
    {
      'title': 'Sampah Organik vs Anorganik',
      'image': 'assets/edukasi/sampah.jpg',
      'source': 'republika',
    },
    {
      'title': 'Sampah Organik Bisa Jadi Kompos, Yuk Mulai dari Langkah Kecil!',
      'image': 'assets/edukasi/kompos.jpg',
      'source': 'REPUBLIKA',
    },
    {
      'title': 'Plastik & Kaleng Termasuk Sampah Anorganik, Apa Solusinya?',
      'image': 'assets/edukasi/anorganik.jpg',
      'source': 'KOMPAS TV',
    },
    {
      'title': 'Meski Ditutup, Warga Masih Buang Sampah di TPS Gedong KIM',
      'image': 'assets/images/edukasi5.jpg',
      'source': 'InfoPBBUN',
    },
    {
      'title': 'Kendeng Komunitas Ulang Sampah. Rumah Sakit Tanggapi Baik Manajemen Zero Waste',
      'image': 'assets/images/edukasi6.jpg',
      'source': 'LIPUTAN 6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarBottom(currentIndex: 1),
      appBar: AppBar(
        title: const Text('Materi Edukasi'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // search feature
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: articles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // dua kolom
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final article = articles[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    article['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title']!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article['source']!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}