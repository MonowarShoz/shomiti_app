import 'dart:ui';

class ColorsManager {
    // static final Color primary_color = const Color(0xFF071974);
  static const Color primary_color =  Color(0xFF1B4BBD);
  static const Color appTileColor =  Color.fromARGB(255, 4, 65, 170);
  static const Color prinaTextColor =  Color(0xFF334163);
  static const Color light_primary =  Color(0xFFAFC7C7);
  static const Color extraa_light =  Color(0xFFc6dfe0);
  static const Color light =  Color(0xFFADE8E8);
  static const Color mainBlue = Color(0xFF247CFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF121212);
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);
  static const Color blueAccent = Color.fromRGBO(68, 138, 255, 1);
  static const Color lightGray = Color.fromARGB(255, 160, 160, 160);
  static const Color lightBlueAccent = Color.fromARGB(255, 240, 255, 255);
  static const Color lightBlue = Color.fromARGB(255, 239, 247, 248);
  static const Color darckBlue = Color(0xFF242424);
  static const Color extraLightGray = Color.fromARGB(255, 230, 229, 229);
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color ultraGray = Color(0xFFFDFDFF);
  static const Color skyBlue = Color.fromARGB(255, 36, 156, 255);
  static const Color transparentGray = Color.fromARGB(87, 230, 229, 229);
  static const Color gray = Color(0xFFE5E5E5);
  static const Color grayShade100 = Color.fromRGBO(245, 245, 245, 1);
  static const Color grayShade300 = Color(0xFFE0E0E0);

  static const Color brown = Color.fromARGB(198, 196, 146, 156);
  static const Color brownHint = Color.fromARGB(101, 37, 20, 24);
  static const Color transparentBrown = Color.fromARGB(100, 78, 51, 57);
  static const Color grayHint = Color.fromARGB(255, 252, 250, 250);

  static const Color lightPink = Color.fromARGB(209, 255, 201, 219);
  static const Color pink = Color.fromARGB(255, 248, 64, 126);

  static const Color lightGreen = Color.fromARGB(209, 181, 255, 212);
  static const Color green = Color.fromARGB(255, 20, 206, 135);

  static const Color extraLightBlue = Color.fromARGB(181, 189, 226, 255);
  static const Color lightBlueSky = Color.fromARGB(255, 248, 250, 250);


  Color _getColorForIndex(int id) {
    final colors = [
      Color(0xFF93C5FD), // Light Blue
      Color(0xFFFBBF24), // Light Amber
      Color(0xFF34D399), // Light Green
      Color(0xFFF472B6), // Light Pink
      Color(0xFFA78BFA), // Light Purple
      Color(0xFF60A5FA), // Sky Blue
      Color(0xFFFCA5A5), // Light Red
      Color(0xFF2DD4BF), // Light Teal
    ];
    return colors[id % colors.length];
  }

  //profess
  Color getfColorForIndex(int id) {
    final colors = [
      Color(0xFF1E40AF), // Professional Blue
      Color(0xFF7C2D12), // Professional Brown
      Color(0xFF065F46), // Professional Green
      Color(0xFF9333EA), // Professional Purple
      Color(0xFFB91C1C), // Professional Red
      Color(0xFF0E7490), // Professional Teal
      Color(0xFFCA8A04), // Professional Gold
      Color(0xFF4338CA), // Professional Indigo
    ];
    return colors[id % colors.length];
  }
  //google
  Color getGColorForIndex(int id) {
    final colors = [
      Color(0xFF6750A4), // M3 Primary
      Color(0xFF7D5260), // M3 Secondary
      Color(0xFF386A20), // M3 Tertiary
      Color(0xFFB3261E), // M3 Error
      Color(0xFF006A6A), // M3 Teal
      Color(0xFFB3261E), // M3 Red
      Color(0xFF7D5260), // M3 Purple
      Color(0xFF006874), // M3 Blue
    ];
    return colors[id % colors.length];
  }

  //rec
  Color getrColorForIndex(int id) {
    final colors = [
      Color(0xFF6366F1), // Indigo - Professional
      Color(0xFF10B981), // Emerald - Fresh
      Color(0xFFF59E0B), // Amber - Warm
      Color(0xFFEC4899), // Pink - Friendly
      Color(0xFF8B5CF6), // Purple - Creative
      Color(0xFF06B6D4), // Cyan - Modern
      Color(0xFFEF4444), // Red - Urgent
      Color(0xFF3B82F6), // Blue - Trustworthy
    ];
    return colors[id % colors.length];
  }


}
