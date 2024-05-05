import 'package:flutter/material.dart';
import 'package:monitoring_app/app_theme.dart';
import 'package:monitoring_app/main.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';

class TachometerDetailScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TachometerDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tachometer Detail'),
        backgroundColor: AppTheme.chipBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: AppTheme.chipBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft:
                        Radius.circular(20.0), // Radius untuk sudut kiri atas
                    topRight:
                        Radius.circular(66.0), // Radius untuk sudut kanan atas
                    bottomLeft:
                        Radius.circular(20.0), // Radius untuk sudut kiri bawah
                    bottomRight:
                        Radius.circular(20.0), // Radius untuk sudut kanan bawah
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: MonitoringAppTheme.grey.withOpacity(0.6),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      MonitoringAppTheme.nearlyDarkBlue,
                      HexColor("#FFFC9B"),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 5,
                            ), // Padding for the image
                            child: Image.asset(
                              'assets/monitoring_app/tachometer.png',
                              height: 170,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4), // Spacer
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tachometer',
                            style: TextStyle(
                              fontFamily: MonitoringAppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: MonitoringAppTheme.white,
                            ),
                          ),
                          // Add widgets here if needed
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Conveyor Belt Speed Sensor',
                        style: TextStyle(
                          fontFamily: MonitoringAppTheme.fontName,
                          fontSize: 16,
                          color: MonitoringAppTheme.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          SizedBox(width: 5),
                          Text(
                            'Rp.200.000',
                            style: TextStyle(
                              fontFamily: MonitoringAppTheme.fontName,
                              fontSize: 12,
                              color: MonitoringAppTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flash_on),
                          SizedBox(width: 5),
                          Text(
                            '+3.3V',
                            style: TextStyle(
                              fontFamily: MonitoringAppTheme.fontName,
                              fontSize: 12,
                              color: MonitoringAppTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shopping_bag),
                          SizedBox(width: 5),
                          Text(
                            'Tokopedia',
                            style: TextStyle(
                              fontFamily: MonitoringAppTheme.fontName,
                              fontSize: 12,
                              color: MonitoringAppTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'This tachometer sensor is specifically designed for use in measuring conveyor belt speed. With a working voltage of DC 3.3V/5V, the sensor utilizes a gap-type optical sensor technology. Its design allows for easy mounting on a 1/2-inch PVC pipe, ensuring compatibility with commonly used conveyor structures. The advantage of this sensor lies in its ability to provide precise readings. With multiple gaps within one rotation, the sensor can deliver more accurate and stable readings of the conveyor belt speed. The output generated by this sensor is Pulse Digital TTL, which is suitable for the needs of control or monitoring systems commonly used in conveyor setups. Tailored to specifications and capabilities, this sensor is ideal for applications in transportation and production industries, where monitoring and controlling conveyor belt speed are crucial for operational efficiency and safety. By using this sensor, users can ensure that conveyor belt speed is accurately measured and can be adjusted according to production needs.\n',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: MonitoringAppTheme.fontName,
                          fontSize: 16,
                          color: MonitoringAppTheme.darkText,
                        ),
                      ),
                    ),
                    Text(
                      'Spesication :\n'
                      '- Supply: 3.3 - 5 VDC\n'
                      '- Output : Pulse Digital TTL\n'
                      '- Using a slit type optical sensor.\n'
                      '- number of gaps : 22\n\n'
                      'Aplication :\n'
                      '- Measuring Conveyor Belt\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: MonitoringAppTheme.fontName,
                        fontSize: 16,
                        color: MonitoringAppTheme.darkText,
                      ),
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
