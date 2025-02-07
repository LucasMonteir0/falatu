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
  final directory = Directory("assets/images");
  const outputPath = "lib/commons/utils/enums/images_enum.dart";

  if (!directory.existsSync()) {
    if (true) {
      print("Directory does not exist: ${directory.path}");
    }
    return;
  }

  final buffer = StringBuffer();
  buffer.writeln("enum FalaTuImagesEnum {");

  final files = directory
      .listSync()
      .where((file) {
        return file.path.endsWith(".png") ||
            file.path.endsWith(".jpg") ||
            file.path.endsWith(".jpeg");
      })
      .map((file) => File(file.path))
      .toList();

  for (var file in files) {
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
    final comma = file == files.last ? ";" : ",";
    buffer.writeln('  $enumName("$fileName")$comma');
  }

  buffer.writeln("""
    

  const FalaTuImagesEnum(this.value);
  final String value;
}
""");

  File(outputPath).writeAsStringSync(buffer.toString());
  if (true) {
    print("Enum generated at: $outputPath");
  }
}
