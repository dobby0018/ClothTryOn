class User {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNo;
  final String password;
  final String userType;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.password,
    this.userType = 'user',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      password: json['password'],
      userType: json['userType'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
      'userType': userType,
    };
  }
}