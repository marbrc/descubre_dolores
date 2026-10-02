import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../viewmodels/detalle_view_model.dart';
import 'comunes.dart';

class DetalleLugarScreen extends StatefulWidget {
  final LugarTuristico lugar;
  const DetalleLugarScreen({super.key, required this.lugar});

  @override
  State<DetalleLugarScreen> createState() => _DetalleLugarScreenState();
}

class _DetalleLugarScreenState extends State<DetalleLugarScreen> {
  late final DetalleViewModel _viewModel;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _viewModel = DetalleViewModel(widget.lugar);
    final video = widget.lugar.videoAsset;
    if (video != null) {
      _videoController = VideoPlayerController.asset(video);
      _videoController!.initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((_) {});
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lugar = widget.lugar;
    final video = _videoController;
    return Scaffold(
      backgroundColor: Paleta.crema,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            backgroundColor: Paleta.terracota,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'foto_${lugar.id}',
                child: ImagenLugar(asset: lugar.imagenAsset),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lugar.nombre,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Paleta.cafe,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _Etiqueta(
                    icono: Icons.location_on_outlined,
                    texto: 'Dolores Hidalgo, Guanajuato',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    lugar.descripcion,
                    style: const TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Paleta.terracota,
                      height: 1.4,
                    ),
                  ),
                  if (lugar.historia.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      lugar.historia,
                      style: const TextStyle(fontSize: 16, height: 1.65, color: Paleta.cafe),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _TarjetaMusica(viewModel: _viewModel),
                  if (lugar.datoCurioso.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _TarjetaDato(texto: lugar.datoCurioso),
                  ],
                  if (video != null && video.value.isInitialized) ...[
                    const SizedBox(height: 28),
                    const Text(
                      'Mira el lugar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Paleta.cafe,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _tarjetaVideo(video),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaVideo(VideoPlayerController c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: c.value.aspectRatio,
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: c,
          builder: (context, v, _) => GestureDetector(
            onTap: () => v.isPlaying ? c.pause() : c.play(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(c),
                if (!v.isPlaying)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0x99000000),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, size: 48, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  final IconData icono;
  final String texto;
  const _Etiqueta({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Paleta.arena,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 16, color: Paleta.terracota),
          const SizedBox(width: 6),
          Text(
            texto,
            style: const TextStyle(fontSize: 13, color: Paleta.cafe, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TarjetaMusica extends StatelessWidget {
  final DetalleViewModel viewModel;
  const _TarjetaMusica({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final suena = viewModel.reproduciendo;
        final mensaje = viewModel.errorAudio
            ? 'No se encontró el archivo de audio'
            : suena
                ? 'Reproduciendo… toca para pausar'
                : 'Toca para escuchar la melodía de este lugar';
        return GestureDetector(
          onTap: viewModel.alternarAudio,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Paleta.terracotaOscuro, Paleta.terracota],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(
                    suena ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 34,
                    color: Paleta.terracota,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Música significativa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mensaje,
                        style: const TextStyle(color: Color(0xDDFFFFFF), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.music_note_rounded, color: Color(0x99FFFFFF), size: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TarjetaDato extends StatelessWidget {
  final String texto;
  const _TarjetaDato({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0CF8A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: Paleta.dorado, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dato curioso',
                  style: TextStyle(fontWeight: FontWeight.w800, color: Paleta.cafe, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  texto,
                  style: const TextStyle(fontSize: 14.5, height: 1.5, color: Paleta.cafe),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}