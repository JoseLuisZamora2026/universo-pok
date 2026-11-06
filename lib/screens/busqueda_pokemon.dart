import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusquedaPokemon extends StatefulWidget {
  const BusquedaPokemon({super.key});

  @override
  State<BusquedaPokemon>
  createState() => _BusquedaPokemonState();
}

class _BusquedaPokemonState extends
    State<BusquedaPokemon> {
  String nombreBuscado = '';
  String tipoSeleccionado ='Todos';
  List<dynamic> pokemones = [];
  bool cargando = true;
  String? mensajeError;

  @override
  void initState() {
    super.initState();
    cargarPokemones();
  }
  Future<void> cargarPokemones() async
  {
    try {
      final respuesta = await http.get(Uri.parse('https://raw.githubusercontent.com/JoseLuisZamora2026/universo-pok/refs/heads/main/Data/pokemon.json',
      ),
      );
      if (respuesta.statusCode == 200)
        {
          final datos = jsonDecode(utf8.decode(respuesta.bodyBytes));
          if (!mounted) return;
          setState(() {
            pokemones = datos;
            cargando = false;
            mensajeError = null;
          });
        } else{
        throw Exception('Error al descargar los Pokémon');
      }
    }catch(error) {
      if (!mounted) return;
      setState(() {
        cargando = false;
        mensajeError = 'No se pudieron cargar los Pokémon';
      });
    }
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold(appBar: AppBar(title: const Text('Buscar Pokémon'),
    backgroundColor: Colors.red, foregroundColor: Colors.white,),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children:
    [TextField(decoration: const InputDecoration(labelText: 'Buscar Pokemon por nombre', hintText: 'Ejemplo: Pikachu',
    prefixIcon: Icon(Icons.search), border: OutlineInputBorder(),),
    onChanged: (texto) {
      setState(() {
        nombreBuscado = texto;
      });
    },
    ),
    ],
    ),
    ),
    );
  }
}