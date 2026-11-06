class Pokemon {
  final int id;
  final int numeroPokedex;
  final String nombre;
  final List<String> tipos;
  final String imagen;

  Pokemon({
    required this.id,
    required this.numeroPokedex,
    required this.nombre,
    required this.tipos,
    required this.imagen,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      numeroPokedex: json['numero_pokedex'],
      nombre: json['nombre'],
      tipos: List<String>.from(json['tipos']),
      imagen: 'assets/${json['imagen']}',
    );
  }
}