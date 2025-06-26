import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
// pastikan path ini sesuai

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Color greenColor = const Color(0xFF00C853);
  String _error = '';

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = 'Gagal login: ${e.toString()}');
    }
  }

  // Future<void> loginWithGoogle() async {
  //   try {
  //     final userCredential = await signInWithGoogle();
  //     if (userCredential != null) {
  //       Navigator.pushReplacementNamed(context, '/home');
  //     }
  //   } catch (e) {
  //     setState(() => _error = 'Login Google gagal: ${e.toString()}');
  //   }
  // }

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
            const Text(
              'Login',
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?', style: TextStyle(color: Colors.white)),
              ),
            ),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: greenColor,
              ),
              child: const Text("Login"),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Google Button
                    IconButton(
                      icon: Image.asset('assets/google.png', width: 30), // kamu bisa ganti icon sesuai keinginan
                      onPressed: () {
                        //kode
                      }
                    ),
                    IconButton(
                      icon: Image.asset('assets/facebook.png', width: 30),
                      onPressed: () {
                        // TODO: Implement Facebook login
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/apple.png', width: 30),
                      onPressed: () {
                        // TODO: Implement Apple login
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                  child: const Text("New Here? Register", style: TextStyle(color: Colors.white)),
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
