import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../theme/theme.dart';

import 'package:image_cropper/image_cropper.dart';

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
enum FiltroImagen {
  original,
  blancoNegro,
  sepia,
  calido,
  frio,
  vintage,
  nightcity,
  popSTAR,
  yellow,
  pomegranate,
}

class EditorImagenScreen extends StatefulWidget {
  const EditorImagenScreen({super.key});

  @override
  State<EditorImagenScreen> createState() => _EditorImagenScreenState();
}

class _EditorImagenScreenState extends State<EditorImagenScreen> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _imagenKey = GlobalKey();

  String _textoAgregado = '';
  Offset _posicionTexto = const Offset(50, 50);

  File? _imagen;
  FiltroImagen _filtro = FiltroImagen.original;
  double _intensidad = 1;
  bool _guardando = false;
  String? _herramientaActiva;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _abrirImagen();
    });
  }

  static const _identidad = <double>[
    1, 0, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 0,
    1, 0, 0, 0,
    0, 0, 1, 0,
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
          0,1.02,0,0,0,
          0,0,0.88,0,0,
          0,0,0,1,0,
        ];
      case FiltroImagen.frio:
        return [
          0.90,0,0,0,0,
          0,1.02,0,0,0,
          0,0,1.16,0,8,
          0, 0,0,1,0,
        ];
      case FiltroImagen.vintage:
        return [
          0.85,0.18,0.08,0,8,0.10,
          0.86,0.08,0,4,
          0.08,0.14,0.72,0,0,
          0,0,0,1,0,
        ];
      case FiltroImagen.nightcity:
        return [
          0.8, 0.4, -0.6, 0, 30,
          -0.4, 0.8, 0.4, 0,10,
          -0.6,-0.2,1.6,0,80,
          0,0,0,1,0,
        ];

      case FiltroImagen.popSTAR:
        return [
          0, 1, 0, 0, 0, 
          0, 0, 1, 0, 0, 
          1, 0, 0, 0, 0, 
          0, 0, 0, 1, 0];

      case FiltroImagen.yellow:
        return [
          1.5, 0.3, 0, 0, 40, 
          0.1, 1.2, 0.1, 0, 10, 
          -0.2, -0.2, 1.3, 0, -20, 
          0, 0, 0, 1, 0];

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
      case FiltroImagen.yellow:
        return 'yellow';
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

     if (seleccion == null) {
      if (mounted) {
        Navigator.pop(context); 
      }
      return;
    }

    if (!mounted) return;

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
      final boundary =
          _imagenKey.currentContext?.findRenderObject()
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

  Future<void> _recortarImagen() async {
    if (_imagen == null) return;

    

    final imagenRecortada = await ImageCropper().cropImage(
      sourcePath: _imagen!.path,
      // Configuraciones visuales para Android y iOS
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Imagen',
          toolbarColor:  Theme.of(context).colorScheme.primary,
          toolbarWidgetColor:  Theme.of(context).colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          backgroundColor:  Theme.of(context).colorScheme.surface,
          activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
          

        ),
        IOSUiSettings(title: 'Recortar Imagen'),
      ],
    );

    if (imagenRecortada != null) {
      setState(() {
        _imagen = File(imagenRecortada.path);
      });
    }
  }

  Future<void> _escribirTexto() async {
    String textoTemporal = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar texto'),
        content: TextField(
          autofocus: true,
          onChanged: (valor) => textoTemporal = valor,
          decoration: const InputDecoration(hintText: 'Escribe algo...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _textoAgregado = textoTemporal;
              });
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
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
    //final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,

        title: const Text('Editar foto'),

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
                          Icon(
                            Icons.image_outlined,
                            size: 72,
                            color: colores.onSurfaceVariant,
                          ),
                          const SizedBox(height: AppSpacing.spacing16),
                          const Text('Selecciona una imagen para editar'),
                        ],
                      ),
                    )
                  : Center(
                      child: RepaintBoundary(
                        key: _imagenKey,
                        child: Stack(
                          children: [
                           
                            ColorFiltered(
                              colorFilter: ColorFilter.matrix(_matrizActual()),
                              child: Image.file(_imagen!, fit: BoxFit.contain),
                            ),

                           
                            if (_textoAgregado.isNotEmpty)
                              Positioned(
                                left: _posicionTexto.dx,
                                top: _posicionTexto.dy,
                                child: GestureDetector(
                                
                                  onPanUpdate: (detalles) {
                                    setState(() {
                                      _posicionTexto += detalles.delta;
                                    });
                                  },
                                  child: Text(
                                    _textoAgregado,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
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
          /* if (_imagen != null) ...[
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
        ],*/
        ],
      ),

      bottomNavigationBar: _imagen == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_herramientaActiva != null)
                  Container(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),

                    height: _herramientaActiva == 'filtros' ? 230 : 110,
                    child: _herramientaActiva == 'filtros'
                        ? Column(
                            children: [
                              SizedBox(
                                height: 125,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: FiltroImagen.values.map((filtro) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: ChoiceChip(
                                        showCheckmark: false,
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                              vertical: 2.0,
                                            ),

                                        label: SizedBox(
                                          width: 60,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.matrix(
                                                          _matrizFiltro(filtro),
                                                        ),
                                                    child: Image.file(
                                                      _imagen!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 4),

                                              Text(
                                                _nombreFiltro(filtro),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                  fontWeight: _filtro == filtro
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        selected: _filtro == filtro,
                                        selectedColor: colores.primaryContainer,
                                        onSelected: (_) => setState(() {
                                          _filtro = filtro;
                                          _intensidad = 1;
                                        }),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              // SLIDER
                              if (_filtro != FiltroImagen.original) ...[
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Intensidad',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${(_intensidad * 100).round()} %',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Slider(
                                  value: _intensidad,
                                  min: 0,
                                  max: 1,
                                  divisions: 20,
                                  label: '${(_intensidad * 100).round()} %',
                                  onChanged: (valor) =>
                                      setState(() => _intensidad = valor),
                                ),
                              ],
                            ],
                          )
                        : Center(
                            child: Text(
                              'Panel de ${_herramientaActiva?.toUpperCase()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),

                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _herramientaActiva == 'filtros'
                      ? 0
                      : (_herramientaActiva == 'recortar'
                            ? 1
                            : (_herramientaActiva == 'texto' ? 2 : 0)),
                  onTap: (index) {
                    setState(() {
                      if (index == 0) {
                      setState((){
                        _herramientaActiva = _herramientaActiva == 'filtros' ? null : 'filtros';
                      });
                      } else if (index == 1) {
                        setState(() => _herramientaActiva == null);
                        _recortarImagen();
                      } else if (index == 2) {
                        setState(() => _herramientaActiva == null);
                        _escribirTexto();
                      }
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.filter_vintage),
                      label: 'Filtro',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.crop),
                      label: 'Recortar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.text_fields),
                      label: 'Texto',
                    ),
                  ],
                ),
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
