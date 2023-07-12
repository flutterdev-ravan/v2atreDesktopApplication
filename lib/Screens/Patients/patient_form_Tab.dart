import 'package:atre_windows/Constants/myColors.dart';
import 'package:atre_windows/Constants/myWidgets.dart';
import 'package:atre_windows/Controller/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  State<PatientForm> createState() => _PatientFormState();
}

final _formPatientkey = GlobalKey<FormState>();

class _PatientFormState extends State<PatientForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, snap, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              //********************Patient Form******************//
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  decoration: myWidgets.containerDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //********************TextFormField******************//
                            Expanded(
                                child: Column(
                              children: [
                                myWidgets.formField(
                                    labelText: 'Name',
                                    hintText: '',
                                    controller: snap.nameTextController),
                                myWidgets.formField(
                                    labelText: 'Address',
                                    hintText: '',
                                    controller: snap.addressTextController),
                                myWidgets.formField(
                                    labelText: 'Phone',
                                    hintText: '',
                                    controller: snap.phoneTextController),
                                myWidgets.formField(
                                    labelText: 'Marital Status',
                                    hintText: '',
                                    controller:
                                        snap.maritalStatusTextController)
                              ],
                            )),
                            const SizedBox(width: 16.0),
                            Expanded(
                                child: Column(
                              children: [
                                myWidgets.formField(
                                    labelText: 'Date of Birth',
                                    hintText: '',
                                    controller: snap.dateOfBirthController),
                                myWidgets.formField(
                                    labelText: 'Pin Code',
                                    hintText: '',
                                    controller:
                                        snap.emergencyPhoneTextController),
                                myWidgets.formField(
                                    labelText: 'EmergencyPhone',
                                    hintText: '',
                                    controller:
                                        snap.emergencyPhoneTextController),
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            myWidgets.buttonIcon(
                                iconSize: 20,
                                backGroundColor: myColors.greyButtonColor,
                                onPressed: () {},
                                icon: (Icons.cancel),
                                iconColor: myColors.blackColor,
                                labelText: 'Cancel',
                                labelColor: myColors.blackColor),
                            const SizedBox(width: 30),
                            myWidgets.buttonIcon(
                                iconSize: 20,
                                backGroundColor: myColors.greenColor,
                                onPressed: () {},
                                icon: (Icons.group_add_outlined),
                                iconColor: myColors.whiteColor,
                                labelText: 'Create',
                                labelColor: myColors.whiteColor)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
