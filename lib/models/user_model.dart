class UserModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}