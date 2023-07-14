// To parse this JSON data, do
//
//     final createNewAppointmentModel = createNewAppointmentModelFromJson(jsonString);

import 'dart:convert';

CreateNewAppointmentModel createNewAppointmentModelFromJson(String str) =>
    CreateNewAppointmentModel.fromJson(json.decode(str));

String createNewAppointmentModelToJson(CreateNewAppointmentModel data) =>
    json.encode(data.toJson());

class CreateNewAppointmentModel {
  String message;
  bool status;
  CreateNewAppointmentModelData data;

  CreateNewAppointmentModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CreateNewAppointmentModel.fromJson(Map<String, dynamic> json) =>
      CreateNewAppointmentModel(
        message: json["message"],
        status: json["status"],
        data: CreateNewAppointmentModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class CreateNewAppointmentModelData {
  bool status;
  bool response;
  DataData data;

  CreateNewAppointmentModelData({
    required this.status,
    required this.response,
    required this.data,
  });

  factory CreateNewAppointmentModelData.fromJson(Map<String, dynamic> json) =>
      CreateNewAppointmentModelData(
        status: json["status"],
        response: json["response"],
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "data": data.toJson(),
      };
}

class DataData {
  DataData();

  factory DataData.fromJson(Map<String, dynamic> json) => DataData();

  Map<String, dynamic> toJson() => {};
}
