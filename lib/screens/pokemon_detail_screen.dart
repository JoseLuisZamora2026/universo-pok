import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = _obtenerColorPorTipo(
      pokemon.tipos.isNotEmpty ? pokemon.tipos.first : 'normal',
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          pokemon.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [

          Positioned(
            top: 10,
            right: 20,
            child: Text(
              "#${pokemon.numeroPokedex.toString().padLeft(3, '0')}",
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),

          Column(
            children: [
              // Imagen central con animación Hero
              SizedBox(
                height: 230,
                child: Center(
                  child: Hero(
                    tag: 'pokemon-${pokemon.numeroPokedex}',
                    child: pokemon.imagen.startsWith('http')
                       ? Image.network(pokemon.imagen,
                      height: 180,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.catching_pokemon, size: 100, color: Colors.white70,);
                      },
                    )
                       : Image.asset(pokemon.imagen,
                        height: 180,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace){
                          return const Icon(Icons.catching_pokemon, size: 100,
                          color: Colors.white70,
                          );
                        },
                    ),
                  ),
                ),
              ),


              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre y Número en la parte superior de la tarjeta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pokemon.nombre,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "#${pokemon.numeroPokedex.toString().padLeft(3, '0')}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Chips de elementos / tipos
                        Wrap(
                          spacing: 8,
                          children: pokemon.tipos.map((tipo) {
                            return Chip(
                              label: Text(
                                tipo.toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: _obtenerColorPorTipo(tipo),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),

                        // Sección de biografía o registro personalizado
                        const Text(
                          'REGISTRO OFICIAL DE POKÉDEX',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pokémon registrado en la base de datos oficial con el número #${pokemon.numeroPokedex}. Especie destacada dentro de los primeros 50 elementos del universo Pokémon.',
                          style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                        ),
                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(child: _buildStatCard('REGISTRO ID', '#${pokemon.numeroPokedex}', Icons.confirmation_number)),
                            const SizedBox(width: 15),
                            Expanded(child: _buildStatCard('TOTAL TIPOS', '${pokemon.tipos.length} Elementos', Icons.category)),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Tarjeta personalizada para mostrar datos de forma limpia
  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Selector de colores institucionales según el tipo de Pokémon
  Color _obtenerColorPorTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'planta': return Colors.green.shade600;
      case 'fuego': return Colors.deepOrange.shade600;
      case 'agua': return Colors.blue.shade600;
      case 'eléctrico': return Colors.amber.shade700;
      case 'psíquico': return Colors.purple.shade600;
      case 'veneno': return Colors.deepPurple.shade500;
      case 'volador': return Colors.indigo.shade400;
      case 'normal': return Colors.brown.shade400;
      case 'hada': return Colors.pink.shade400;
      case 'lucha': return Colors.red.shade800;
      case 'tierra': return Colors.orange.shade700;
      case 'roca': return Colors.grey.shade600;
      case 'fantasma': return Colors.indigo.shade900;
      case 'siniestro': return Colors.blueGrey.shade700;
      case 'acero': return Colors.blueGrey.shade500;
      case 'dragón': return Colors.indigo.shade800;
      case 'hielo': return Colors.cyan.shade600;
      default: return Colors.redAccent;
    }
  }
}