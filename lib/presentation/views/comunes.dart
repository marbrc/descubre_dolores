import 'package:flutter/material.dart';

class Paleta {
  static const terracota = Color(0xFFB5532F);
  static const terracotaOscuro = Color(0xFF7A2E17);
  static const dorado = Color(0xFFD9822B);
  static const crema = Color(0xFFFBF5EC);
  static const arena = Color(0xFFF1E3CF);
  static const cafe = Color(0xFF3B2A20);
}

class ImagenLugar extends StatelessWidget {
  final String asset;
  const ImagenLugar({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => Container(
        width: double.infinity,
        color: Paleta.arena,
        alignment: Alignment.center,
        child: const Icon(Icons.image_outlined, size: 48, color: Paleta.terracota),
      ),
    );
  }
}