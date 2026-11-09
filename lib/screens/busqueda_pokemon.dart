import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../models/pokemon.dart';
import 'pokemon_detail_screen.dart';

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
  Future<void> cargarPokemones() async{
    try{
      final contenido = await rootBundle.loadString('Data/pokemon.json');
      final datos = jsonDecode(contenido);
      if(!mounted) return;

      setState(() {
        pokemones = datos;
        cargando = false;
        mensajeError = null;
      });
    }catch(error){
      debugPrint('Error al cargar poémon: $error');
      if (!mounted) return;

      setState(() {
        cargando = false;
        mensajeError = 'No se pudieron cargar los pokémon';
      });
    }
  }
List<dynamic> get pokemonesFiltrados
{
  return pokemones.where((pokemon) {
    final nombre = pokemon['nombre'].toString().toLowerCase();
    final coincideNombre = nombre.contains(nombreBuscado.trim().toLowerCase());
    final tipos = List<String>.from(pokemon['tipo']);
    final coincideTipo = tipoSeleccionado == 'Todos' || tipos.contains(tipoSeleccionado);
    return coincideNombre && coincideTipo;
  }).toList();
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
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(initialValue: tipoSeleccionado,
        decoration: const InputDecoration(labelText:'Filtrar por tipo', prefixIcon: Icon(Icons.filter_list),
        border: OutlineInputBorder(),),
      items: ['Todos', 'Agua', 'Fuego', 'Planta', 'Veneno', 'Normal', 'Volador', 'Bicho',
      'Electrico', 'Tierra', 'Hada'].map((tipo) {
        return DropdownMenuItem<String>(value: tipo, child: Text(tipo),);
        }).toList(), onChanged: (valor){
      if (valor != null){
        setState(() {
          tipoSeleccionado = valor;
        });
       }
      },
     ),
      const SizedBox(height: 16),
      Expanded(child: cargando ? const Center(child: CircularProgressIndicator()): mensajeError != null ? Center(child: Text(mensajeError!)):
    pokemonesFiltrados.isEmpty ? const Center(child: Text('No se encontraron Pokemon'),
  ): ListView.builder(itemCount: pokemonesFiltrados.length,itemBuilder: (context, index){
    final pokemon = pokemonesFiltrados[index];
    return Card(margin: const EdgeInsets.only(bottom:10), child: ListTile(leading: Image.network(pokemon['imagen'],
  width:55, height:55, errorBuilder: (context, error, stackTrace)
  {
    return const Icon(Icons.catching_pokemon);
  },
  ),
  title: Text(pokemon['nombre']),
 onTap: () {
   final pokemonSeleccionado = Pokemon.fromJson(
     Map<String, dynamic>.from(pokemon),
   );
   Navigator.push(context, MaterialPageRoute(builder: (context) =>
       PokemonDetailScreen(pokemon: pokemonSeleccionado,
       ),
   ),
   );
 },
  subtitle: Text((pokemon['tipo'] as List).join(', ')),
  ),
  );
  },
  ),
  ),
     ],
    ),
    ),
    );
   }
}