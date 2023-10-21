import 'package:ceper/model/address.dart';
import 'package:ceper/model/result.dart';
import 'package:dio/dio.dart';

abstract class CrudInterface {
  Future<bool> insert(Address address);
  Future<bool> update(Address address);
  Future<bool> delete(Address address);
  Future<List<Address>> fetchRemote();
}

class AddressRepository implements CrudInterface {
  final _dio = Dio();

  AddressRepository() {
    _dio.options.headers['X-Parse-Application-Id'] = '';
    _dio.options.headers['X-Parse-REST-API-Key'] = '';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  @override
  Future<bool> delete(Address address) async {
    var result = await _dio.delete('/Endereco/${address.getObjectId}');
    return (result.statusCode ?? 0) >= 200 && (result.statusCode ?? 0) <= 300;
  }

  @override
  Future<List<Address>> fetchRemote() async {
    var result = await _dio.get('/Endereco');
    return Result.fromJson(result.data).results;
  }

  @override
  Future<bool> insert(Address address) async {
    try {
      var result = await _dio.post('/Endereco', data: address.toMap());
      return (result.statusCode ?? 0) == 200;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<Address> fetchAddress(String zipCode) async {
    var result = await _dio.get('https://viacep.com.br/ws/$zipCode/json/');
    Address address = Address.fromViaJson(result.data);
    return address;
  }

  @override
  Future<bool> update(Address address) async {
    try {
      var result = await _dio.put('/Endereco/${address.getObjectId}');
      return (result.statusCode ?? 0) == 200;
    } on Exception catch (e) {
      return false;
    }
  }
}
