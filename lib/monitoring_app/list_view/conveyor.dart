import 'package:flutter/material.dart';
import 'package:monitoring_app/app_theme.dart';
import 'package:monitoring_app/main.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';

class ConveyorDetailScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConveyorDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conveyor Detail'),
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
                              'assets/monitoring_app/conveyor.png',
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
                            'Conveyor',
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
                        'Automatic Filling System',
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
                          Icon(Icons.access_time),
                          SizedBox(width: 5),
                          Text(
                            '35 RPM',
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
                            '+12V',
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
                            '---',
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
                        'A conveyor is defined as a fixed and portable device used to transport materials between two fixed points, through intermittent or continuous movement. Typically, conveyors are used in places where the workflow is relatively constant. In simpler terms, a conveyor is a mechanical system that functions to move goods from one place to another. Like all material handling equipment, conveyors do not add value to the part, product, or component being moved. They do not shape, process, or alter products in any way. They are purely a service process, and as such, they have an indirect impact on product costs as part of overhead expenses. \n',
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
                      '- Motor Type : JGA25-370\n'
                      '- Supply: 12VDC\n'
                      '- Rated load : 6.8Kg.cm\n'
                      '- Max torque : 9 Kg.Cm\n'
                      '\n Aplication :\n'
                      '- Manufacturing Industry\n'
                      '- Logistics and Distribution Industry\n'
                      '- Food and Beverage Industry\n'
                      '- Automotive Industry\n'
                      '- Mining Industry\n'
                      '- Pharmaceutical Industry\n'
                      '- Packaging Industry\n'
                      '- Airport Baggage Handling Industry\n',
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
