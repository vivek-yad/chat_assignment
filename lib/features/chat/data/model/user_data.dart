class UserData {
  UserData({
     this.email,
     this.userName,
     this.uid,
  });

  String ?email;
  String ?userName;
  String ?uid;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    email: json["email"],
    userName: json["userName"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "userName": userName,
    "uid": uid,
  };
}