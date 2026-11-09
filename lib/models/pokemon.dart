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
    final int id = (json['id'] as num).toInt();
    return Pokemon(
        id: id, numeroPokedex: (json['numero_pokedex'] as num?)?.toInt() ?? id,
        nombre: json['nombre'].toString(),
    tipos: List<String>.from(json['tipo'] ?? json['tipos'] ??[]),
    imagen: json.containsKey('tipos') ? 'assets/Pokedex_50/${json['imagen'].toString().split('/').last}'
        : json['imagen'].toString
    (
    )
    ,
    );
  }
}