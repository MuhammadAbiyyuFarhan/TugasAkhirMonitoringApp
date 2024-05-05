import 'package:flutter/material.dart';
import 'package:monitoring_app/app_theme.dart';
import 'package:monitoring_app/main.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';

class TCS3200DetailScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TCS3200DetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCS3200 Detail'),
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
                              'assets/monitoring_app/TCS3200.png',
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
                            'TCS3200',
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
                        'Color Sensor',
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
                            'Rp.70.000',
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
                        'The TCS3200 sensor is a versatile color sensor capable of detecting and measuring the intensity of light within the visible spectrum. Its primary function is to determine the color of an object by measuring the RGB (Red, Green, Blue) components of the light reflected from the object surface. This sensor consists of an array of photodiodes arranged in a 8x8 matrix, along with an RGB color filter that allows the sensor to differentiate between different wavelengths of light. It operates based on the principle of photometry, where the intensity of light falling on each photodiode is converted into electrical signals. Overall, the TCS3200 sensor offers a reliable and efficient solution for color sensing applications, providing accurate and consistent results across different lighting conditions and environments. Its flexibility and performance make it a valuable component in a wide range of electronic systems and devices.\n',
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
                      '- using imported chip TCS3200\n' 
                      '  PCB board with gold plating \n'
                      '- power supply 3-5v \n'
                      '- anti- light interference \n'
                      '- white LED, can control lights , off. \n'
                      '- can detect non-luminous object color \n'
                      '- PCB size : (L) 33mm * (W) 25mm \n\n'
                      'Application :\n'
                      '- Control RGB LED backlight\n'
                      '- Color and light temperature\n' 
                      '  measurement\n'
                      '- Ambient light sensor for display\n'
                      '- Analysis of air and gas\n'
                      '- Sorting goods based on color',
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
