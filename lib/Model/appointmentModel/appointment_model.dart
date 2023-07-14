class AppointmentList {
  String patientId;
  String patientName;
  String radiologistName;
  DateTime appointmentDate;
  String appointmentTime;
  String robotLocation;

  AppointmentList({
    required this.patientId,
    required this.patientName,
    required this.radiologistName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.robotLocation,
  });
}
