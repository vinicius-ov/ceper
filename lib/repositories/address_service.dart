import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/address_repository.dart';
import 'package:dio/dio.dart';

class AddressService implements CrudInterface {
  //change to repository
  var _dio = Dio();

  AddressService() {
    _dio.options.headers['X-Parse-Application-Id'] = 'askdlasdklajsldjlkasjdkl';
    _dio.options.headers['X-Parse-REST-API-Key'] = 'askdlasdklajsldjlkasjdkl';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['X-Parse-Application-Id'] =
        'askdlasdklajsldjlkasjdkl;';
    _dio.options.baseUrl = '';
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
      return false;
    }
  }
}
