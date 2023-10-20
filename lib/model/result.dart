import 'package:ceper/model/address.dart';

class Result {
  List<Address> results = [];

  Result({required this.results});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Address.fromB4aJson(v));
      });
    }
  }
}
