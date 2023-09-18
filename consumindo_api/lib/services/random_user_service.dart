import 'dart:convert';
import 'package:http/http.dart'
    as http; // Importe a biblioteca http corretamente
import 'package:consumindo_api/models/random_user_model.dart';

Future<RandomUser> getRandomUser() async {
  const url = "https://randomuser.me/api/";

  final response = await http.get(Uri.parse(url)); // Corrija a declaração aqui

  if (response.statusCode == 200) {
    return RandomUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Ocorreu um erro");
  }
}
