class Address {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String zipCode;
  String name;
  String district;
  String city;

  String get getZipCode => this.zipCode;

  set setZipCode(String zipCode) => this.zipCode = zipCode;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getDistrict => this.district;

  set setDistrict(district) => this.district = district;

  get getCity => this.city;

  set setCity(city) => this.city = city;

  Address(
      {required this.zipCode,
      required this.name,
      required this.district,
      required this.city});

  static Address empty() {
    return Address(zipCode: '', name: '', district: '', city: '');
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = objectId;
    data['updatedAt'] = objectId;
    data['cep'] = objectId;
    data['name'] = objectId;
    data['district'] = objectId;
    data['city'] = objectId;
    return data;
  }
}
