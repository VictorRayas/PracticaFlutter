import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/animal_model.dart';

class AnimalRepository{
  final String apiUrl;


  AnimalRepository({required this.apiUrl});

  Future<void> createAnimal(AnimalModel animal) async{
    print('Animal to json: ${animal.toJson()}');
    final response = await http.post(
      Uri.parse('$apiUrl/insert_animals'),
      headers: <String , String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(animal.toJson()),
    );
    print('peticion: ${response.toString()}');
    if(response.statusCode != 200){
      throw Exception('Failed to create Animal');
    }
  }


  Future<void> updateAnimal(AnimalModel animal) async {
    print('Animal : ${animal.toJson()}');
    final response = await http.put(
      Uri.parse('$apiUrl/update_animals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(animal.toJson()),
    );
    print('peticion: ${response.toString()}');
    print('peticion: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update animal');
    }
  }
  Future<List<AnimalModel>> getAllAnimals() async {
    final response = await http.get(
      Uri.parse('$apiUrl/animals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      // Decodificar el cuerpo de la respuesta
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Extraer la lista de animales usando la clave "Animals"
      Iterable animalList = jsonResponse['Animals'];

      // Mapear la lista a objetos AnimalModel
      List<AnimalModel> animals = List<AnimalModel>.from(
          animalList.map((model) => AnimalModel.fromJson(model))
      );
      return animals;
    } else {
      throw Exception('Failed to load animals');
    }
  }

  Future<void> deleteUser(String id) async {
    print('Animal id:  : ${id}');
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_animals/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );
    print('REsponse  : ${response}');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete animal');
    }
  }




}






