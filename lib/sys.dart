import 'dart:core';
import 'dart:convert' as dart_conver;
import 'dart:io' as dart_io;
import 'dart:typed_data';
import 'package:http/http.dart' as http_http;
import 'package:std/std.dart' as std_std;
import 'package:archive/archive.dart' as archive_archive;
import 'package:crypto/crypto.dart' as crypto_crypto;
import 'package:path/path.dart' as path_path;
import 'package:uuid/uuid.dart' as uuid_uuid;

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

String pathFullName(String path) {
  return std_std.pathFileName(path);
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

String get pathOfTempDir {
  return std_std.pathOfTempDir;
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

String lastChars(String s, int len) {
  return std_std.lastChars(s, len);
}

String timeBasedVersionString() {
  return std_std.timeBasedVersionString();
}

void unzipToDirectory(String zipPath, String destDir) {
  zipPath = pathFullName(std_std.pathExpand(zipPath));
  destDir = pathFullName(std_std.pathExpand(destDir));
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

/// Generates a time-based version 1 UUID
String uuidTimeBased() {
  var uuid = uuid_uuid.Uuid();
  return uuid.v1();
}

/// Generates a RNG version 4 UUID (a random UUID)
String uuidRandom() {
  var uuid = uuid_uuid.Uuid();
  return uuid.v4();
}

/// Generate a v5 (namespace-name-sha1-based) id
String uuidForNamespace(String ns) {
  var uuid = uuid_uuid.Uuid();
  return uuid.v5(uuid_uuid.Namespace.url.value, ns);
}

String sha512(Uint8List bytes) {
  var digest = crypto_crypto.sha512.convert(bytes);
  return digest.toString();
}

String installBinaryToTempDir(
  Uint8List bytes, {
  String prefix = '',
  suffix = '',
  int trial = 0,
}) {
  //var digest = crypto_crypto.sha256.convert(bytes);
  var sha = sha512(bytes);
  String fileName = prefix + sha + (trial == 0 ? '' : '_$trial') + suffix;
  String path = path_path
      .join(std_std.pathOfTempDir, fileName)
      .replaceAll(r'\', '/');
  if (!fileExists(path)) {
    String uuid = uuidTimeBased();
    writeFileBytes('$path.$uuid', bytes);
    try {
      dart_io.File('$path.$uuid').renameSync(path);
    } catch (_) {}
  }
  Uint8List bytes2 = readFileBytes(path);
  String sha2 = sha512(bytes2);
  if (sha == sha2) {
    return path;
  }
  return installBinaryToTempDir(
    bytes,
    prefix: prefix,
    suffix: suffix,
    trial: trial + 1,
  );
}
