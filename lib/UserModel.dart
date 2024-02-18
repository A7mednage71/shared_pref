class UserModel {
  String? secName;
  int? age;
  UserModel({
    this.secName,
    this.age,
  });

  UserModel.fromJSON(Map<dynamic, dynamic> mp) {
    secName = mp['secName'];
    age = mp['age'];
  }

  toJSON() {
    return {
      'secName': secName, // key : value
      'age': age,
    };
  }
}
