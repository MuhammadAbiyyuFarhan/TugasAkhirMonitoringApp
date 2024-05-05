import 'package:flutter/material.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';
// import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductDetailsView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProductDetailsView({
    super.key,
    this.animationController,
    this.animation,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late DatabaseReference _databaseReference;
  String goodTimestamp = 'Loading...'; // Initial value
  String goodId = 'Loading...'; // Initial value
  String stuckTimestamp = 'Loading...'; // Initial value
  String statusId = 'Loading...'; // Initial value
  Map<String, List<Map<String, dynamic>>?> tabelGood = {};
  Map<String, List<Map<String, dynamic>>?> tabelStuck = {};

  @override
  void initState() {
    super.initState();
    _fetchGoodData();
    _fetchStuckData();
    _loadGoodTabel();
    _loadStuckTabel();
  }

  
void _fetchGoodData() {
  // ignore: deprecated_member_use
  _databaseReference = FirebaseDatabase.instance.reference().child('Good');
  _databaseReference.onValue.listen((DatabaseEvent event) {
    if (event.snapshot.value != null) {
      setState(() {
        var data = event.snapshot.value as Map<Object?, Object?>?;
        var lastGoodId = data?['lastGoodId']?.toString();
        // print('Last Good ID: $lastGoodId');

        if (lastGoodId != null) {
          // Mengambil snapshot dari child dengan ID terakhir yang sesuai dengan lastGoodId
          var lastChildSnapshot = event.snapshot.child(lastGoodId.padLeft(6, '0'));
          if (lastChildSnapshot.exists) {
            // Jika child dengan ID terakhir ditemukan
            goodId = lastGoodId;
            goodTimestamp = lastChildSnapshot.child('timestamp').value.toString();
            // print('Good ID: $goodId');
            // print('Good Timestamp: $goodTimestamp');
          } else {
            // Jika tidak ada child dengan ID terakhir yang ditemukan
            goodId = 'Error';
            goodTimestamp = 'Error'; 
            // print('Error: No child found with ID $lastGoodId');
          }
        } else {
          // Jika lastGoodId kosong
          goodId = 'Error';
          goodTimestamp = 'Error'; 
          // print('Error: No lastGoodId found');
        }
      });
    } else {
      setState(() {
        goodId = 'Error';
        goodTimestamp = 'Error'; // Tambahkan ini untuk menangani kasus error
        // print('Error: No data found in "Good"');
      });
    }
  });
}

  void _fetchStuckData() {
  // ignore: deprecated_member_use
  _databaseReference = FirebaseDatabase.instance.reference().child('Status');
  _databaseReference.onValue.listen((DatabaseEvent event) {
    if (event.snapshot.value != null) {
      setState(() {
        var data = event.snapshot.value as Map<Object?, Object?>?;
        var lastStatusId = data?['lastStatusId']?.toString();
        // print('Last Good ID: $lastStatusId');

        if (lastStatusId != null) {
          // Mengambil snapshot dari child dengan ID terakhir yang sesuai dengan lastGoodId
          var lastChildSnapshot = event.snapshot.child(lastStatusId.padLeft(6, '0'));
          if (lastChildSnapshot.exists) {
            // Jika child dengan ID terakhir ditemukan
            statusId = lastStatusId;
            stuckTimestamp = lastChildSnapshot.child('timestamp').value.toString();
            // print('stuck ID: $statusId');
            // print('stuck Timestamp: $stuckTimestamp');
          } else {
            // Jika tidak ada child dengan ID terakhir yang ditemukan
            statusId = 'Error';
            stuckTimestamp = 'Error'; 
            // print('Error: No child found with ID $lastStatusId');
          }
        } else {
          // Jika lastGoodId kosong
          statusId = 'Error';
          stuckTimestamp = 'Error'; 
          // print('Error: No lastGoodId found');
        }
      });
    } else {
      setState(() {
        statusId= 'Error';
        stuckTimestamp = 'Error'; // Tambahkan ini untuk menangani kasus error
        // print('Error: No data found in "Good"');
      });
    }
  });
}

  void _loadGoodTabel() {
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference().child("Good");
    _databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;
      final dynamic snapshotValue = snapshot.value;

      if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
        List<Map<String, dynamic>> tabelMessages = [];

        snapshotValue.forEach((productId, productValue) {
          if (productValue is Map<dynamic, dynamic>) {
            if (productId == "lastGoodId") {
              return;
            }
            tabelMessages.add({
              'productId': productId,
              'timestamp': productValue['timestamp'].toString() ?? '',
              // 'bottleColor': productValue['bottleColor'].toString() ?? '',
            });
          }
        });

        // Urutkan tabelMessages berdasarkan productId
        tabelMessages.sort((a, b) => a['productId'].compareTo(b['productId']));

        setState(() {
          tabelGood['products'] = tabelMessages;
          // print('Tabel Messages: $tabelMessages');
        });
      } else {
        // print('Tidak Ada Data');
      }
    });
  }

  void _loadStuckTabel() {
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference().child("Status");
    _databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;
      final dynamic snapshotValue = snapshot.value;

      if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
        List<Map<String, dynamic>> tabelMessages = [];

        snapshotValue.forEach((productId, productValue) {
          if (productValue is Map<dynamic, dynamic>) {
            // Directly add productId and timestamp to the list
            tabelMessages.add({
              'productId': productId,
              'timestamp': productValue['timestamp'].toString() ?? '',
            });
          }
        });

        tabelMessages.sort((a, b) => a['productId'].compareTo(b['productId']));

        setState(() {
          tabelStuck['products'] = tabelMessages;
          // print('Tabel Messages: $tabelMessages');
        });
      } else {
        // print('Tidak Ada Data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
// Perform the matching process before creating DataTable rows
    final List<Map<String, dynamic>> matchedDataList = [];
    tabelStuck['products']?.forEach((data) {
      var matchedData = tabelGood['products']?.firstWhere(
        (element) => element['productId'] == data['productId'],
        orElse: () => {'timestamp': '-'},
      );
      matchedDataList.add({
        'productId': data['productId'],
        'goodTimestamp': matchedData?['timestamp'],
        'stuckTimestamp': data['timestamp'],
      });
    });

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animation!.value),
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 8,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: MonitoringAppTheme.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: MonitoringAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 4,
                                  bottom: 8,
                                  top: 16,
                                ),
                                child: Text(
                                  'Product - Good',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MonitoringAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: MonitoringAppTheme.darkText,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          bottom: 3,
                                        ),
                                        child: Text(
                                          goodId, // Tambahkan goodId di sini
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          'pcs',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            color: MonitoringAppTheme.grey
                                                .withOpacity(0.5),
                                            size: 16,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4.0,
                                            ),
                                            child: Text(
                                              goodTimestamp,
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
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 4,
                                          bottom: 14,
                                        ),
                                        child: Text(
                                          'Last Recorded',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(), // Garis pemisah
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 4,
                                  bottom: 8,
                                  top: 16,
                                ),
                                child: Text(
                                  'Product - Stuck',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MonitoringAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: MonitoringAppTheme.darkText,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          bottom: 3,
                                        ),
                                        child: Text(
                                          statusId, // Tambahkan statusId di sini
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          'pcs',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            color: MonitoringAppTheme.grey
                                                .withOpacity(0.5),
                                            size: 16,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4.0,
                                            ),
                                            child: Text(
                                              stuckTimestamp, // Tambahkan stuckTimestamp di sini
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
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 4,
                                          bottom: 14,
                                        ),
                                        child: Text(
                                          'Last Recorded',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            color: MonitoringAppTheme
                                                .nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(), // Another divider
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255,
                          255), // Ganti dengan warna yang Anda inginkan
                    ),

// Create DataTable rows using the matched data
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Product - Good')),
                        DataColumn(label: Text('Product - Stuck')),
                      ],
                      rows: matchedDataList.map((data) {
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              '${data['goodTimestamp']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${data['stuckTimestamp']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
