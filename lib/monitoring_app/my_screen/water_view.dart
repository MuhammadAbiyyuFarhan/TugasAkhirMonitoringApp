import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';
import 'package:monitoring_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import paket firebase_database
import 'package:intl/intl.dart';

class WaterView extends StatefulWidget {
  WaterView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  String waktuAwal = 'Loading...';
  String totalWaktu = 'Loading'; // Deklarasi totalWaktu di sini

  Future<void> getDataFromFirebase() async {
    try {
      _databaseReference.onValue.listen((event) {
        final snapshot = event.snapshot;
        final dynamic value = snapshot.value;
        if (value != null && value is Map<dynamic, dynamic>) {
          setState(() {
            // Ubah pemanggilan value sesuai dengan struktur data Anda
            waktuAwal =
                value['working_hours']['timestamp']?.toString() ?? 'Error';
            DateTime waktuAwalDateTime =
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(waktuAwal);
            DateTime waktuAkhirDateTime = DateTime.now();
            Duration difference =
                waktuAkhirDateTime.difference(waktuAwalDateTime);
            totalWaktu =
                '${difference.inHours}:${difference.inMinutes.remainder(60)}:${difference.inSeconds.remainder(60)}';
            print('Total Waktu: $totalWaktu');
          });
        }
      });
    } catch (error) {
      setState(() {
        waktuAwal = 'Error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
  }

  void _sendTimestampToFirebase() {
    // Dapatkan timestamp saat ini
    DateTime currentTime = DateTime.now();
    // Format timestamp sesuai keinginan
    String formattedTimestamp =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
    // Inisialisasi Firebase Database
    final databaseReference = FirebaseDatabase.instance.reference();
    // Kirim timestamp yang telah diformat ke Firebase Realtime Database
    databaseReference.child('working_hours').set({
      'timestamp': formattedTimestamp,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: MonitoringAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MonitoringAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 4, bottom: 3),
                                      child: Text(
                                        totalWaktu,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: MonitoringAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                    // const Padding(
                                    //   padding:
                                    //       EdgeInsets.only(left: 8, bottom: 8),
                                    //   child: Text(
                                    //     '...',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(
                                    //       fontFamily:
                                    //           MonitoringAppTheme.fontName,
                                    //       fontWeight: FontWeight.w500,
                                    //       fontSize: 18,
                                    //       letterSpacing: -0.2,
                                    //       color:
                                    //           MonitoringAppTheme.nearlyDarkBlue,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    'Total Working Hours',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: MonitoringAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: MonitoringAppTheme.darkText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: MonitoringAppTheme.background,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.access_time,
                                          color: MonitoringAppTheme.grey
                                              .withOpacity(0.5),
                                          size: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Last Maintenance 23/01/2024',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: MonitoringAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/monitoring_app/bell.png'),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Your system might slowing down!.',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily:
                                                  MonitoringAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: HexColor('#F65283'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 34,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: MonitoringAppTheme.nearlyWhite,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: MonitoringAppTheme.nearlyDarkBlue
                                          .withOpacity(0.4),
                                      offset: const Offset(4.0, 4.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: MonitoringAppTheme.nearlyDarkBlue,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Reset Working Hours?"),
                                          content: const Text(
                                              "Are you sure you want to reset the work hours?"),
                                          actions: <Widget>[
                                            // Tombol "Tidak"
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                // Tutup dialog
                                              },
                                              child: const Text("No"),
                                            ),
                                            // Tombol "Ya"
                                            TextButton(
                                              onPressed: () {
                                                // Kirim timestamp saat ini ke Firebase
                                                _sendTimestampToFirebase();
                                                Navigator.of(context).pop();
                                                // Tutup dialog
                                              },
                                              child: const Text("Yes"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
