// ignore_for_file: body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers

import 'package:atre_windows/Constants/myWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../API Services/appointment_Service.dart';
import '../../API Services/doctors_service.dart';
import '../../Constants/myColors.dart';
import '../../Controller/appointment_controller.dart';
import 'appointment_widgets.dart';
import 'package:intl/intl.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Provider.of<AppointmentProvider>(context, listen: false);
    Provider.of<AppoinmentApi>(context, listen: false);
    final _doctorApi = Provider.of<DoctorApi>(context, listen: false);
    _doctorApi.listOfDoctors();
  }

  Widget build(BuildContext context) {
    final _appointmentApi = Provider.of<AppoinmentApi>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 120),
        child: Consumer3<AppointmentProvider, AppoinmentApi, DoctorApi>(
          builder: (context, snap, snapApi, docApi, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: myWidgets.titleText(title: 'New Appointment'),
                  ),
                  Expanded(
                      child: appointmentWidgets.mobileSearch(
                          controller: snap.search,
                          onTap: () {
                            snapApi.patientNameList.clear();
                            _appointmentApi.listOfPatients(snap.search.text);
                          }))
                ],
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Container(
                  height: 550,
                  width: double.infinity,
                  decoration: appointmentWidgets.containerBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  // ********************************************* Patient Name ***************************************************
                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.PATIENT_NAME, value);
                                    },
                                    onChange: snap.patientNameValue,
                                    labelText: "Patient Name",
                                    items: snapApi.patientNameList,
                                  ),

                                  // ********************************************* Scan Type **************************************************

                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.SCAN_TYPE, value);
                                    },
                                    onChange: snap.scanTypeValue,
                                    labelText: "Scan Type",
                                    items: snap.scanType,
                                  ),
                                  // ********************************************* Appointment Date ***************************************************

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 14),
                                    child: TextFormField(
                                      validator: (value) {
                                        snap.textFormValidation(
                                            TextFieldType.DATE, value);
                                      },
                                      controller: snap.selectedDate,
                                      readOnly: true,
                                      onChanged: (value) {
                                        snap.pickDate = value;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Appointment date",
                                          filled: true,
                                          fillColor: myColors.whiteColor,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: myColors.greenColor,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: myColors.greenColor,
                                            ),
                                          ),
                                          labelStyle: TextStyle(
                                              color: myColors.greenColor)),
                                      onTap: () async {
                                        snap.date = (await showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            initialDate: DateTime.now(),
                                            lastDate: DateTime(2100)))!;
                                        // ---------------------
                                        snap.selectedDate.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(snap.date);
                                        snap.pickDate = DateFormat("yyyy-MM-dd")
                                            .format(snap.date);
                                        print(snap.pickDate);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  // ********************************************* Appointment Location ***************************************************

                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.APPOINTMENT_LOCATION,
                                          value);
                                    },
                                    onChange: snap.locationValue,
                                    labelText: "Appointment Location",
                                    items: snap.location,
                                  ),

                                  // ********************************************* Doctor Name ***************************************************

                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.DOC_NAME, value);
                                    },
                                    onChange: (value) {
                                      setState(() {
                                        snap.docName = value;
                                      });
                                    },
                                    labelText: "Doctor Name",
                                    items: docApi.doctorNameList,
                                  ),
                                  // ********************************************* Appointment Time ***************************************************
                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.TIME, value);
                                    },
                                    onChange: snap.timeSlotValue,
                                    labelText: "Appointment Time",
                                    items: snap.timeSlotList,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  // ********************************************* Referred Doctor ***************************************************

                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.REF_DOC, value);
                                    },
                                    onChange: snap.refDocValue,
                                    labelText: "Referred Doctor",
                                    items: snap.refDoc,
                                  ),
                                  // ********************************************* Radiologist Name ***************************************************

                                  appointmentWidgets.dropdownButton(
                                    validator: (value) {
                                      snap.textFormValidation(
                                          TextFieldType.RAD_NAME, value);
                                    },
                                    onChange: snap.refDocValue,
                                    labelText: "Radiologist Name",
                                    items: snap.refDoc,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // ********************************************* Differential Diagnosis ***************************************************

                        appointmentWidgets.formField(
                            maxLines: 3,
                            labelText: 'Differential Diagnosis',
                            hintText: '',
                            controller: snap.diffDiagnosis),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: appointmentWidgets.button(
                                  label: 'Cancel',
                                  color: myColors.blackColor,
                                  onPressed: () {
                                    snap.isAppointmentTrue();
                                    docApi.doctorNameList.clear();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: myColors.blackColor,
                                  )),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: myColors.greenColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: appointmentWidgets.button(
                                  label: 'Create',
                                  color: myColors.whiteColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      snapApi.createAppointment(
                                          patientName: snap.patientName!,
                                          refDocName: snap.refDocName!,
                                          scanType: snap.scanTypeName!,
                                          diffDiagnosis:
                                              snap.diffDiagnosis.text,
                                          appointmentDate:
                                              snap.pickDate.toString(),
                                          appointmentTime: snap.timeSlot!,
                                          location: snap.locationName!);
                                      snap.isAppointmentTrue();
                                      docApi.doctorNameList.clear();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.group_add,
                                    color: myColors.whiteColor,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {},
                            child:
                                myWidgets.greenText(title: "Add New Patient")),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
