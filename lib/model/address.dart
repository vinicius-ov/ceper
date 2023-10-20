class Address {
  String? _objectId;
  String? _createdAt;
  String? _updatedAt;
  String _zipCode;
  String _name;
  String _district;
  String _city;

  Address(String zipCode, String name, String district, String city)
      : _zipCode = zipCode,
        _name = name,
        _district = district,
        _city = city;

  Address.empty()
      : _zipCode = '',
        _name = '',
        _district = '',
        _city = '';

  String get getZipCode => _zipCode;
  String get getName => _name;
  String get getDistrict => _district;
  String get getCity => _city;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['zipCode'] = _zipCode;
    data['name'] = _name;
    data['district'] = _district;
    data['city'] = _city;
    return data;
  }

  static Address fromViaJson(Map<String, dynamic> result) {
    return Address(result['cep'], result['logradouro'], result['bairro'],
        result['localidade']);
  }

  static Address fromB4aJson(Map<String, dynamic> result) {
    return Address(
        result['zipCode'], result['name'], result['district'], result['city']);
  }

  @override
  String toString() {
    return 'Address => zipCode=$_zipCode | name=$_name | district=$_district | city=$_city';
  }
}
