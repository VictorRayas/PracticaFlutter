class AnimalModel{

  final int id;
  final String nombre;
  final int edad;
  final String raza;
  final String color;
  AnimalModel(
      { required this.id,
    required this.nombre,
    required this.edad,
    required this.raza,
    required this.color});

  factory AnimalModel.fromJson(Map<String , dynamic> json){
    return AnimalModel(
      id: json["id"],
      nombre : json["nombre"],
      edad : json["edad"],
      raza: json["raza"],
      color : json["color"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'nombre':nombre,
      'edad':edad,
      'raza':raza,
      'color': color,
    };
    }
}