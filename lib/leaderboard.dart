import 'package:flutter/material.dart';
import '../widgets/navbar.dart'; 

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  final Color greenColor = const Color(0xFF00C853);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        child: Column(
          children: [
            // Tombol Back & Judul
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'Leaderboards\nJune 18 - 30, 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Juara 1-3
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/profile/user.png', height: 120), // Gambar podium

                Positioned(
                  top: 10,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                      ),
                      const SizedBox(height: 4),
                      const Text("Angga", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                Positioned(
                  left: 40,
                  bottom: 0,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                      ),
                      const SizedBox(height: 4),
                      const Text("Cinta", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                Positioned(
                  right: 40,
                  bottom: 0,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                      ),
                      const SizedBox(height: 4),
                      const Text("Ipul", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text('Global', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Center(
                        child: Text('Local', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // List Pemain
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: List.generate(players.length, (index) {
                    final player = players[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${player['rank']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(
                              player['gender'] == 'M' ? Icons.person : Icons.person_2,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(player['name']),
                          ),
                          if (player['score'] != null)
                            Text(player['score'].toString()),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavbarBottom(currentIndex: 3), // ⬅️ Gunakan Navbar
    );
  }
}

// Dummy data
final List<Map<String, dynamic>> players = [
  {"rank": 4, "name": "Jack", "gender": "M"},
  {"rank": 5, "name": "Mary", "gender": "F", "score": 3567},
  {"rank": 6, "name": "There", "gender": "M", "score": 3478},
  {"rank": 7, "name": "Gregory", "gender": "M", "score": 3387},
  {"rank": 8, "name": "James", "gender": "M", "score": 3257},
  {"rank": 9, "name": "David", "gender": "M", "score": 3250},
];