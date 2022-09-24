class UserData {
  int id;
  String username;
  String email;
  String work;

  UserData({
    this.id = 0,
    this.username = "",
    this.email = "",
    this.work = "",
  }) {}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'work': work,
    };
  }

  static UserData? parseMap(Map<String, dynamic> decoded) {
    return UserData(
      id: decoded['id'],
      username: decoded['username'],
      email: decoded['email'],
      work: decoded['work'],
    );
  }
}
