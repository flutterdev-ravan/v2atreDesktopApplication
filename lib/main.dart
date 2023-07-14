import 'dart:io';
import 'package:atre_windows/API%20Services/appointment_Service.dart';
import 'package:atre_windows/API%20Services/doctors_service.dart';
import 'package:atre_windows/API%20Services/login_Service.dart';
import 'package:atre_windows/Constants/myColors.dart';
import 'package:atre_windows/Controller/patient_controller.dart';
import 'package:atre_windows/Screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'Controller/appointment_controller.dart';
import 'Controller/doctor_controller.dart';
import 'Controller/hub_robot_controller.dart';
import 'Controller/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Atre');
    setWindowMinSize(const Size(1720, 864));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginApi>(create: (context) => LoginApi()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<AppoinmentApi>(
            create: (context) => AppoinmentApi()),
        ChangeNotifierProvider<AppointmentProvider>(
            create: (context) => AppointmentProvider()),
        ChangeNotifierProvider<PatientProvider>(
            create: (context) => PatientProvider()),
        ChangeNotifierProvider<RobotProvider>(
            create: (context) => RobotProvider()),
        ChangeNotifierProvider<AppointmentProvider>(
            create: (context) => AppointmentProvider()),
        ChangeNotifierProvider<DoctorProvider>(
            create: (context) => DoctorProvider()),
        ChangeNotifierProvider<DoctorApi>(create: (context) => DoctorApi()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Atre Health Tech',
          theme: ThemeData(
              primarySwatch: Colors.green,
              textSelectionTheme:
                  TextSelectionThemeData(cursorColor: myColors.greenColor)),
          home: Login()),
    );
  }
}

// For Http license issue

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
