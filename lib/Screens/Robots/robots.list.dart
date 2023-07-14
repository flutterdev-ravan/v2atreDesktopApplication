import 'package:atre_windows/Controller/hub_robot_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../Constants/myColors.dart';
import '../../Constants/myWidgets.dart';

class RobotsList extends StatefulWidget {
  const RobotsList({super.key});

  @override
  State<RobotsList> createState() => _RobotsListState();
}

class _RobotsListState extends State<RobotsList> {
  List<RobotDetails> robot = <RobotDetails>[];
  RobotDataSource? robotDataSource;

  @override
  void initState() {
    super.initState();
    robot = getEmployeeData();
    robotDataSource = RobotDataSource(robotData: robot);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            myWidgets.searchField(),
            const SizedBox(height: 10),
            SizedBox(
              height: height / 2,
              child: SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.none,
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  source: robotDataSource!,
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'Robot Name',
                        label: Container(
                            decoration: BoxDecoration(
                                color: myColors.whiteColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Robot Name',
                            ))),
                    GridColumn(
                        columnName: 'Robot location',
                        label: Container(
                            color: myColors.whiteColor,
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Robot Location',
                            ))),
                    GridColumn(
                        columnName: 'button',
                        label: Container(
                            color: myColors.whiteColor,
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              '',
                            ))),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class RobotDetails {
  RobotDetails(
    this.hubName,
    this.location,
  );
  final String hubName;
  final String location;
}

List<RobotDetails> getEmployeeData() {
  return [
    RobotDetails(
      "Royal Care",
      "Coimbatore",
    ),
    RobotDetails(
      "KMCH",
      "Coimbatore",
    ),
    RobotDetails(
      "TMF-HSP",
      "Coimbatore",
    ),
  ];
}

class RobotDataSource extends DataGridSource {
  RobotDataSource({required List<RobotDetails> robotData}) {
    _robotData = robotData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Robot Name', value: e.hubName),
              DataGridCell<String>(
                  columnName: 'Robot Location', value: e.location),
              DataGridCell<String>(columnName: 'button', value: e.toString()),
            ]))
        .toList();
  }

  List<DataGridRow> _robotData = [];

  @override
  List<DataGridRow> get rows => _robotData;
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
          return Consumer<RobotProvider>(
            builder: (context, snapshot, child) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: e.columnName == 'button'
                    ? LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                        return Row(
                          children: [
                            Expanded(
                                child: myWidgets.buttonIconColor(
                                    borderColor: myColors.lightBlueColor,
                                    backGroundColor: myColors.whiteColor,
                                    onPressed: () {
                                      snapshot.robotDetailsShow();
                                    },
                                    icon: (FontAwesomeIcons.robot),
                                    iconColor: myColors.lightBlueColor,
                                    labelText: 'View details',
                                    labelColor: myColors.lightBlueColor)),
                          ],
                        );
                      })
                    : Text(e.value.toString())),
          );
        }).toList());
  }
}
