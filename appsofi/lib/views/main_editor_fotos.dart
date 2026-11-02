import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: incollage,
      home: const EditorImagenScreen(),
    );
  }
}

enum FiltroImagen { original, blancoNegro, sepia, calido, frio, vintage, nightcity, popSTAR, pomegranate}

class EditorImagenScreen extends StatefulWidget {
  const EditorImagenScreen({super.key});

  @override
  State<EditorImagenScreen> createState() => _EditorImagenScreenState();
}

class _EditorImagenScreenState extends State<EditorImagenScreen> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _imagenKey = GlobalKey();

  File? _imagen;
  FiltroImagen _filtro = FiltroImagen.original;
  double _intensidad = 1;
  bool _guardando = false;

  static const _identidad = <double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];

  List<double> _matrizFiltro(FiltroImagen filtro) {
    switch (filtro) {
      case FiltroImagen.original:
        return _identidad;
      case FiltroImagen.blancoNegro:
        return [
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ];
      case FiltroImagen.sepia:
        return [
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ];
      case FiltroImagen.calido:
        return [
          1.12, 0, 0, 0, 8,
          0, 1.02, 0, 0, 0,
          0, 0, 0.88, 0, 0,
          0, 0, 0, 1, 0,
        ];
      case FiltroImagen.frio:
        return [
          0.90, 0, 0, 0, 0,
          0, 1.02, 0, 0, 0,
          0, 0, 1.16, 0, 8,
          0, 0, 0, 1, 0,
        ];
      case FiltroImagen.vintage:
        return [
          0.85, 0.18, 0.08, 0, 8,
          0.10, 0.86, 0.08, 0, 4,
          0.08, 0.14, 0.72, 0, 0,
          0, 0, 0, 1, 0,
        ];
        case FiltroImagen.nightcity:
        return [
        0.8, 0.4, -0.6, 0, 30,  
       -0.4, 0.8, 0.4, 0,10,  
       -0.6, -0.2,  1.6, 0, 80,  
        0, 0, 0, 1,0,
        ];

         case FiltroImagen.popSTAR:
        return [
        0, 1, 0, 0, 0, 
        0, 0, 1, 0, 0, 
        1, 0, 0, 0, 0, 
       0, 0, 0, 1, 0, 
        ];

         case FiltroImagen.pomegranate:
        return [
        1.5, 0, 0, 0, 0, 
        0, 0.3, 0, 0, 0, 
        0, 0, 0.3, 0, 0, 
       0, 0, 0, 1, 0, 
        ];
    }
  }

  List<double> _matrizActual() {
    final destino = _matrizFiltro(_filtro);
    return List.generate(
      20,
      (i) => _identidad[i] + (destino[i] - _identidad[i]) * _intensidad,
    );
  }

  String _nombreFiltro(FiltroImagen filtro) {
    switch (filtro) {
      case FiltroImagen.original:
        return 'Original';
      case FiltroImagen.blancoNegro:
        return 'B/N';
      case FiltroImagen.sepia:
        return 'Sepia';
      case FiltroImagen.calido:
        return 'Cálido';
      case FiltroImagen.frio:
        return 'Frío';
      case FiltroImagen.vintage:
        return 'Vintage';
      case FiltroImagen.nightcity:
        return 'nightcity';
      case FiltroImagen.popSTAR:
        return 'popSTAR';
      case FiltroImagen.pomegranate:
        return 'pomegranate';
    }
  }

  Future<void> _abrirImagen() async {
    try {
      final seleccion = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
      );

      if (seleccion == null || !mounted) return;

      setState(() {
        _imagen = File(seleccion.path);
        _filtro = FiltroImagen.original;
        _intensidad = 1;
      });
    } catch (e) {
      _mensaje('No se pudo abrir la imagen: $e');
    }
  }

  Future<void> _guardarImagen() async {
    if (_imagen == null || _guardando) return;

    setState(() => _guardando = true);

    try {
      // Captura la imagen con el filtro aplicado, sin los controles.
      final boundary = _imagenKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) throw Exception('Imagen no disponible');

      final ui.Image imagen = await boundary.toImage(pixelRatio: 2);
      final ByteData? datos = await imagen.toByteData(
        format: ui.ImageByteFormat.png,
      );
      imagen.dispose();
      if (datos == null) throw Exception('No se pudo generar el PNG');

      final carpeta = await getApplicationDocumentsDirectory();
      final archivo = File(
        '${carpeta.path}/imagen_editada_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await archivo.writeAsBytes(datos.buffer.asUint8List());

      _mensaje('Imagen guardada en: ${archivo.path}');
    } catch (e) {
      _mensaje('No se pudo guardar la imagen: $e');
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  void _mensaje(String texto) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(

        title: const Text('Editor de imágenes'),
        
        actions: [
          if (_imagen != null)
            IconButton(
              tooltip: 'Restablecer filtros',
              onPressed: () => setState(() {
                _filtro = FiltroImagen.original;
                _intensidad = 1;
              }),
              icon: const Icon(Icons.restart_alt),
            ),
          if (_imagen != null)
            IconButton(
              tooltip: 'Guardar imagen editada',
              onPressed: _guardando ? null : _guardarImagen,
              icon: _guardando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.spacing16),
        children: [
          Text('Editar fotografía', style: textos.headlineLarge),
          const SizedBox(height: AppSpacing.spacing16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 350,
              width: double.infinity,
              child: _imagen == null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image_outlined,
                              size: 72, color: colores.onSurfaceVariant),
                          const SizedBox(height: AppSpacing.spacing16),
                          const Text('Selecciona una imagen para editar'),
                        ],
                      ),
                    )
                  : Center(
                      child: RepaintBoundary(
                        key: _imagenKey,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(_matrizActual()),
                          child: Image.file(
                            _imagen!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.spacing16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _abrirImagen,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: Text(_imagen == null ? 'Abrir imagen' : 'Cambiar imagen'),
            ),
          ),
          if (_imagen != null) ...[
            const SizedBox(height: AppSpacing.spacing12),
            Text('Filtros', style: textos.titleLarge),
            const SizedBox(height: AppSpacing.spacing12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FiltroImagen.values.map((filtro) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.spacing8),
                    child: ChoiceChip(
                      label: Text(_nombreFiltro(filtro)),
                      selected: _filtro == filtro,
                      onSelected: (_) => setState(() {
                        _filtro = filtro;
                        _intensidad = 1;
                      }),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.spacing2),
            Row(
              children: [
                Expanded(child: Text('Intensidad', style: textos.titleMedium)),
                Text('${(_intensidad * 100).round()} %'),
              ],
            ),
            Slider(
              value: _intensidad,
              min: 0,
              max: 1,
              divisions: 20,
              label: '${(_intensidad * 100).round()} %',
              onChanged: _filtro == FiltroImagen.original
                  ? null
                  : (valor) => setState(() => _intensidad = valor),
            ),
            const SizedBox(height: AppSpacing.spacing16),
            Text(
              'Presiona el check superior para guardar una copia PNG editada.',
              style: textos.bodySmall,
            ),
          ],
        ],
      ),
      floatingActionButton: _imagen == null
          ? null
          : FloatingActionButton(
              onPressed: _abrirImagen,
              tooltip: 'Abrir otra imagen',
              child: const Icon(Icons.add_photo_alternate_outlined),
            ),
    );
  }
}
