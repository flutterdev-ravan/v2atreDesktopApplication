import 'package:atre_windows/Controller/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/myColors.dart';
import '../../Constants/myWidgets.dart';
import 'patients_widgets.dart';

enum PatientDetailsContainer {
  patientDetails,
  emptyContainer,
  editPatientDetails,
}

Widget getPatientDetailsContainer({required selectContainer}) {
  switch (selectContainer) {
    case PatientDetailsContainer.patientDetails:
      return patientDetails();
    case PatientDetailsContainer.editPatientDetails:
      return editPatientDetails();
    case PatientDetailsContainer.emptyContainer:
      return emptyContainer();
  }
  return emptyContainer();
}

Widget emptyContainer() {
  return Container();
}

Widget patientDetails() {
  return Consumer<PatientProvider>(
      builder: (context, snapshot, child) =>
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: myColors.whiteContainerColor,
                  boxShadow: [
                    BoxShadow(
                      color: myColors.greyShadowColor.withOpacity(0.5),
                      spreadRadius: 1.5,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myWidgets.detailsText(title: "Patient Details"),
                          myWidgets.buttonIconColor(
                              onPressed: () {
                                snapshot.editPatientDetails();
                              },
                              icon: (Icons.edit_document),
                              iconColor: myColors.lightBlueColor,
                              labelText: 'Edit',
                              labelColor: myColors.lightBlueColor,
                              backGroundColor: myColors.whiteColor,
                              borderColor: myColors.lightBlueColor),
                        ],
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  myWidgets.greyText(title: "Patient ID"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myWidgets.miniDetailsText(title: "patientID"),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  myWidgets.greyText(title: "Name"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myWidgets.miniDetailsText(title: "name"),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  myWidgets.greyText(title: "Email"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myWidgets.miniDetailsText(title: "email"),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  myWidgets.greyText(title: "Address"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myWidgets.miniDetailsText(title: "address"),
                                ],
                              )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              myWidgets.greyText(title: "DOB"),
                              const SizedBox(
                                height: 20,
                              ),
                              myWidgets.miniDetailsText(title: "dob"),
                              const SizedBox(
                                height: 25,
                              ),
                              myWidgets.greyText(title: "Gender"),
                              const SizedBox(
                                height: 20,
                              ),
                              myWidgets.miniDetailsText(title: "gender"),
                              const SizedBox(
                                height: 25,
                              ),
                              myWidgets.greyText(title: "Marital Status"),
                              const SizedBox(
                                height: 20,
                              ),
                              myWidgets.miniDetailsText(title: "maritalStatus"),
                              const SizedBox(
                                height: 25,
                              ),
                              myWidgets.greyText(title: "Emergency contact"),
                              const SizedBox(
                                height: 20,
                              ),
                              myWidgets.miniDetailsText(title: "emgContact"),
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                ))
          ]));
}

//**********************************Patient Details Card Edit*************************************/

Widget editPatientDetails() {
  return Consumer<PatientProvider>(
    builder: (context, snapshot, child) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: myColors.whiteContainerColor,
            boxShadow: [
              BoxShadow(
                color: myColors.greyShadowColor.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: myWidgets.detailsText(title: "Patient Details")),
                    Row(children: [
                      myWidgets.buttonIconColor(
                          borderColor: myColors.lightBlueColor,
                          onPressed: () {
                            snapshot.emptyShow();
                          },
                          icon: (Icons.edit_document),
                          iconColor: myColors.lightBlueColor,
                          labelText: 'Cancel',
                          labelColor: myColors.lightBlueColor,
                          backGroundColor: myColors.whiteColor),
                      const SizedBox(
                        width: 10,
                      ),
                      myWidgets.buttonIconColor(
                          borderColor: myColors.greenColor,
                          onPressed: () {
                            snapshot.patientDetails();
                          },
                          icon: (Icons.edit_document),
                          iconColor: myColors.greenColor,
                          labelText: 'Save',
                          labelColor: myColors.greenColor,
                          backGroundColor: myColors.whiteColor),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myWidgets.greyText(title: "Patient ID"),
                            const SizedBox(
                              height: 5,
                            ),
                            myWidgets.miniDetailsText(title: "AM-1013"),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/warning.png",
                                  height: 30,
                                ),
                                Expanded(
                                  child: patientWidget.orangeText(
                                      text: "Patient ID cannot be changed"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Name"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Email"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Address"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.extendTextField(),
                          ],
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myWidgets.greyText(title: "DOB"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Gender"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Marital Status"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 15,
                            ),
                            myWidgets.greyText(title: "Emergency contact"),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                            const SizedBox(
                              height: 10,
                            ),
                            patientWidget.field(),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
