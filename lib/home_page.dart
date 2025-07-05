import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color greenColor = const Color(0xFF00C853);
  User? user;
  int _poin = 0;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    ambilPoinDariFirestore();
  }

  Future<void> ambilPoinDariFirestore() async {
    if (user == null) return;
    final docRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null && doc['poin'] != null) {
      setState(() {
        _poin = doc['poin'];
      });
    } else {
      await docRef.set({'poin': 0});
      setState(() {
        _poin = 0;
      });
    }
  }

  Future<void> simpanPoinKeFirestore(int poinBaru) async {
    if (user == null) return;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'poin': poinBaru,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ?? user?.email ?? 'Pengguna';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const NavbarBottom(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Hijau
              Container(
                padding: const EdgeInsets.all(16),
                color: greenColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Halo!,', style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text(
                          displayName,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Text('#001 🥇', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://unsplash.com/photos/vibrant-red-flowers-blossom-against-a-dark-background-KRXKpCDHH5I',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Poin
              PositionedCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.stars, color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('POINT', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$_poin'),
                      ],
                    ),
                    const Spacer(),
                    const Text('Tap for history', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  await simpanPoinKeFirestore(100); // contoh penyimpanan poin
                  ambilPoinDariFirestore();
                },
                child: const Text('Simpan Poin 100 ke Firestore'),
              ),

              const SizedBox(height: 16),

              const PositionedCard(
                child: Column(
                  children: [
                    Text('belum waktunya',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    SizedBox(height: 8),
                    Text('Sampah belum di daur ulang!'),
                    SizedBox(height: 8),
                    Text('SisaBox', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: InfoCard(title: "Suhu")),
                    SizedBox(width: 16),
                    Expanded(child: InfoCard(title: "Kelembaban")),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Berita
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Edukasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    NewsCard(
                      source: 'republika',
                      title: 'Sampah Organik vs Anorganik',
                      subtitle: 'Sampah organik adalah sampah yang mudah terurai...',
                      imageAsset: 'assets/edukasi/sampah.jpg',
                    ),
                    SizedBox(height: 12),
                    NewsCard(
                      source: 'mojok.co',
                      title: 'Bank Sampah: Inovasi Daur Ulang Ramah Lingkungan',
                      subtitle: 'Sistem daur ulang yang ramah lingkungan...',
                      imageAsset: 'assets/edukasi/bank-sampah.jpg',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Card 
class PositionedCard extends StatelessWidget {
  final Widget child;

  const PositionedCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;

  const InfoCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(title, style: const TextStyle(color: Colors.green)),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String source;
  final String title;
  final String subtitle;
  final String imageAsset;

  const NewsCard({
    required this.source,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
      ),
      child: ListTile(
        leading: Image.asset(imageAsset, width: 60, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text(source, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
