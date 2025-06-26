import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final Color greenColor = const Color(0xFF00C853);
  String _error = '';

  Future<void> register() async {
    if (_passwordController.text != _confirmController.text) {
      setState(() => _error = 'Password tidak cocok');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } catch (e) {
      setState(() => _error = 'Gagal registrasi: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            const Text('Register', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email', filled: true, fillColor: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password', filled: true, fillColor: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm Password', filled: true, fillColor: Colors.white),
            ),
            const SizedBox(height: 12),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: greenColor),
              child: const Text("Register"),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.g_mobiledata, size: 40),
                    Icon(Icons.facebook),
                    Icon(Icons.apple),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                  child: const Text("already have an account? Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
