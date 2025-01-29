import "dart:io";

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

void main() {
  if (true) {
    print('${'*' * 10}Start${'*' * 10}');
  }
  final directory = Directory("assets/icons");
  const outputPath = "lib/commons/utils/enums/icons_enum.dart";

  if (!directory.existsSync()) {
    if (true) {
      print("Directory does not exist: ${directory.path}");
    }
    return;
  }

  final buffer = StringBuffer();
  buffer.writeln("enum FalaTuIconsEnum {");

  final svgFiles = directory
      .listSync()
      .where((file) => file.path.endsWith(".svg"))
      .map((file) => File(file.path))
      .toList();

  for (var file in svgFiles) {
    final fileName = file.uri.pathSegments.last;
    String completeName = fileName.split(".").first;

    final listWords = completeName.split("_");
    String enumName = "";
    for (var element in listWords) {
      if (listWords.first == element) {
        enumName = element;
        continue;
      }
      enumName += capitalize(element);
    }
    final comma = file == svgFiles.last ? ";" : ",";
    buffer.writeln('  $enumName("$fileName")$comma');
  }

  buffer.writeln("""
    

  const FalaTuIconsEnum(this.value);
  final String value;
}
""");

  File(outputPath).writeAsStringSync(buffer.toString());
  if (true) {
    print("Enum generated at: $outputPath");
  }
}
