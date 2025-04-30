import 'dart:core';
import 'dart:convert' as dart_conver;
import 'dart:io' as dart_io;
import 'dart:typed_data';
import 'package:path/path.dart' as path_path;
import 'package:http/http.dart' as http_http;
import 'package:std/std.dart' as std_std;
import 'package:archive/archive.dart' as archive_archive;

bool get isInDebugMode {
  return std_std.isInDebugMode;
}

String? getenv(String name) {
  return std_std.getenv(name);
}

String pathExpand(String path) {
  return std_std.pathExpand(path);
}

void setCwd(String $path) {
  dart_io.Directory.current = pathFullName($path);
}

String getCwd() {
  return pathFullName(dart_io.Directory.current.absolute.path);
}

String pathFullName(String $path) {
  return path_path.normalize(path_path.absolute($path)).replaceAll(r'\', '/');
}

String pathDirectoryName(String $path) {
  return pathFullName(path_path.dirname($path));
}

String pathFileName(String $path) {
  return path_path.basename($path);
}

String pathBaseName(String $path) {
  return path_path.basenameWithoutExtension($path);
}

String pathExtension(String $path) {
  return path_path.extension($path);
}

List<String> _getFilesFromDirRecursive(String $path) {
  List<String> result = [];
  dart_io.Directory dir = dart_io.Directory($path);
  List<dart_io.FileSystemEntity> entities = dir.listSync().toList();
  for (var entity in entities) {
    if (entity is dart_io.File) {
      result.add(pathFullName(entity.path));
    } else if (entity is dart_io.Directory) {
      result.addAll(_getFilesFromDirRecursive(pathFullName(entity.path)));
    }
  }
  return result;
}

List<String> pathFiles(String $path, [bool? $recursive]) {
  try {
    $recursive ??= false;
    if ($recursive) {
      return _getFilesFromDirRecursive(
        $path,
      ).map(($x) => $x.replaceAll(r'\', r'/')).toList();
    }
    final $dir = dart_io.Directory(path_path.join($path));
    final List<dart_io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<dart_io.File> $files = $entities.whereType<dart_io.File>();
    List<String> result = [];
    $files.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result.map(($x) => $x.replaceAll(r'\', r'/')).toList();
  } catch ($e) {
    return <String>[];
  }
}

List<String> pathDirectories(String $path) {
  try {
    final $dir = dart_io.Directory(path_path.join($path));
    final List<dart_io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<dart_io.Directory> $dirs =
        $entities.whereType<dart_io.Directory>();
    List<String> result = [];
    $dirs.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result.map(($x) => $x.replaceAll(r'\', r'/')).toList();
  } catch ($e) {
    return <String>[];
  }
}

Uint8List readFileBytes(String path) {
  return std_std.readFileBytes(path);
}

String readFileString(String path) {
  return std_std.readFileString(path);
}

List<String> readFileLines(String path) {
  return std_std.readFileLines(path);
}

void writeFileBytes(String path, Uint8List data) {
  std_std.writeFileBytes(path, data);
}

void writeFileString(String path, String data) {
  std_std.writeFileString(path, data);
}

List<String> textToLines(String s) {
  return std_std.textToLines(s);
}

bool fileExists(String path) {
  return std_std.fileExists(path);
}

bool directoryExists(String path) {
  return std_std.directoryExists(path);
}

Future<String?> httpGetBodyAsync(String $urlString) async {
  try {
    var url = Uri.parse($urlString);
    var response = await http_http.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  } catch ($e) {
    return null;
  }
}

Future<dynamic> runAsync(
  String command, {
  bool returnCode = false,
  bool useBash = false,
}) async {
  final $run = std_std.CommandRunner(useUnixShell: useBash);
  return $run.run(command, returnCode: returnCode);
}

Future<dynamic> runAsync$(
  List<String> command, {
  List<String>? rest,
  bool returnCode = false,
  bool useBash = false,
  bool autoQuote = true,
}) async {
  var list = <String>[];
  rest ??= <String>[];
  list
    ..addAll(command)
    ..addAll(rest);
  // String $executable = $list[0];
  // List<String> $arguments = $list.sublist(1).toList();
  final $run = std_std.CommandRunner(useUnixShell: useBash);
  return $run.run$(
    // $executable,
    // arguments: $arguments,
    list,
    returnCode: returnCode,
    autoQuote: autoQuote,
  );
}

String lastChars(String s, int len) {
  // return s.substring(s.length - len);
  return std_std.lastChars(s, len);
}

String timeBasedVersionString() {
  return std_std.timeBasedVersionString();
}

void unzipToDirectory(String zipPath, String destDir) {
  zipPath = pathFullName(zipPath);
  destDir = pathFullName(destDir);
  final bytes = dart_io.File(zipPath).readAsBytesSync();
  final archive = archive_archive.ZipDecoder().decodeBytes(bytes);
  for (final entry in archive) {
    if (entry.isFile) {
      var fileBytes = entry.readBytes();
      fileBytes = fileBytes!;
      if (std_std.isText(fileBytes)) {
        String text = dart_conver.utf8.decode(fileBytes);
        text = std_std.adjustTextNewlines(text);
        fileBytes = dart_conver.utf8.encode(text);
      }
      writeFileBytes('$destDir/${entry.name}', fileBytes);
    }
  }
}
