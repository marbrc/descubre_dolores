import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/lugar_turistico.dart';

class DetalleViewModel extends ChangeNotifier {
  final LugarTuristico lugar;
  final AudioPlayer _reproductor = AudioPlayer();
  StreamSubscription<void>? _suscripcionFin;
  bool _iniciado = false;

  bool reproduciendo = false;
  bool errorAudio = false;

  DetalleViewModel(this.lugar) {
    _suscripcionFin = _reproductor.onPlayerComplete.listen((_) {
      reproduciendo = false;
      _iniciado = false;
      notifyListeners();
    });
  }

  Future<void> alternarAudio() async {
    try {
      if (reproduciendo) {
        await _reproductor.pause();
        reproduciendo = false;
      } else if (_iniciado) {
        await _reproductor.resume();
        reproduciendo = true;
      } else {
        await _reproductor.play(AssetSource(lugar.audioAsset));
        _iniciado = true;
        reproduciendo = true;
      }
      errorAudio = false;
    } catch (_) {
      reproduciendo = false;
      errorAudio = true;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _suscripcionFin?.cancel();
    _reproductor.dispose();
    super.dispose();
  }
}