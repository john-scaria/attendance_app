class AdminProfileModel {
  final String fullName;
  final String password;

  AdminProfileModel(
    this.fullName,
    this.password,
  );

  AdminProfileModel.fromMap(Map<String, dynamic> data)
      : fullName = data['full_name'],
        password = data['password'];

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'password': password,
    };
  }
}
