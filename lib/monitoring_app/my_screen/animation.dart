import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key, AnimationController? animationController}) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  double _top = 300; // Variabel untuk menentukan posisi vertikal widget
  double _left = 50; // Variabel untuk menentukan posisi horizontal widget
  String _proximity1 = ""; // Variabel untuk menyimpan nilai proximity1
  double _top2 = 360; // Variabel untuk menentukan posisi vertikal widget
  double _left2 = 50;
  String _proximity2 = "";
  bool _proxi1 = false;
  // Inisialisasi Firebase Database
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    // Subscribe ke Firebase Realtime Database untuk mendapatkan perubahan data
    _database.reference().child('proximity1').onValue.listen((event) {
      // Saat ada perubahan data, update nilai proximity1
      setState(() {
        // Ubah nilai dari Object? menjadi String
        _proximity1 = event.snapshot.value.toString();
        // Perbarui posisi gambar berdasarkan nilai proximity1
        _updateImagePosition1();
      });
    });
    // Subscribe ke Firebase Realtime Database untuk mendapatkan perubahan data
    _database.reference().child('proximity2').onValue.listen((event) {
      // Saat ada perubahan data, update nilai proximity1
      setState(() {
        // Ubah nilai dari Object? menjadi String
        _proximity2 = event.snapshot.value.toString();
        // Perbarui posisi gambar berdasarkan nilai proximity1
        _updateImagePosition2();
      });
    });
  }

  // Fungsi untuk memperbarui posisi gambar berdasarkan nilai proximity1
  void _updateImagePosition1() {
    // Jika nilai proximity1 adalah "Object Detected", pindahkan gambar secara diagonal menurun
    if (_proximity1 == "Object Detected") {
      setState(() {
        _top = 360; // Atur posisi top ke 200
        _left = MediaQuery.of(context).size.width / 2 -
            50; // Atur posisi left ke tengah layar
      });
    } else {
      // Jika nilai proximity1 bukan "Object Detected", kembalikan gambar ke posisi awal
      // dan atur opacity menjadi 0 secara langsung
      setState(() {
        _top = 300; // Atur posisi top ke 0
        _left = 50; // Atur posisi left ke 0
      });
    }
  }

  void _updateImagePosition2() {
    // Jika nilai proximity1 adalah "Object Detected", pindahkan gambar secara diagonal menurun
    if (_proximity2 == "Object Detected") {
      setState(() {
        _top2 = 270; // Atur posisi top ke 200
        _left2 = 300; // Atur posisi left ke tengah layar
      });
    } else {
      // Jika nilai proximity1 bukan "Object Detected", kembalikan gambar ke posisi awal
      // dan atur opacity menjadi 0 secara langsung
      setState(() {
        _top2 = 360; // Atur posisi top ke 0
        _left2 =
            MediaQuery.of(context).size.width / 2 - 50; // Atur posisi left ke 0
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RealTimeAnimation'),
      ),
      body: Stack(
        children: [
          // Latar belakang berupa gambar conveyor
          Center(
            child: Image.asset(
              'assets/monitoring_app/conveyor.png',
              fit: BoxFit.cover,
              height: 270,
            ),
          ),
          // Widget berbentuk gambar yang berpindah posisi
          AnimatedPositioned(
            duration: const Duration(seconds: 5), // Durasi animasi
            top: _top, // Atur posisi top sesuai dengan nilai _top
            left: _left, // Atur posisi left sesuai dengan nilai _left
            child: Opacity(
              opacity: _proximity1 == "Object Detected"
                  ? 1.0
                  : 0.0, // Atur opacity berdasarkan nilai proximity1
              child: Image.asset(
                'assets/monitoring_app/botol.png', // Ganti dengan path gambar Anda
                width: 70,
                height: 70,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 5), // Durasi animasi
            top: _top2, // Atur posisi top sesuai dengan nilai _top
            left: _left2, // Atur posisi left sesuai dengan nilai _left
            child: Opacity(
              opacity: _proximity2 == "Object Detected"
                  ? 1.0
                  : 0.0, // Atur opacity berdasarkan nilai proximity1
              child: Image.asset(
                'assets/monitoring_app/botol.png', // Ganti dengan path gambar Anda
                width: 70,
                height: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
