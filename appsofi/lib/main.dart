import 'package:appsofi/views/start.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'states/star_pro_icons.dart';
import 'views/lists.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: incollage,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: AppPadding.paddingMd,

        // Botón PRO izquierdo

        title: Container(
          height: AppSpacing.spacing9,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing5
            ),
          decoration: BoxDecoration(
            color: AppColors.info300,
            borderRadius: BorderRadius.circular(
              AppRadius.radiusFull
              ),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                StarPro.vector, 
                color: AppColors.neutral900,
                size: 16
                ),
              const SizedBox(
                width: AppSpacing.spacing2
                ),
              
              Text(
                'Prueba la versión pro 7 días',
                style: text.bodySmall
              ),
            ],
          ),
        ),

        //actions
        actions: [
          // Tienda
          CircleAvatar(
            radius: AppSpacing.spacing5,
            backgroundColor: colors.surface,
            child: Icon(
              Icons.storefront_outlined, 
              size: 24),
          ), 

          // Perfil
          const SizedBox(
            width: AppSpacing.spacing2),
          CircleAvatar(
            radius: AppSpacing.spacing5,
            backgroundColor: colors.primary,
            child: Icon(
              Icons.person_outline_outlined,
              color: colors.onPrimary, 
              size: 24
              ),
          ),
          
          const SizedBox(
            width: AppSpacing.spacing4
            ),
        ],

        // Título Incollage
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.spacing6,
              0,
              AppSpacing.spacing4,
              AppSpacing.spacing4,
            ),

              child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'InCollage',
                style: text.headlineLarge,
              ),
          ),
        ),
      ), 
      ),

      body: ListView(
        children: [
          const SizedBox(
            height: AppSpacing.spacing18
            ),

          Padding(
              padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16
              ),

            //boton nueva composición
            child: 
            FilledButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StartView(),
                      ),
                      );
                    },

                    icon: const Icon(Icons.add),
                    label: const Text('NUEVA COMPOSICIÓN'),
                    iconAlignment: IconAlignment.start,
                    ),

          ),

          const SizedBox(
            height: AppSpacing.spacing6
            ),

          // container gris
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: AppSpacing.spacing6,
                top: AppSpacing.spacing6,
                right: AppSpacing.spacing6,
                bottom: AppSpacing.spacing8,
              ),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // proyectos recientes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proyectos recientes',
                      style: text.bodyLarge
                    ),

                    //ver todos
                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListsView(),
                        ),
                      );
                    },
                    child: Text(
                      'Ver todos',
                      style: text.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.neutral700,
                      ),
                    ),
                  ),
                ],
                ),

                const SizedBox(height: AppSpacing.spacing6),

                //carrusel de imagenes
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.spacing2,
                        ),

                        child: Container(
                          width: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.neutral300,
                            borderRadius: BorderRadius.circular(
                              AppRadius.radiusLg,
                            ),
                          ),

                        //imagenes
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                  'assets/images/PREV.png',
                                  fit: BoxFit.cover,
                              ),

                              // sombra
                              Positioned.fill(
                                child: DecoratedBox(
                                decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color.fromARGB(21, 0, 0, 0),
                                  ],
                                  stops: const [0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                              
                              //texto sobre imagen
                              Positioned(
                                bottom: AppSpacing.spacing2,
                                left: AppSpacing.spacing2,
                                right: AppSpacing.spacing2,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.image_outlined,
                                      size: 12,
                                      color: AppColors.neutral100,
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        'IMG_7...',
                                        style: AppTypography.overline.copyWith(
                                          color: AppColors.neutral100,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}