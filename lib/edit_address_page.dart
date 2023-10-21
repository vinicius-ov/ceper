import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/address_repository.dart';
import 'package:flutter/material.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage(
      {super.key,
      required this.title,
      required this.address,
      required this.addressRepository});
  final String title;
  final Address address;
  final AddressRepository addressRepository;

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  var nameInputController = TextEditingController(text: '');
  var districtInputController = TextEditingController(text: '');
  var cityInputController = TextEditingController(text: '');

  late Address _address;
  late AddressRepository _addressRepository;

  @override
  void initState() {
    super.initState();
    _address = widget.address;
    debugPrint('address ${_address.toMap()}');
    _addressRepository = widget.addressRepository;
    nameInputController.text = _address.getName;
    districtInputController.text = _address.getDistrict;
    cityInputController.text = _address.getCity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            GestureDetector(
                onTap: () async {
                  debugPrint('will save...');
                  bool success = await _addressRepository.update(_address);
                  if (success) {
                    debugPrint('save succesful...');
                    //Navigator.pop(context);
                  }
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.save_alt))),
          ],
        ),
        body: Column(children: [
          Text('Editar endereço do CEP ${_address.getZipCode}'),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameInputController,
          ),
          TextField(
            controller: districtInputController,
          ),
          TextField(
            controller: cityInputController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () async {
                bool success = await _addressRepository.delete(_address);
                if (success) {
                  //Navigator.pop(context);
                }
              },
              child: const Text('Deletar'))
        ]));
  }
}
