// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:atre_windows/Constants/localStorage.dart';
import 'package:atre_windows/Model/appointmentModel/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/appointmentModel/createAppointmentModel.dart';
import '../Model/patientModel/patient_details_model.dart';

class AppoinmentApi extends ChangeNotifier {
  // ******************************************* CREATE APPOINTMENT ***********************************************8

  Future<CreateNewAppointmentModel?> createAppointment(
      {required String patientName,
      required String refDocName,
      required String scanType,
      required String diffDiagnosis,
      required String appointmentDate,
      required String appointmentTime,
      required String location}) async {
    final http.Response response =
        await http.post(Uri.parse("${baseUrl}create-new-appointments"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'user-agent': version,
              'Authorization': 'Bearer $globalAccessToken'
            },
            body: jsonEncode(<String, String>{
              "patient_id": "patient-cd81ad2e-9783-4b91-867d-1b94f6af687a",
              "patient_name": patientName,
              "referred_doctor": refDocName,
              "scan_type": scanType,
              "differential_diagnosis": diffDiagnosis,
              "appointment_date": appointmentDate,
              "appointment_time": appointmentTime,
              "appointment_location": location,
              "hub_id": "hub-ab3c98a6-bf64-4cf3-8ffb-8401bb5b3b04",
              "doctor_id": "doctor-cd81ad2e-9783-4b91-867d-1b94f6af687a",
              "robot_id": "robot-076803af-8c57-4289-a5b8-cc3d9feeb136"
            }));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);

        notifyListeners();
        return createNewAppointmentModelFromJson(response.body);
      } else {
        return createNewAppointmentModelFromJson(response.body);
      }
    } catch (e) {
      print("CreateNewAppointmentModel Error:--> $e");
    }
  }

  // ******************************************* APPOINTMENT LIST ***********************************************

  List<AppointmentList> _appointments = [];
  List<AppointmentList> get appointments => _appointments;
  int appointmentsCount = 0;

  List<AppointmentList> parseAppointments(responseBody) {
    final parsed = json.decode(responseBody);
    final List<dynamic> appointmentList = parsed['data'];
    return appointmentList.map((json) {
      return AppointmentList(
        patientId: json["patient_id"],
        patientName: json["patient_name"],
        radiologistName: json["radiologist_name"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        appointmentTime: json["appointment_time"],
        robotLocation: json["robot_location"],
      );
    }).toList();
  }

  void generatedAppoinmentList(String date) async {
    final http.Response response =
        await http.post(Uri.parse("${baseUrl}list-of-appointments-and-count"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'user-agent': version,
              'Authorization': 'Bearer $globalAccessToken'
            },
            body: jsonEncode(<String, String>{"selected_date": date}));

    try {
      if (response.statusCode == 200) {
        _appointments = parseAppointments(response.body);
        appointmentsCount = parseAppointments(response.body).length;
        print(_appointments);
        notifyListeners();
      } else {
        return null;
      }
    } catch (e) {
      print("Error:--> $e");
    }
  }

  // ******************************************* PATIENT DETAILS LIST ***********************************************

  List<PatientDetails> patientList = [];
  List patientNameList = [];

  void listOfPatients(mobNumber) {
    generatePatientList(mobNumber: mobNumber).then((value) {
      if (value!.data.isEmpty) {
        patientList = [];
        patientNameList = [];
        notifyListeners();
      } else {
        for (var i = 0; i < value.data.length; i++) {
          patientNameList.add(value.data[i].patientName);
        }

        patientList = [...value.data];
        print("patientNameList: $patientNameList");
        notifyListeners();
      }
    });
  }

  Future<PatientDetailsModel?> generatePatientList(
      {required String mobNumber}) async {
    final http.Response response = await http.post(
        Uri.parse("${baseUrl}get-patient-info"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-agent': version,
          'Authorization': 'Bearer $globalAccessToken'
        },
        body: jsonEncode(<String, dynamic>{
          "patient_phone_number": mobNumber,
          "client_id": globalUserID
        }));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);

        notifyListeners();
        return patientDetailsModelFromJson(response.body);
      } else {
        return patientDetailsModelFromJson(response.body);
      }
    } catch (e) {
      print("Error:--> $e");
    }
  }
}
