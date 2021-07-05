class UserModel {
  int id;
  String userName;
  String email;
  String dob;
  String address;
  String password;

  UserModel({
    this.id,
    this.userName,
    this.email,
    this.dob,
    this.address,
    this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
      email: map['email'],
      dob: map['dob'],
      address: map['address'],
      password: map['password'],
    );
  }

  Map<String, dynamic> userMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['userName'] = userName;
    map['email'] = email;
    map['dob'] = dob;
    map['address'] = address;
    map['password'] = password;
    return map;
  }
}
