import 'package:brasil_fields/brasil_fields.dart';
import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/address_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCepPage extends StatefulWidget {
  const AddCepPage({super.key, required this.title});
  final String title;

  @override
  State<AddCepPage> createState() => _AddCepPageState();
}

class _AddCepPageState extends State<AddCepPage> {
  var cepInputController = TextEditingController(text: '');
  final AddressRepository addressRepository = AddressRepository();
  Address _address = Address.empty();
  bool _fetching = false;

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
                      setState(() {
                        _fetching = true;
                      });
                      _address = Address.empty();
                      String zip = UtilBrasilFields.removeCaracteres(
                          cepInputController.text);
                      _address = await addressRepository.fetchAddress(zip);

                      setState(() {
                        _fetching = false;
                      });
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
                  Text('CEP: ${_address.zipCode}'),
                  Text('Logradouro: ${_address.name}'),
                  Text('Bairro: ${_address.district}'),
                  Text('Cidade: ${_address.city}'),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
