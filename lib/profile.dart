import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String gender = 'male';
  bool googleLinked = true;
  bool facebookLinked = false;

  final Color greenColor = const Color(0xFF00C853);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/avatar.png"), // ganti dengan image asset kamu
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Name
            const Text("Name", style: TextStyle(color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Angga", style: TextStyle(fontSize: 16)),
                Text("EDIT", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),

            // Gender
            const SizedBox(height: 16),
            const Text("Gender", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: ['female', 'male', 'other', 'prefer not to say'].map((value) {
                return ChoiceChip(
                  label: Text(value),
                  selected: gender == value,
                  onSelected: (_) => setState(() => gender = value),
                  selectedColor: greenColor,
                  labelStyle: TextStyle(color: gender == value ? Colors.white : Colors.black),
                );
              }).toList(),
            ),

            // Birthday
            const SizedBox(height: 24),
            const Text("Birthday", style: TextStyle(color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("26-06-2005", style: TextStyle(fontSize: 16)),
                Text("EDIT", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),

            // Phone Number
            const SizedBox(height: 16),
            const Text("Phone Number", style: TextStyle(color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("+62 813-8234-5678", style: TextStyle(fontSize: 16)),
                Text("EDIT", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),

            // Email
            const SizedBox(height: 16),
            const Text("Email Address", style: TextStyle(color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("anggaasek@banksampah.com", style: TextStyle(fontSize: 16)),
                Text("EDIT", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),

            // Linked Accounts
            const SizedBox(height: 24),
            const Text("Linked Accounts", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            SwitchListTile(
              value: googleLinked,
              onChanged: (val) => setState(() => googleLinked = val),
              title: Row(
                children: [
                  Image.asset("assets/google.png", width: 24), // ikon Google
                  const SizedBox(width: 12),
                  const Text("Google"),
                ],
              ),
              activeColor: greenColor,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: facebookLinked,
              onChanged: (val) => setState(() => facebookLinked = val),
              title: Row(
                children: [
                  Image.asset("assets/facebook.png", width: 24), // ikon Facebook
                  const SizedBox(width: 12),
                  const Text("Facebook"),
                ],
              ),
              activeColor: greenColor,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.green, fontSize: 16)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // Simpan data
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
