class USerModel {
  String? secName;
  int? age;
  USerModel({
     this.secName,
     this.age,
  });

  USerModel.fromjson(Map<dynamic, dynamic> map) {
    secName = map['secName'];
    age = map['age'];
  }

  ToJSON() {
    return {
      'secName': secName,
      'age': age,
    };
  }
}
