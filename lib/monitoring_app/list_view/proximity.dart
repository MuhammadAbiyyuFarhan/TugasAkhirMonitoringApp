import 'package:flutter/material.dart';
import 'package:monitoring_app/app_theme.dart';
import 'package:monitoring_app/main.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';

class ProximityDetailScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProximityDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proximity Detail'),
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
                              'assets/monitoring_app/proximity.png',
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
                            'E18-D80NK',
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
                        'Infrared Proximity Sensor',
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
                            'Rp.25.000',
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
                            '+5V',
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
                        'E18-D80NK Adjustable Infrared Sensor Switch 10-80cm Proximity Detection Range Distance'
                        'E18-D80NK is a sensor that can be used as a detector for objects or obstacles at a certain distance using the method of reflecting infrared light, which has excellent accuracy and response. The detection range can be adjusted by rotating the trimmer head located behind the sensor, allowing us to adjust the sensor from 10cm to 80cm. The advantage of this sensor is its design, which is specifically made for real-world usage and is not affected by indirect sunlight.\n',
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
                      '- Power Supply: 5 VDC\n'
                      '- Supply current DC 25mA\n'
                      '- Maximum load current 100mA\n'
                      '- Effective from 10-80CM Adjustable\n'
                      '- Light sensor NPN normally open \n'
                      '  model: LEFIRCKO E18-D80NK.\n'
                      '- Detection of objects: \n'
                      '  transparent or opaque\n'
                      '- Working environment temperature:\n'
                      ' -25+55\n'
                      '- Standard test objects: the sun\n'
                      '  10000LX less incandescent 3000LX\n'
                      '- Case Material: Plastic\n'
                      '- Diameter: 17MM\n'
                      '- Length: 45mm\n'
                      '- Cable Length: 45cm\n'
                      '- High Quality\n\n'
                      'Aplication :\n'
                      '- Automatic counting equipment for\n'
                      '  production line goods\n'
                      '- Multi-functional reminder\n'
                      '- Walking maze robot\n'
                      '- Avoiding obstacles.',
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
