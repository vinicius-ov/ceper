import 'package:ceper/add_cep_page.dart';
import 'package:ceper/model/address.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Address> _history = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            GestureDetector(
                onTap: () {
                  debugPrint('tey raob');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddCepPage(title: 'Buscar CEP')));
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.add))),
          ],
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Expanded(
                  child: _history.isEmpty
                      ? const Text('Histórico vazio')
                      : Scrollbar(
                          child: ListView.builder(
                              itemCount: _history.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var address = _history[index];
                                return Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('CEP: ${address.zipCode}'),
                                        Text(
                                            'Logradouro: ${address.getName()}'),
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            'Bairro: ${address.getDistrict()}'),
                                        Text('Cidade: ${address.getCity()}'),
                                      ]),
                                  const Divider(
                                    thickness: 3.0,
                                  )
                                ]);
                              })))
            ])));
  }
}
