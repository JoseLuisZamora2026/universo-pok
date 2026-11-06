import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/pokemon.dart';

class PokemonService {
  static Future<List<Pokemon>> cargarPokemon() async {
    try {
      final String respuesta =
      await rootBundle.loadString('assets/Pokedex_50.json');

      final List<dynamic> datos = jsonDecode(respuesta);

      return datos
          .map((pokemon) => Pokemon.fromJson(pokemon))
          .toList();
    } catch (e) {
      throw Exception('Error al cargar la Pokédex: $e');
    }
  }
}