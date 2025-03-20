enum FileExtensionsEnum {
  pdf("pdf"),
  xls("xls"),
  xlsx("xlsx"),
  doc("doc"),
  docx("docx"),
  txt("txt"),
  csv("csv");

  const FileExtensionsEnum(this.value);

  final String value;

  static FileExtensionsEnum fromName(String name) {
    return FileExtensionsEnum.values.firstWhere((e) => e.name == name);
  }

  static List<String> allToName() {
    return FileExtensionsEnum.values.map((e) => e.name).toList();
  }
}
