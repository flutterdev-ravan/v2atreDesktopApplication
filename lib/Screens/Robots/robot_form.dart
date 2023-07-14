import 'package:atre_windows/Constants/myWidgets.dart';
import 'package:atre_windows/Controller/hub_robot_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/myColors.dart';

class RobotForm extends StatefulWidget {
  const RobotForm({super.key});

  @override
  State<RobotForm> createState() => _RobotFormState();
}

class _RobotFormState extends State<RobotForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RobotProvider>(
      builder: (context, snap, child) => Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myWidgets.titleText(title: "New Robot"),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: myWidgets.containerDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                    children: [
                                      myWidgets.formField(
                                          labelText: 'Name',
                                          hintText: '',
                                          controller: snap.nameTextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 2',
                                          hintText: '',
                                          controller:
                                              snap.setting2TextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 4',
                                          hintText: '',
                                          controller:
                                              snap.setting4TextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 6',
                                          hintText: '',
                                          controller:
                                              snap.setting4TextController)
                                    ],
                                  )),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      myWidgets.formField(
                                          labelText: 'Setting Value 1',
                                          hintText: '',
                                          controller:
                                              snap.setting1TextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 3',
                                          hintText: '',
                                          controller:
                                              snap.setting3TextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 5',
                                          hintText: '',
                                          controller:
                                              snap.setting4TextController),
                                      myWidgets.formField(
                                          labelText: 'Setting Value 7',
                                          hintText: '',
                                          controller:
                                              snap.setting4TextController),
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  myWidgets.buttonIcon(
                                      iconSize: 20,
                                      backGroundColor: myColors.greyButtonColor,
                                      onPressed: () {
                                        snap.isAddRobotFalse();
                                        snap.emptyShow();
                                      },
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
                    Expanded(child: Text(""))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
