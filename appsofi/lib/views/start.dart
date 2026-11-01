import 'package:flutter/material.dart';
import 'package:appsofi/views/main_editor_fotos.dart';
import '../theme/theme.dart';  

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      // app bar
      appBar: AppBar(
        backgroundColor: colors.primary,

          //crevron
          iconTheme: IconThemeData(
          color: colors.onPrimary, 
          ),

        title: Text( 
          'Inicio',
          style: text.bodyLarge?.copyWith(
            color: colors.onPrimary,
          ),
        ),

        actions: [
          CircleAvatar(
            radius: AppSpacing.spacing5,
            backgroundColor: colors.primary,
            child: Icon(
              Icons.account_circle_outlined,
              color: colors.onPrimary, 
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.spacing4),
        ],
      ),

      // lista
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing8,
          horizontal: AppSpacing.spacing8,
        ),
        children: [

          Text('¿Qué hacemos hoy?',
          style: text.headlineSmall,
          textAlign: TextAlign.center,
          
          ),

           const SizedBox(height:AppSpacing.spacing6),

           Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [


               SizedBox(
            width: 115,
            height: 115,
            child:  FilledButton.icon(

              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.radiusLg
    ,),

    ),
                
              ),
                    onPressed: () {
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditorImagenScreen(),
                      ),
                      );
                    },
                  
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Editar Foto'),
                  ),


          ),        
          
           const SizedBox(width: AppSpacing.spacing4),
          
           SizedBox(
            width: 115,
            height: 115,
            child:  FilledButton.icon(

              style:FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.radiusLg,
                  )
                )
                ,

              
              ),
              
                    onPressed: () {},
                    icon: const Icon(Icons.grid_view_outlined),
                    label: const Text('Crear Collage'),
                  ),
           ),

            ],



           )



        ],
      ),
    );
  }
}

