import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HistoryScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DatabaseReference _databaseReference;
  List<Map<String, dynamic>> statusHistory = [];

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference().child("Status");
    _loadStatusHistory();
  }

  void _loadStatusHistory() {
    _databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;
      List<Map<String, dynamic>> statusMessages = [];
      final dynamic snapshotValue = snapshot.value;
      if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
        snapshotValue.forEach((key, value) {
          // Skip if the key is "lastStatusId"
          if (key == "lastStatusId") {
            return;
          }
          final Map<String, dynamic> statusData =
              Map<String, dynamic>.from(value);
          statusMessages.add({
            'id': key,
            'message': statusData['message'] ?? '',
            'acknowledged': statusData['acknowledge'] == 1,
            'timestamp': statusData['timestamp'] ?? '',
          });
        });

        // Sort the list based on statusId
        statusMessages
            .sort((a, b) => int.parse(b['id']).compareTo(int.parse(a['id'])));
      } else {
        statusMessages.add({
          'id': '',
          'message': 'No status messages found',
          'acknowledged': false,
          'timestamp': '',
        });
      }

      setState(() {
        statusHistory = statusMessages;
        print('data : $statusHistory'); 
      });
    });
  }

  void _updateStatusAcknowledgement(int index, bool value) async {
    try {
      final originalIndex =
          index; // Kita gunakan index asli tanpa perhitungan ulang
      // print('Original Index: $originalIndex');
      final statusId = statusHistory[originalIndex]['id'];
      // print('Status ID: $statusId');
      await _databaseReference
          .child(statusId)
          .update({'acknowledge': value ? 1 : 0});
      setState(() {
        statusHistory[originalIndex]['acknowledged'] = value;
        // print('berhasil memperbarui nilai : $originalIndex');
      });
      Navigator.of(context).pop();
    } catch (error) {
      // print('gagal memperbarui nilai acknowledgment: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
            bottom: 80.0), // Tambahkan padding di bagian bawah list
        itemCount: statusHistory.length,
        itemBuilder: (context, index) {
          final status = statusHistory[index];
          bool acknowledged = status['acknowledged'];
          return Container(
            margin: const EdgeInsets.all(6.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey[200],
            ),
            child: ListTile(
              leading: status['acknowledged']
                  ? const Icon(Icons.check_circle,
                      color: Color.fromARGB(246, 211, 208, 37))
                  : const Icon(Icons.warning, color: Colors.red),
              title: Text(
                status['message'] ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                'Timestamp: ${status['timestamp']}',
                style: const TextStyle(fontSize: 14),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Warning Details'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status ID: ${status['id']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Message: ${status['message']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Timestamp: ${status['timestamp']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Switch(
                            value: acknowledged,
                            onChanged: (value) {
                              _updateStatusAcknowledgement(index, value);
                            },
                          ),
                          const Text('Acknowledged'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
