import 'package:ceper/model/address.dart';
import 'package:ceper/model/result.dart';
import 'package:ceper/repositories/http_interceptor.dart';
import 'package:dio/dio.dart';

abstract class CrudInterface {
  Future<bool> upsert(Address address);
  Future<bool> delete(Address address);
  Future<List<Address>> fetchRemote();
}

class AddressRepository implements CrudInterface {
  //change to repository
  var _dio = Dio();

  AddressRepository() {
    _dio.options.headers['X-Parse-Application-Id'] =
        'GkbL1jJf6HIPXrPddtkzciYbksgdlmu90pHoUJ63';
    _dio.options.headers['X-Parse-REST-API-Key'] =
        'e4PT4lI8eoHqHjSY86ZEkEe4lcjcOIvGe1iZ1yUx';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
    //_dio.interceptors = HttpInterceptor();
  }

  @override
  Future<bool> delete(Address address) async {
    // TODO: implement delete
    var result = await _dio.delete('/Endereco');
    return (result.statusCode ?? 0) >= 200 && (result.statusCode ?? 0) <= 300;
  }

  @override
  Future<List<Address>> fetchRemote() async {
    var result = await _dio.get('/Endereco');
    //return Address.fromJson();
    print('res= $result');
    return Result.fromJson(result.data).results; // to list!!
  }

  @override
  Future<bool> upsert(Address address) async {
    try {
      print('will try to insert ${address.toMap()}');
      var result = await _dio.post('/Endereco', data: address.toMap());
      return (result.statusCode ?? 0) == 204;
    } on Exception catch (e) {
      print('exception $e');
      return false;
    }
  }

  Future<Address> fetchAddress(String zipCode) async {
    var result = await _dio.get('https://viacep.com.br/ws/$zipCode/json/');
    Address address = Address.fromViaJson(result.data);
    return address;
  }
}
