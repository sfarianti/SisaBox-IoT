import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color greenColor = const Color(0xFF00C853);

  String uid = '';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();

  String gender = 'male';
  bool isLoading = true;
  bool googleLinked = true;
  bool facebookLinked = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        uid = user.uid;
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists) {
          final data = doc.data()!;
          _usernameController.text = data['username'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _birthdayController.text = data['birthday'] ?? '';
          gender = data['gender'] ?? 'male';
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> saveProfile() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'birthday': _birthdayController.text.trim(),
        'gender': gender,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Center(
                    child: Column(
                      children: const [
                        CircleAvatar(radius: 40, backgroundImage: AssetImage("assets/avatar.png")),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("Name", style: TextStyle(color: Colors.grey)),
                  TextField(controller: _usernameController),
                  const Divider(),

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

                  const SizedBox(height: 24),
                  const Text("Birthday", style: TextStyle(color: Colors.grey)),
                  TextField(controller: _birthdayController),
                  const Divider(),

                  const SizedBox(height: 16),
                  const Text("Phone Number", style: TextStyle(color: Colors.grey)),
                  TextField(controller: _phoneController),
                  const Divider(),

                  const SizedBox(height: 16),
                  const Text("Email Address", style: TextStyle(color: Colors.grey)),
                  TextField(controller: _emailController),
                  const Divider(),

                  const SizedBox(height: 24),
                  const Text("Linked Accounts", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: googleLinked,
                    onChanged: (val) => setState(() => googleLinked = val),
                    title: Row(
                      children: [
                        Image.asset("assets/google.png", width: 24),
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
                        Image.asset("assets/facebook.png", width: 24),
                        const SizedBox(width: 12),
                        const Text("Facebook"),
                      ],
                    ),
                    activeColor: greenColor,
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel", style: TextStyle(color: Colors.green, fontSize: 16)),
                      ),
                      ElevatedButton(
                        onPressed: saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
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
