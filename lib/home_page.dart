import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
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
              const PositionedCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.stars, color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('POINT', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('100000'),
                      ],
                    ),
                    Spacer(),
                    Text('Tap for history', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Info belum waktunya
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

              // Suhu & Kelembaban Box
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
                    Text('Berita', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    NewsCard(
                      source: 'republika',
                      title: 'Pemkot Depok Apresiasi Pasar Online dan Bank Sampah Sawangan Elok',
                      subtitle: 'melakukan pemilahan sampah juga bisa memberikan rezeki...',
                      imageUrl: 'https://images.unsplash.com/photo-1506765515384-028b60a970df?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&h=100&q=60',

                    ),
                    SizedBox(height: 12),
                    NewsCard(
                      source: 'mojok.co',
                      title: 'Bank Sampah yang Memberikan...',
                      subtitle: 'Sistem daur ulang yang ramah lingkungan...',
                      imageUrl: 'https://images.unsplash.com/photo-1506765515384-028b60a970df?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&h=100&q=60',

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
  final String imageUrl;

  const NewsCard({
    required this.source,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
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
        leading: Image.network(imageUrl, width: 60, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text(source, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
