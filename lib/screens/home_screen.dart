// Importación de las librerías y archivos necesarios para mostrar
// y administrar la información de los Pokémon.
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import 'busqueda_pokemon.dart';

// Pantalla principal de Universo Pokémon.
// Utiliza StatefulWidget para actualizar la interfaz al cargar
// la información del catálogo.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Pokemon>> _pokemonFuture;
// Inicializa la carga de los Pokémon cuando se abre la pantalla.
  @override
  void initState() {
    super.initState();
    _cargarPokemon();
  }
// Obtiene los datos de los 50 Pokémon desde el archivo JSON
// mediante el servicio PokemonService.
  void _cargarPokemon() {
    _pokemonFuture = PokemonService.cargarPokemon();
  }
// Asigna un color diferente a cada tipo de Pokémon
// para facilitar su identificación visual.
  Color _colorTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'planta':
        return Colors.green;
      case 'fuego':
        return Colors.red;
      case 'agua':
        return Colors.blue;
      case 'eléctrico':
        return Colors.amber.shade800;
      case 'psíquico':
        return Colors.purple;
      case 'veneno':
        return Colors.deepPurple;
      case 'volador':
        return Colors.indigo;
      case 'normal':
        return Colors.brown;
      case 'hada':
        return Colors.pink;
      case 'lucha':
        return Colors.deepOrange;
      case 'tierra':
        return Colors.orange;
      case 'roca':
        return Colors.grey.shade700;
      case 'fantasma':
        return Colors.deepPurple.shade900;
      case 'siniestro':
        return Colors.blueGrey;
      case 'acero':
        return Colors.blueGrey.shade700;
      case 'dragón':
        return Colors.indigo.shade800;
      case 'hielo':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
// Construye las tarjetas individuales de cada Pokémon.
// Muestra su número, imagen, nombre y tipos.
// También permite abrir su información al seleccionarlo.
  Widget _crearTarjeta(Pokemon pokemon) {
    return Card(
      elevation: 3,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () => _mostrarDetalles(pokemon),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '#${pokemon.numeroPokedex.toString().padLeft(4, '0')}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  pokemon.imagen,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 55,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pokemon.nombre,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 5,
                children: pokemon.tipos.map((tipo) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _colorTipo(tipo),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tipo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
// Muestra una ventana emergente con información del Pokémon
// seleccionado, incluyendo su imagen, número de Pokédex y tipos.
  void _mostrarDetalles(Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            pokemon.nombre,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 160,
                child: Image.asset(
                  pokemon.imagen,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('ERROR AL CARGAR IMAGEN: $error');
                    return const Icon(
                      Icons.image_not_supported,
                      size: 60,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Número Pokédex: #${pokemon.numeroPokedex}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: pokemon.tipos.map((tipo) {
                  return Chip(
                    label: Text(
                      tipo,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: _colorTipo(tipo),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
// Construye la interfaz principal de la aplicación,
// conservando el diseño de bienvenida y el catálogo Pokémon.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'UNIVERSO POKÉMON',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Bienvenido, entrenador!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explora y descubre los primeros 50 Pokémon.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BusquedaPokemon(),
              ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text('Buscar Pokémon'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.catching_pokemon,
                    color: Colors.white,
                    size: 65,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '50 Pokémon disponibles',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Catálogo Pokémon',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
// Tarjeta de bienvenida que informa al usuario
// sobre la disponibilidad de los 50 Pokémon.
            // Catálogo de los 50 Pokémon.
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: _pokemonFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 45,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No se pudo cargar la Pokédex.',
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _cargarPokemon();
                              });
                            },
                            child: const Text(
                              'Reintentar',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final pokemon = snapshot.data ?? [];

                  if (pokemon.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay Pokémon disponibles.',
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: pokemon.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      return _crearTarjeta(pokemon[index]);
                    },
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
