import 'dart:core';
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:path/path.dart' as path;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

String? getenv(String $name) {
  return io.Platform.environment[$name];
}

void setCwd(String $path) {
  io.Directory.current = $path;
}

String getCwd() {
  return io.Directory.current.absolute.path;
}

String pathFullName(String $path) {
  return path.normalize(path.absolute($path));
}

String pathDirectoryName(String $path) {
  return path.dirname($path);
}

String pathFileName(String $path) {
  return path.basename($path);
}

String pathBaseName(String $path) {
  return path.basenameWithoutExtension($path);
}

String pathExtension(String $path) {
  return path.extension($path);
}

List<String> pathFiles(String $path) {
  try {
    final $dir = io.Directory(path.join($path));
    final List<io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io.File> $files = $entities.whereType<io.File>();
    List<String> result = [];
    $files.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result;
  } catch ($e) {
    return <String>[];
  }
}

List<String> pathDirectories(String $path) {
  try {
    final $dir = io.Directory(path.join($path));
    final List<io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io.Directory> $dirs = $entities.whereType<io.Directory>();
    List<String> result = [];
    $dirs.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result;
  } catch ($e) {
    return <String>[];
  }
}

Uint8List readFileBytes(String $path) {
  final $file = io.File($path);
  return $file.readAsBytesSync();
}

String readFileString(String $path) {
  final $file = io.File($path);
  return $file.readAsStringSync();
}

List<String> readFileLines(String $path) {
  final $file = io.File($path);
  return $file.readAsLinesSync();
}

List<String> textToLines(String $s) {
  const $splitter = convert.LineSplitter();
  final $lines = $splitter.convert($s);
  return $lines;
}

bool fileExists(String $path) {
  return io.File($path).existsSync();
}

bool directoryExists(String $path) {
  return io.Directory($path).existsSync();
}
