import 'package:agenda_contatos/model/address_model.dart';
import 'package:agenda_contatos/repository/cep_repository.dart';
import 'package:agenda_contatos/widgets/address_field_widgets.dart';
import 'package:agenda_contatos/widgets/forms_input_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Gender { male, female }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Novo contato:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController textEditingName = TextEditingController();
  TextEditingController textEditingPhone = TextEditingController();
  TextEditingController textEditingCep = TextEditingController();

  CepRepository cepRepository = CepRepository();
  Address? address;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool isSelectMale = false;
  bool isSelectFemale = false;

  bool isLoading = false;
  String msgErrorCep = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              formsInput(
                  ctx: context,
                  description: "Nome",
                  textController: textEditingName,
                  sizeWidth: 0.5,
                  sizeHeight: 0.15),
              formsInput(
                  ctx: context,
                  description: "Telefone",
                  textController: textEditingPhone,
                  sizeWidth: 0.5,
                  sizeHeight: 0.15),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelectMale = true;
                        isSelectFemale = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      height: size.height * 0.07,
                      // width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: isSelectMale
                              ? Colors.blueAccent
                              : Colors.grey[200]),
                      child: Center(
                          child: Text(
                        "Masculino",
                        style: TextStyle(
                            color: isSelectMale ? Colors.white : Colors.black),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelectMale = false;
                        isSelectFemale = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      height: size.height * 0.07,
                      // width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: isSelectFemale
                              ? Colors.blueAccent
                              : Colors.grey[200]),
                      child: Center(
                          child: Text(
                        "Feminino",
                        style: TextStyle(
                            color:
                                isSelectFemale ? Colors.white : Colors.black),
                      )),
                    ),
                  ),
                ],
              ),
              Text("Endereço:"),
              TextFormField(
                controller: textEditingCep,
                decoration: const InputDecoration(hintText: "Digite o cep"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                      address = null;
                    });

                    try {
                      address =
                          await cepRepository.getAddress(textEditingCep.text);
                      textEditingCep.clear();
                    } catch (e) {
                      setState(() {
                        msgErrorCep = "Não foi possivel localizar o endereço, tente novamete com um cep valido!";
                        isLoading = false;
                      });
                    }

                    await Future.delayed(const Duration(seconds: 3), () {});
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text("Buscar Endereço")),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Buscando endereço, aguarde...")
                      ],
                    )
                  : Column(
                      children: [
                        if (address != null && address!.bairro != null) ...{
                          AddressField(
                              description: "CEP",
                              addressField: address!.cep!),
                          AddressField(
                              description: "Logradouro",
                              addressField: address!.logradouro!),
                          AddressField(
                              description: "Complemento",
                              addressField: address!.complemento!),
                          AddressField(
                              description: "unidade",
                              addressField: address!.unidade!),
                          AddressField(
                              description: "bairro",
                              addressField: address!.bairro!),
                          AddressField(
                              description: "localidade",
                              addressField: address!.localidade!),
                          AddressField(
                              description: "uf", addressField: address!.uf!),
                          AddressField(
                              description: "ibge",
                              addressField: address!.ibge!),
                          AddressField(
                              description: "gia", addressField: address!.gia!),
                          AddressField(
                              description: "ddd", addressField: address!.ddd!),
                          AddressField(
                              description: "siafi",
                              addressField: address!.siafi!),
                        } else... {
                              Text(msgErrorCep),
                        }
                      ],
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
