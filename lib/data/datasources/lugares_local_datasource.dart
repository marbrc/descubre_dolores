import '../../domain/entities/lugar_turistico.dart';

class LugaresLocalDataSource {
  List<LugarTuristico> obtenerLugares() {
    return [
      const LugarTuristico(
        id: '1',
        nombre: 'Jardín Principal',
        descripcion: 'El corazon de Dolores Hidalgo rodeado de portales y cafés.',
        historia:
            'Es el punto de encuentro de la ciudad. Bajo la sombra de sus árboles y frente a los portales familias y visitantes se sientan a platicar, a tomar un café o a probar las famosas nieves de sabores. Desde aquí se camina hacia la Parroquia y los demás lugares emblemáticos del centro histórico.',
        datoCurioso:
            'Dolores Hidalgo es famosa por sus nieves de sabores poco comunes, y el Jardín es el mejor lugar para probarlas.',
        imagenAsset: 'assets/images/jardin_principal.jpeg',
        audioAsset: 'audio/jardin_principal.mp3',
        videoAsset: 'assets/video/jardin_principal.mp4',
      ),
      const LugarTuristico(
        id: '2',
        nombre: 'Parroquia de Nuestra Señora de los Dolores',
        descripcion: 'El lugar donde Miguel Hidalgo dio el Grito de Independencia en 1810.',
        historia:
            'En este templo del siglo XVIII, el 16 de septiembre de 1810, el cura Miguel Hidalgo llamó al pueblo a levantarse contra el dominio español, un momento que hoy recordamos como el Grito de Independencia. Su fachada de cantera, de estilo barroco, es una de las imágenes más representativas de la ciudad.',
        datoCurioso:
            'El llamado a la lucha comenzó con el toque de las campanas de este templo.',
        imagenAsset: 'assets/images/parroquia.jpg',
        audioAsset: 'audio/parroquia.mp3',
      ),
      const LugarTuristico(
        id: '3',
        nombre: 'Museo Casa de Hidalgo',
        descripcion: 'La casa donde vivió el cura Miguel Hidalgo antes de la Independencia.',
        historia:
            'Fue el hogar de Miguel Hidalgo cuando era cura de Dolores. Hoy es un museo donde puedes conocer su vida, su vocación y las ideas que lo llevaron a convocar la lucha por la Independencia.',
        datoCurioso:
            'Además de sacerdote, Hidalgo impulsó oficios entre la gente del pueblo, como la alfarería.',
        imagenAsset: 'assets/images/museo_hidalgo.jpeg',
        audioAsset: 'audio/museo_hidalgo.mp3',
      ),
    ];
  }
}