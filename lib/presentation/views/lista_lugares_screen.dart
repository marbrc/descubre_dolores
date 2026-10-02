import 'package:flutter/material.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../viewmodels/lugares_view_model.dart';
import 'comunes.dart';
import 'detalle_lugar_screen.dart';

class ListaLugaresScreen extends StatefulWidget {
  final LugaresViewModel viewModel;
  const ListaLugaresScreen({super.key, required this.viewModel});

  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.cargar();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.cargando) {
          return const Scaffold(
            backgroundColor: Paleta.crema,
            body: Center(child: CircularProgressIndicator(color: Paleta.terracota)),
          );
        }
        final lugares = widget.viewModel.lugares;
        return Scaffold(
          backgroundColor: Paleta.crema,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _encabezado(context)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _tarjeta(context, lugares[i]),
                  childCount: lugares.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      },
    );
  }

  Widget _encabezado(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 36, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Paleta.terracotaOscuro, Paleta.terracota, Paleta.dorado],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GUANAJUATO · MÉXICO',
            style: TextStyle(
              color: Color(0xCCFFFFFF),
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Descubre\nDolores Hidalgo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Cuna de la Independencia Nacional',
            style: TextStyle(color: Color(0xE6FFFFFF), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _tarjeta(BuildContext context, LugarTuristico lugar) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetalleLugarScreen(lugar: lugar),
          ));
        },
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(color: Color(0x33000000), blurRadius: 16, offset: Offset(0, 8)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'foto_${lugar.id}',
                  child: ImagenLugar(asset: lugar.imagenAsset),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00000000), Color(0xCC000000)],
                      stops: [0.4, 1],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 18,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lugar.nombre,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lugar.descripcion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xE6FFFFFF), fontSize: 13.5),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (lugar.videoAsset != null) ...[
                        const _Insignia(icono: Icons.videocam_rounded),
                        const SizedBox(width: 6),
                      ],
                      const _Insignia(icono: Icons.music_note_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Insignia extends StatelessWidget {
  final IconData icono;
  const _Insignia({required this.icono});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Color(0x73000000), shape: BoxShape.circle),
      child: Icon(icono, size: 18, color: Colors.white),
    );
  }
}