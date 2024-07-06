class Address {
  String? cep;
  String? logradouro;
  String? complemento;
  String? unidade;
  String? bairro;
  String? localidade;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;

  Address(
      this.cep,
      this.logradouro,
      this.complemento,
      this.unidade,
      this.bairro,
      this.localidade,
      this.uf,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi);

  Address.fromMap(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    unidade = json['unidade'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }
}
