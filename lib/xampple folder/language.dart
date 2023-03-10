class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "π¦π«", "ΩΨ§Ψ±Ψ³Ϋ", "fa"),
      Language(2, "πΊπΈ", "English", "en"),
      Language(3, "πΈπ¦", "Ψ§ΩΩΩΨΉΩΨ±ΩΨ¨ΩΩΩΩΨ©Ω", "ar"),
      //TODO : add Hindi language
    ];
  }
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> EN = {title: 'Localization'};
  static const Map<String, dynamic> KM = {title: 'ααΆαααααΎααΌαααααΆααΈααααα'};
  static const Map<String, dynamic> JA = {title: 'γ­γΌγ«γͺγΌγΌγ·γ§γ³'};
}