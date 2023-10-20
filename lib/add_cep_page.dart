import 'package:brasil_fields/brasil_fields.dart';
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
            TextButton(
                onPressed: () {
                  debugPrint('fgffdf');
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
                  Text('CEP: '),
                  Text('Logradouro: '),
                  Text('Bairro: '),
                  Text('Cidade: '),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
