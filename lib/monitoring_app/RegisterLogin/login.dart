import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Jika login berhasil, arahkan pengguna ke halaman beranda
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => const MonitoringAppHomeScreen()),
        );
      }
    } catch (error) {
      // Tampilkan pesan kesalahan kepada pengguna
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Color(0xFFE74C3C),
            title: Text(
              'Login Failed',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Invalid email or password. Please try again.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE7C9),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Menambahkan gambar
            Image.asset(
              'assets/monitoring_app/conveyorSingle.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            // TextField untuk email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color:
                          Color(0xFF294B29)), // Warna border saat dalam fokus
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(
                          0xFF294B29)), // Warna border saat tidak dalam fokus
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // TextField untuk password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color:
                          Color(0xFF294B29)), // Warna border saat dalam fokus
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(
                          0xFF294B29)), // Warna border saat tidak dalam fokus
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 28.0),
            // Tombol Login
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF294B29), // Warna latar belakang tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Atur border radius sesuai keinginan
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white), // Warna teks 'Login'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
