// ignore_for_file: prefer_final_fields, constant_identifier_names, body_might_complete_normally_nullable

import 'package:atre_windows/API%20Services/appointment_Service.dart';
import 'package:atre_windows/Constants/myColors.dart';
import 'package:atre_windows/Model/appointmentModel/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

enum TextFieldType {
  PATIENT_NAME,
  APPOINTMENT_LOCATION,
  REF_DOC,
  SCAN_TYPE,
  DOC_NAME,
  RAD_NAME,
  DATE,
  TIME
}

class AppointmentProvider extends ChangeNotifier {
//************************************************ Appointment List Provider *********************************************************
  AppointmentDataSource? _appointmentDataSource;
  DateTime _today = DateTime.now();
  bool _isVisible = true;
  bool _isAppointment = true;

  bool get isVisible => _isVisible;
  bool get isAppointment => _isAppointment;
  DateTime get today => _today;
  AppointmentDataSource? get appointmentDataSource => _appointmentDataSource;

  void isAppointmentFalse() {
    _isAppointment = false;
    notifyListeners();
  }

  void isAppointmentTrue() {
    _isAppointment = true;
    notifyListeners();
  }

  void isVisibleTrue() {
    _isVisible = true;
    notifyListeners();
  }

  void isVisibleFalse() {
    _isVisible = false;
    notifyListeners();
  }

  void dateFormat(
    BuildContext context,
    DateTime day,
  ) {
    final appointmentApi = Provider.of<AppoinmentApi>(context, listen: false);

    _today = day;

    appointmentApi
        .generatedAppoinmentList(DateFormat("yyyy-MM-dd").format(today));
    notifyListeners();
  }

//************************************************ Create Appointment Provider *********************************************************

  String? pickDate;
  final selectedDate = TextEditingController();

  final diffDiagnosis = TextEditingController();
  final search = TextEditingController();
  final format = DateFormat("dd / MM / yyyy");
  DateTime date = DateTime.now();
  String? patientName;
  String? locationName;
  String? scanTypeName;
  String? refDocName;
  String? docName;
  String? radiologistName;
  String? timeSlot;

  List<dynamic> location = ["Coimbatore", "Chennai", "Thiruvarur", 'Selam'];
  List<dynamic> timeSlotList = ["12:00 AM", "04:30 PM", "06:00 PM", "08:00 AM"];

  List<dynamic> scanType = [
    "X-Ray",
    "MRI",
    "Electrocardiogram (ECG)",
    'CT scan'
  ];
  List<dynamic> refDoc = ["Ravan", "Sachin", "Gowsalya", 'Manisha', 'Malavika'];

  // ----------------------------------------------- FORM FIELD VALIDATION -----------------------------------------------------------------------

  TextFieldType? fieldType;

  String? textFormValidation(textFieldType, value) {
    switch (textFieldType) {
      // Your Enum Value which you have passed
      case TextFieldType.PATIENT_NAME:
        //Your validations for patient name
        return value == null ? 'Please enter your patient name' : null;

      case TextFieldType.APPOINTMENT_LOCATION:
        //Your validations for appointment location
        return value == null ? 'Please enter your location' : null;

      case TextFieldType.DATE:
        //Your validations for date
        return value == null ? 'Please enter your date' : null;

      case TextFieldType.DOC_NAME:
        //Your validations for doctor name
        return value == null ? 'Please enter your doctor name' : null;

      case TextFieldType.RAD_NAME:
        //Your validations for radiologist name
        return value == null ? 'Please enter your radiologist name' : null;

      case TextFieldType.REF_DOC:
        //Your validations for ref doctor
        return value == null ? 'Please enter your referred doctor' : null;

      case TextFieldType.SCAN_TYPE:
        //Your validations for scan type
        return value == null ? 'Please enter your scan type' : null;
    }
  }

// For patient Name onchange
  void patientNameValue(value) {
    patientName = value;
    print(patientName);
    notifyListeners();
  }

  // For Scan Type  Name onchange
  void scanTypeValue(value) {
    scanTypeName = value;
    print(scanTypeName);
    notifyListeners();
  }

  // For Location Name onchange
  void locationValue(value) {
    locationName = value;
    print(locationName);
    notifyListeners();
  }

  // For Ref Doc Name onchange
  void refDocValue(value) {
    refDocName = value;
    print(refDocName);
    notifyListeners();
  }

  // For Time Slot Name onchange
  void timeSlotValue(value) {
    timeSlot = value;
    print(timeSlot);
    notifyListeners();
  }
}

// ***************** Table Components **********************

class AppointmentDataSource extends DataGridSource {
  AppointmentDataSource(this.appointmentList) {
    buildDataGridRow();
  }

  List<DataGridRow> _appointmentData = [];
  List<AppointmentList> appointmentList = [];

  void buildDataGridRow() {
    _appointmentData = appointmentList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'patientID', value: e.patientId),
              DataGridCell<String>(columnName: 'name', value: e.patientName),
              DataGridCell<String>(
                  columnName: 'radiologist', value: e.radiologistName),
              DataGridCell<dynamic>(
                  columnName: 'date',
                  value: DateFormat('dd-MM-yyyy').format(e.appointmentDate)),
              DataGridCell<String>(
                  columnName: 'time', value: e.appointmentTime),
              DataGridCell<String>(
                columnName: 'robotLocation',
                value: e.robotLocation,
              )
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _appointmentData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return myColors.greyBgColor;
      } else {
        return myColors.greyBg2Color;
      }
    }

    return DataGridRowAdapter(
        color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((e) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5),
            child: Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            ),
          );
        }).toList());
  }
}
