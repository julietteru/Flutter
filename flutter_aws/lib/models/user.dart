class User {
  final String userName;
  final String email;
  final String password;

  User(this.userName, this.email, this.password);

  Map<String, dynamic> toJson() => {
        'username': this.userName,
        'email': this.email,
        'password': this.password
      };
}
