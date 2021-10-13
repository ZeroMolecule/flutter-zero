class PokeApiParser {
  static String? parseImage(dynamic data) {
    if (data is String) {
      return data;
    } else if (data is Map<String, dynamic>) {
      return data['front_default'] ??
          data['front_female'] ??
          data['front_shiny'] ??
          data['front_shiny_female'] ??
          data['back_default'] ??
          data['back_female'] ??
          data['back_shiny'] ??
          data['back_shiny_female'];
    }
    return null;
  }
}
