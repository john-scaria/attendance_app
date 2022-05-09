class StaffProfileModel {
  final String fullName;
  final String type;
  final String password;

  StaffProfileModel(
    this.fullName,
    this.type,
    this.password,
  );

  StaffProfileModel.fromMap(Map<String, dynamic> data)
      : fullName = data['full_name'],
        type = data['type'],
        password = data['password'];

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'type': type,
      'password': password,
    };
  }
}
