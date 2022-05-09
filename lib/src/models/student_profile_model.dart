class StudentProfileModel {
  final String fullName;
  final int rollNo;
  final String department;
  final String semester;
  final String password;

  StudentProfileModel(
    this.fullName,
    this.rollNo,
    this.department,
    this.semester,
    this.password,
  );

  StudentProfileModel.fromMap(Map<String, dynamic> data)
      : fullName = data['full_name'],
        rollNo = data['roll_no'],
        department = data['department'],
        semester = data['semester'],
        password = data['password'];

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'roll_no': rollNo,
      'department': department,
      'semester': semester,
      'password': password,
    };
  }
}
