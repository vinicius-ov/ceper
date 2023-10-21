import 'package:brasil_fields/brasil_fields.dart';
import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/address_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCepPage extends StatefulWidget {
  const AddCepPage(
      {super.key, required this.title, required this.addressRepository});
  final String title;
  final AddressRepository addressRepository;

  @override
  State<AddCepPage> createState() => _AddCepPageState();
}

class _AddCepPageState extends State<AddCepPage> {
  var cepInputController = TextEditingController(text: '');
  Address _address = Address.empty();
  bool _fetching = false;
  late AddressRepository _addressRepository;

  @override
  void initState() {
    super.initState();
    _addressRepository = widget.addressRepository;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
                decoration: const InputDecoration(
                    hintText: '00000-000',
                    hintStyle: TextStyle(color: Colors.grey)),
                keyboardType: TextInputType.number,
                controller: cepInputController),
            _fetching
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: () async {
                      if (cepInputController.text.length == 8) {
                        setState(() {
                          _fetching = true;
                        });
                        _address = Address.empty();
                        String zip = UtilBrasilFields.removeCaracteres(
                            cepInputController.text);
                        _address = await _addressRepository.fetchAddress(zip);

                        if (_address.getZipCode.isNotEmpty) {
                          debugPrint('button called upsert');
                          await _addressRepository.insert(_address);
                        }

                        setState(() {
                          _fetching = false;
                        });
                      }
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text(
                      "Buscar CEP",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2), color: Colors.amber),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('CEP: ${_address.getZipCode}'),
                  Text('Logradouro: ${_address.getName}'),
                  Text('Bairro: ${_address.getDistrict}'),
                  Text('Cidade: ${_address.getCity}'),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
