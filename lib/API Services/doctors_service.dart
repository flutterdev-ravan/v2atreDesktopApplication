import 'dart:convert';

import 'package:atre_windows/Constants/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/doctorModel/doctors_list_model.dart';
import '../Model/doctorModel/list_all_doctor_service.dart';

class DoctorApi extends ChangeNotifier {
  // ******************************************************* Generated Doctor List *****************************************************************
  List<DoctorList> _doctors = [];
  List<DoctorList> get doctors => _doctors;
  int doctorsCounts = 0;

  List<DoctorList> parseDoctors(responseBody) {
    final parsed = json.decode(responseBody);
    final List<dynamic> doctorList = parsed['data'];
    return doctorList.map((json) {
      return DoctorList(
        doctorId: json["doctor_id"],
        doctorName: json["doctor_name"],
        doctorRegistrationNumber: json["doctor_registration_number"],
        doctorEmail: json["doctor_email"],
        hospitalName: json["hospital_name"],
        doctorPhoneNumber: json["doctor_phone_number"],
        radiologistLicenseNumber: json["radiologist_license_number"],
        timeSlot: List<String>.from(json["time_slot"].map((x) => x)),
        clientId: json["client_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );
    }).toList();
  }

  void generatedDoctorList() async {
    final http.Response response = await http
        .get(Uri.parse("${baseUrl}list-all-doctor"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $globalAccessToken'
    });
    try {
      if (response.statusCode == 200) {
        _doctors = parseDoctors(response.body);
        doctorsCounts = parseDoctors(response.body).length;
        print(_doctors);
        notifyListeners();
      } else {
        return null;
      }
    } catch (e) {
      print("generatedDoctorList Error:-->$e");
    }
  }

  // ******************************************************* Doctor List *****************************************************************

  List doctorNameList = [];

  void listOfDoctors() {
    doctorDetailsList().then((value) {
      if (value!.data.isEmpty) {
        doctorNameList = [];
        notifyListeners();
      } else {
        for (var i = 0; i < value.data.length; i++) {
          doctorNameList.add(value.data[i].doctorName);
        }

        notifyListeners();
      }
      print("doctorNameList: $doctorNameList");
    });
  }

  Future<DoctorDetailsModel?> doctorDetailsList() async {
    final http.Response response = await http.get(
      Uri.parse("${baseUrl}list-all-doctor"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'user-agent': version,
        'Authorization': 'Bearer $globalAccessToken'
      },
    );

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);

        notifyListeners();
        return doctorDetailsModelFromJson(response.body);
      } else {
        return doctorDetailsModelFromJson(response.body);
      }
    } catch (e) {
      print("doctorDetailsList Error:--> $e");
    }
    return null;
  }
}
