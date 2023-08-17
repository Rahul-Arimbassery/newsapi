import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapi/model/apimodel.dart';


late Future<List<Articles>> result;
late List data;
//String? country;

Future<List<Articles>> fetchApi() async {
  var url =
      Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=57946ab37e8e42319bbc6abde7bc79f1');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    data = jsonDecode(response.body);
    return data.map((e) => Articles.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
