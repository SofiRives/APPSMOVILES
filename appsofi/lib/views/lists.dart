import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ListsView extends StatelessWidget {
  const ListsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,

        // app bar
        appBar: AppBar(
        backgroundColor: colors.primary,

          //crevron
          iconTheme: IconThemeData(
          color: colors.onPrimary, 
          ),

        title: Text( 
          'Proyectos recientes',
          style: text.bodyLarge?.copyWith(
            color: colors.onPrimary,
          ),
        ),

        actions: [
          CircleAvatar(
            radius: AppSpacing.spacing5,
            backgroundColor: colors.primary,
            child: Icon(
              Icons.person,
              color: colors.onPrimary, 
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.spacing4),
        ],
      ),

      body: Column(
        children: [
          
          // Buscador
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.paddingSm,
              vertical: AppSpacing.spacing3,
            ),
            
            child: Row(
              children: [
                
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.neutral200,
                      borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                    ),

                    child: TextField(
                      decoration: InputDecoration(
                        //hintText: 'Buscar...',
                       // hintStyle: text.bodyMedium?.copyWith(
                         // color: AppColors.neutral600,
                        //),

                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.neutral800,
                          size: 20,
                        ),

                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing2,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: AppSpacing.spacing2),

                // Icono de ajustes
                IconButton(
                  icon: const Icon(
                    Icons.tune,
                    color: AppColors.neutral900,
                    size: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

            // Lista----------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.spacing2,
              ),
              children: [
                
                // Item 1
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing4,
                    vertical: AppSpacing.spacing2,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppRadius.radiusSm, 
                    ),
                    child: Image.asset(
                      'assets/images/PREV.png',
                      width: AppSpacing.spacing12,
                      height: AppSpacing.spacing12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Img_300',
                        style: text.bodyLarge,
                      ),
                      const SizedBox(width: AppSpacing.spacing2),
                      const Icon(
                        Icons.border_color_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '17/08/2020 16:47',
                    style: text.bodyMedium?.copyWith(
                      color: AppColors.neutral700,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),

                // Item 2
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing4,
                    vertical: AppSpacing.spacing2,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppRadius.radiusSm,
                    ),
                    child: Image.asset(
                      'assets/images/PREV.png',
                      width: AppSpacing.spacing12,
                      height: AppSpacing.spacing12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Img_200',
                        style: text.bodyLarge,
                      ),
                      const SizedBox(width: AppSpacing.spacing2),
                      const Icon(
                        Icons.border_color_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '15/08/2020 13:50',
                    style: text.bodyMedium?.copyWith(
                      color: AppColors.neutral700,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),

                // Item 3
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing4,
                    vertical: AppSpacing.spacing2,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppRadius.radiusSm,
                    ),
                    child: Image.asset(
                      'assets/images/PREV.png',
                      width: AppSpacing.spacing12,
                      height: AppSpacing.spacing12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Img_100',
                        style: text.bodyLarge,
                      ),
                      const SizedBox(width: AppSpacing.spacing2),
                      const Icon(
                        Icons.border_color_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '15/08/2020 11:32',
                    style: text.bodyMedium?.copyWith(
                      color: AppColors.neutral700,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
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