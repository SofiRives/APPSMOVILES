import 'package:flutter/material.dart';

//TIPOGRAFÍA

class AppTypography {

  static const String fontFamily = 'WorkSans';

  //H1 

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  );

  //h2

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  );

  //h3

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  //h4

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );

  //h5

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  //h6

  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  //subtitle 1

  static const TextStyle sub1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  //subtitle 2

  static const TextStyle sub2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  //body 1

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  //body 2

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  //button
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );

  //caption 
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize:12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  //overline
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

}

//ESCALA MÉTRICA

class AppSpacing {
  static const double spacing1 = 4;
  static const double spacing2 = 8;
  static const double spacing3 = 12;
  static const double spacing4 = 16;
  static const double spacing5 = 20;
  static const double spacing6 = 24;
  static const double spacing7 = 28;
  static const double spacing8 = 32;
  static const double spacing9 = 36;
  static const double spacing10 = 40;
  static const double spacing11 = 44;
  static const double spacing12 = 48;
  static const double spacing13 = 52;
  static const double spacing14 = 56;
  static const double spacing15 = 60;
  static const double spacing16 = 64;
  static const double spacing17 = 68;
  static const double spacing18 = 72;
}

//padding

class AppPadding {
  static const double paddingNano = 4;
  static const double paddingMicro = 8;
  static const double paddingXs = 12;
  static const double paddingSm = 16;
  static const double paddingMd = 20;
  static const double paddingLg = 24;
  static const double paddingXl = 28;
  static const double paddingXxl = 32;
  static const double paddingVast = 36;
  static const double paddingGiant = 40;
  static const double paddingMass = 44;
  static const double paddingMax = 48;
}

//margin

class AppMargin{
  static const double marginNano = 4;
  static const double marginMicro = 8;
  static const double marginXs = 12;
  static const double marginSm = 16;
  static const double marginMd = 20;
  static const double marginLg = 24;
  static const double marginXl = 28;
  static const double marginXxl = 32;
  static const double marginVast = 36;
  static const double marginGiant = 40;
  static const double marginMass = 44;
  static const double marginMax = 48;
}

//gap

class AppGap{
  static const double gapNano = 4;
  static const double gapMicro = 8;
  static const double gapXs = 12;
  static const double gapSm = 16;
  static const double gapMd = 20;
  static const double gapLg = 24;
  static const double gapXl = 28;
  static const double gapXxl = 32;
  static const double gapVast = 36;
  static const double gapGiant = 40;
  static const double gapMass = 44;
  static const double gapMax = 48;
}

//ELEVACIONES

class AppElevation {

static const double elevation0 = 0;
static const double elevation1 = 1;
static const double elevation2 = 3;
static const double elevation3 = 6;
static const double elevation4 = 8;
static const double elevation5 = 12;


}


//CORNER RADIUS

class AppRadius {
  static const double radiusNone = 0;
  static const double radiusSm = 4;
  static const double radiusMD = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusFull = 9999;
}

//DEFINICIÓN DE COLORES

class AppColors {
  //PRIMARY

  static const primary100 = Color(0xFFEFEBFF);
  static const primary200 = Color(0xFFD6C4FF);
  static const primary300 = Color(0xFFBC9CFF);
  static const primary400 = Color(0xFFA173FF);
  static const primary500 = Color(0xFF8649FF); //Base
  static const primary600 = Color(0xFF753CFA);
  static const primary700 = Color(0xFF622DE3);
  static const primary800 = Color(0xFF4512B5);
  static const primary900 = Color(0xFF2B007A);

  //Colores neutros

  static const neutral100 = Color(0xFFFFFFFF);
  static const neutral200 = Color(0xFFF5F5F5);
  static const neutral300 = Color(0xFFE0E0E0);
  static const neutral400 = Color(0xFFD4D4D4);
  static const neutral500 = Color(0xFFBDBDBD);
  static const neutral600 = Color(0xFF9E9E9E);
  static const neutral700 = Color(0xFF616161);
  static const neutral800 = Color(0xFF424242);
  static const neutral900 = Color(0xFF000000);

  //Color Success

  static const success300 = Color(0xFF00F59C);
  static const success400 = Color(0xFF00DC8C);
  static const success500 = Color(0xFF00D084);
  static const success600 = Color(0xFF30B685);
  static const success700 = Color(0xFF168C61);

  //Color Warning

  static const warning300 = Color(0xFFFFD055);
  static const warning400 = Color(0xFFFFC225);
  static const warning500 = Color(0xFFFFB800);
  static const warning600 = Color(0xFFEAB62E);
  static const warning700 = Color(0xFFE8A800);

  //Color Error

  static const error300 = Color(0xFFFF8F8F);
  static const error400 = Color(0xFFE97171);
  static const error500 = Color(0xFFFF6161);
  static const error600 = Color(0xFFD83636);
  static const error700 = Color(0xFFA93333);

  //Color Inf

  static const info300 = Color(0xFF70D5FF);
  static const info400 = Color(0xFF58B4D4);
  static const info500 = Color(0xFF25ABE3);
  static const info600 = Color(0xFF169BD3);
  static const info700 = Color(0xFF1384B3);

  //color surface
  static const Color surface000 = Color(0xFFFFFFFF);
  static const Color surface100 = Color(0xFF000000);
  static const Color colorMainSurface = Color(0xFFFFFFFF);
  static const Color colorDarkSurface = Color(0xFF000000);
  static const Color onDarkSurface = Color(0xFFFFFFFF);
  static const Color onMainSurface = Color(0xFF000000);
}

//TEMA AUDIOMACK

final ThemeData incollage = ThemeData(

  useMaterial3: true,

  textTheme: const TextTheme(
    displayLarge: AppTypography.h1, 
    displayMedium: AppTypography.h2,
    displaySmall: AppTypography.h3,

    headlineLarge: AppTypography.h4,
    headlineMedium: AppTypography.h5,
    headlineSmall: AppTypography.h6,

    titleLarge: AppTypography.sub1,
    titleMedium: AppTypography.sub2,

    bodyLarge: AppTypography.body1,
    bodyMedium: AppTypography.body2, 

    labelLarge: AppTypography.button,
    bodySmall: AppTypography.caption,
    labelSmall: AppTypography.overline, 
  ),

  colorScheme: const ColorScheme.light(
    //PRIMARY

    primary: AppColors.primary500,
    onPrimary: AppColors.primary100,

    primaryContainer: AppColors.neutral200,
    onPrimaryContainer: AppColors.neutral900,


    secondary: AppColors.primary200,
    onSecondary: AppColors.neutral700,

    secondaryContainer: AppColors.primary100,
    onSecondaryContainer: AppColors.neutral800,

    surface: AppColors.surface000,
    onSurface: AppColors.neutral900,

  ),
);
