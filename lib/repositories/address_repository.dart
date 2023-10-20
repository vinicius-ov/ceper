import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/http_interceptor.dart';
import 'package:dio/dio.dart';

abstract class CrudInterface {
  Future<bool> upsert(Address address);
  Future<bool> delete(Address address);
  Future<Address> fetch();
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
    _dio.options.baseUrl = '';
    //_dio.interceptors = HttpInterceptor();
  }

  @override
  Future<bool> delete(Address address) async {
    // TODO: implement delete
    var result = await _dio.delete('/Tarefas');
    return (result.statusCode ?? 0) >= 200 && (result.statusCode ?? 0) <= 300;
  }

  @override
  Future<Address> fetch() async {
    var result = await _dio.get('/Tarefas');
    //return Address.fromJson();
    return Address.empty(); // to list!!
  }

  @override
  Future<bool> upsert(Address address) async {
    try {
      var result = await _dio.post('/Tarefas', data: address.toMap());
      return (result.statusCode ?? 0) == 204;
    } on Exception catch (e) {
      print('exception $e');
      return false;
    }
  }

  Future<Address> fetchAddress(String zipCode) async {
    var result = await _dio.get('https://viacep.com.br/ws/$zipCode/json/');
    Address address = Address.fromJson(result.data);
    return address;
  }
}
