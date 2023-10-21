import 'package:ceper/add_cep_page.dart';
import 'package:ceper/edit_address_page.dart';
import 'package:ceper/model/address.dart';
import 'package:ceper/repositories/address_repository.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Address> _history = List.empty(growable: true);
  final AddressRepository _addressRepository = AddressRepository();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _history = await _addressRepository.fetchRemote();
    setState(() {});
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
                  _loadData();
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.refresh))),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCepPage(
                              title: 'Buscar CEP',
                              addressRepository: _addressRepository)));
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
                      ? const Text(
                          'Histórico vazio. Toque no + acima para inserir.')
                      : Scrollbar(
                          child: ListView.builder(
                          itemCount: _history.length,
                          itemBuilder: (BuildContext bc, int index) {
                            Address address = _history[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditAddressPage(
                                                title: 'Editar endereço',
                                                address: address,
                                                addressRepository:
                                                    _addressRepository,
                                              )));
                                },
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('CEP: ${address.getZipCode}'),
                                        Text(
                                            'Logradouro: ${address.getDistrict}'),
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Bairro: ${address.getDistrict}'),
                                        Text('Cidade: ${address.getCity}'),
                                      ]),
                                  const Divider(
                                    thickness: 3.0,
                                  )
                                ]));
                          },
                        )))
            ])));
  }
}
