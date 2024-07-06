import 'package:agenda_contatos/model/address_model.dart';
import 'package:dio/dio.dart';

class CepRepository {
  var dio = Dio(BaseOptions(baseUrl: "https://viacep.com.br"));

  Future<Address> getAddress(String cep) async {
    Address? address;
    await dio.get("/ws/$cep/json/").then((value) {
      address = Address.fromMap(value.data);
    }).catchError((err) {
      throw err;
    });
    return address!;
  }
}
