import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:monitoring_app/app_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ChartScreen(),
    );
  }
}

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late DatabaseReference _databaseReference;
  List<FlSpot> beltSpeed1Data = [];
  List<FlSpot> rpm1Data = [];
  List<FlSpot> beltSpeed2Data = [];
  List<FlSpot> rpm2Data = [];
  final GlobalKey chartKey = GlobalKey();
  String totalData = 'Loading...'; // Initial value

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference().child('Graph');

    _databaseReference.onChildAdded.listen((event) {
      String graphId = event.snapshot.key!;
      DatabaseReference graphReference = _databaseReference.child(graphId);

      _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          var data = event.snapshot.value as Map<Object?, Object?>?;
           totalData = data?['lastGraphId']?.toString() ?? 'Error';
        });
      }else{
        setState(() {
          totalData = 'Error';
        });
      }
    });

      graphReference.child('beltSpeed1').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString());
          setState(() {
            beltSpeed1Data.add(FlSpot(beltSpeed1Data.length.toDouble(), value));
          });
        }
      });

      graphReference.child('RPM1').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString()) / 100;
          setState(() {
            rpm1Data.add(FlSpot(rpm1Data.length.toDouble(), value));
          });
        }
      });

      graphReference.child('beltSpeed2').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString());
          setState(() {
            beltSpeed2Data.add(FlSpot(beltSpeed1Data.length.toDouble(), value));
          });
        }
      });

      graphReference.child('RPM2').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString()) / 100;
          setState(() {
            rpm2Data.add(FlSpot(rpm1Data.length.toDouble(), value));
          });
        }
      });
    });
  }

  Future<void> createPDF(BuildContext context) async {
    // Ensure the widget is built
    await Future.delayed(Duration.zero);

    // Check if the context is null before proceeding
    if (chartKey.currentContext != null) {
      final RenderRepaintBoundary boundary =
          chartKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Convert the image to a PDF
      final pdf = pw.Document();
      final imagePdf = pw.MemoryImage(pngBytes);
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(imagePdf))));

      // Save the PDF to a file
      final Directory? directory = await getExternalStorageDirectory();
      final String path = '${directory?.path}/chart.pdf';

      final File file = File(path);
      await file.writeAsBytes(await pdf.save());
      // print('PDF saved successfully at: $path');

      // Optionally, share the file or notify the user
    } else {
      // print('The context is null. The widget may not be built yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalDataValue = int.tryParse(totalData) ?? 0;
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      body: RepaintBoundary(
        key: chartKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0), // Spacer
              const Text(
                'Graph',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24.0), // Spacer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Data',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        totalData,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Download as PDF ?',
                              style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 0, 0), // Warna teks
                                  fontSize: 24),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 0, 0, 0), // Warna teks
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  createPDF(context);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 3, 3, 3), // Warna teks
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Download',
                      style: TextStyle(
                        color: Colors.white, // Warna teks
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0), // Spacer
              Container(
                height: 6.0,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCCCCC), // Color of the background bar
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: totalDataValue/300,
                  child: Container(
                    height: 6.0, // Same height as background bar
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        5,
                        5,
                        5,
                      ), // Color of the actual bar
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: beltSpeed1Data,
                        isCurved: true,
                        colors: [const Color(0xFF750E21)],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2.5, // Mengatur lebar garis
                      ),
                      LineChartBarData(
                        spots: rpm1Data,
                        isCurved: true,
                        colors: [const Color(0xFF0766AD)],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2.5, // Mengatur lebar garis
                      ),
                      LineChartBarData(
                        spots: beltSpeed2Data,
                        isCurved: true,
                        colors: [
                          const Color.fromARGB(255, 86, 219, 9),
                        ],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2.5, // Mengatur lebar garis
                      ),
                      LineChartBarData(
                        spots: rpm2Data,
                        isCurved: true,
                        colors: [const Color.fromARGB(255, 231, 247, 11)],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2.5, // Mengatur lebar garis
                      ),
                    ],
                    titlesData: FlTitlesData(
                      show: false, // Menyembunyikan angka pada sumbu X dan Y
                    ),
                    gridData: FlGridData(
                      show: false, // Menyembunyikan garis dan angka pada sumbu
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 64.0,
                  bottom: 42.0,
                  left: 0,
                  right: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 179, 18, 47),
                      ),
                    ),
                    const Text(
                      'belt1',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(width: 12), // Menambahkan padding horizontal
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 9, 127, 218),
                      ),
                    ),
                    const Text(
                      'rpm1',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(width: 12), // Menambahkan padding horizontal
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 86, 219, 9),
                      ),
                    ),
                    const Text(
                      'belt2',
                      style: TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
                    ),
                    const SizedBox(width: 12), // Menambahkan padding horizontal
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 231, 247, 11),
                      ),
                    ),
                    const Text(
                      'rpm2',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
