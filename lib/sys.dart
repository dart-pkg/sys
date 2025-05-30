import 'dart:core';
import 'dart:convert' as dart_conver;
import 'dart:io' as dart_io;
import 'dart:typed_data';
import 'package:http/http.dart' as http_http;
import 'package:std/std.dart' as std_std;
import 'package:archive/archive.dart' as archive_archive;
//import 'package:debug_output/debug_output.dart';
export 'package:std/command_runner.dart' show CommandRunner;

bool get isInDebugMode {
  return std_std.isInDebugMode;
}

String? getenv(String name) {
  return std_std.getenv(name);
}

String pathExpand(String path) {
  return std_std.pathExpand(path);
}

String pathJoin(List<String> parts) {
  return std_std.pathJoin(parts);
}

void setCwd(String path) {
  std_std.setCwd(path);
}

String getCwd() {
  return std_std.getCwd();
}

String pathFullName(String path) {
  return std_std.pathFullName(path);
}

String pathDirectoryName(String path) {
  return std_std.pathDirectoryName(path);
}

String pathFileName(String path) {
  return std_std.pathFileName(path);
}

String pathBaseName(String path) {
  return std_std.pathBaseName(path);
}

String pathExtension(String path) {
  return std_std.pathExtension(path);
}

List<String> pathFiles(String path, [bool? recursive]) {
  return std_std.pathFiles(path, recursive);
}

List<String> pathDirectories(String path) {
  return std_std.pathDirectories(path);
}

void pathRename(String oldPath, String newPath) {
  return std_std.pathRename(oldPath, newPath);
}

String get pathOfTempDir {
  return std_std.pathOfTempDir;
}

String get pathOfUserDir {
  return std_std.pathOfUserDir;
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

String lastChars(String s, int len) {
  return std_std.lastChars(s, len);
}

String timeBasedVersionString() {
  return std_std.timeBasedVersionString();
}

/// Generates a time-based version 1 UUID
String uuidTimeBased() {
  return std_std.uuidTimeBased();
}

/// Generates a RNG version 4 UUID (a random UUID)
String uuidRandom() {
  return std_std.uuidRandom();
}

/// Generate a v5 (namespace-name-sha1-based) id
String uuidForNamespace(String ns) {
  return std_std.uuidForNamespace(ns);
}

String md5(Uint8List bytes) {
  return std_std.md5(bytes);
}

String sha1(Uint8List bytes) {
  return std_std.sha1(bytes);
}

String sha224(Uint8List bytes) {
  return std_std.sha224(bytes);
}

String sha256(Uint8List bytes) {
  return std_std.sha256(bytes);
}

String sha512(Uint8List bytes) {
  return std_std.sha512(bytes);
}

bool identicalBinaries(Uint8List bytes1, Uint8List bytes2) {
  return std_std.identicalBinaries(bytes1, bytes2);
}

String installBinaryToTempDir(
  Uint8List bytes, {
  String prefix = '',
  suffix = '',
}) {
  return std_std.installBinaryToTempDir(bytes, prefix: prefix, suffix: suffix);
}

String adjustPackageName(String name) {
  return std_std.adjustPackageName(name);
}

/***** Original Implementation of sys package *****/

///
String reformatUglyYaml(String yaml) {
  List<String> lines1 = textToLines(yaml);
  List<String> lines2 = <String>[];
  for (int i = 0; i < lines1.length; i++) {
    if (i > 0) {
      if (lines1[i] == '' && lines1[i - 1] == '') {
        continue;
      }
    }
    lines2.add(lines1[i]);
  }
  yaml = lines2.join('\n');
  if (yaml.endsWith('\n\n')) {
    yaml = yaml.substring(0, yaml.length - 1);
  } else if (!yaml.endsWith('\n')) {
    yaml += '\n';
  }
  return yaml;
}

///
void reformatUglyYamlFile(String yamlPath) {
  String yaml = readFileString(yamlPath);
  writeFileString(yamlPath, reformatUglyYaml(yaml));
}

///
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
  dart_conver.Encoding? encoding,
  bool returnCode = false,
  bool useBash = false,
}) async {
  final $run = std_std.CommandRunner(encoding: encoding, useUnixShell: useBash);
  return $run.run(command, returnCode: returnCode);
}

Future<dynamic> runAsync$(
  List<String> command, {
  List<String>? rest,
  dart_conver.Encoding? encoding,
  bool returnCode = false,
  bool useBash = false,
  bool autoQuote = true,
}) async {
  var list = <String>[];
  rest ??= <String>[];
  list
    ..addAll(command)
    ..addAll(rest);
  final $run = std_std.CommandRunner(encoding: encoding, useUnixShell: useBash);
  return $run.run$(list, returnCode: returnCode, autoQuote: autoQuote);
}

void unzipToDirectory(dynamic pathOrBytes, String destDir) {
  Uint8List bytes;
  if (pathOrBytes is String) {
    String zipPath = pathOrBytes;
    zipPath = pathFullName(std_std.pathExpand(zipPath));
    destDir = pathFullName(std_std.pathExpand(destDir));
    bytes = dart_io.File(zipPath).readAsBytesSync();
  } else if (pathOrBytes is Uint8List) {
    bytes = pathOrBytes;
  } else {
    throw ArgumentError();
  }
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

void untarToDirectory(dynamic pathOrBytes, String destDir) {
  Uint8List bytes;
  if (pathOrBytes is String) {
    String zipPath = pathOrBytes;
    zipPath = pathFullName(std_std.pathExpand(zipPath));
    destDir = pathFullName(std_std.pathExpand(destDir));
    bytes = dart_io.File(zipPath).readAsBytesSync();
  } else if (pathOrBytes is Uint8List) {
    bytes = pathOrBytes;
  } else {
    throw ArgumentError();
  }
  final archive = archive_archive.TarDecoder().decodeBytes(bytes);
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
