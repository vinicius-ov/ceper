import 'package:ceper/model/address.dart';

abstract class CrudInterface {
  Future<bool> upsert(Address address);
  Future<bool> delete(Address address);
  Future<Address> fetch();
}
