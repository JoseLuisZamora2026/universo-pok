
import 'package:flutter/material.dart';
import 'busqueda_pokemon.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            Expanded(child: Center(child: ElevatedButton.icon(onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BusquedaPokemon(),
                ),
              );
            },
              icon:const Icon(Icons.search),
              label: const Text ('Buscar Pokemon'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding:
              const EdgeInsets.symmetric(horizontal:25, vertical: 15,
              ),
              ),
              ),
            ),
),

          ],
        ),
      ),
    );
  }
}
