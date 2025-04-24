import 'dart:core';
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:typed_data';
//import 'package:intl/intl.dart' as intl;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:std/command_runner.dart' as run;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

String? getenv(String $name) {
  return io.Platform.environment[$name];
}

void setCwd(String $path) {
  io.Directory.current = pathFullName($path);
}

String getCwd() {
  return pathFullName(io.Directory.current.absolute.path);
}

String pathFullName(String $path) {
  return path.normalize(path.absolute($path));
}

String pathDirectoryName(String $path) {
  return pathFullName(path.dirname($path));
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

List<String> _getFilesFromDirRecursive(String $path) {
  List<String> result = [];
  io.Directory dir = io.Directory($path);
  List<io.FileSystemEntity> entities = dir.listSync().toList();
  for (var entity in entities) {
    if (entity is io.File) {
      result.add(pathFullName(entity.path));
    } else if (entity is io.Directory) {
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
    final $dir = io.Directory(path.join($path));
    final List<io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io.File> $files = $entities.whereType<io.File>();
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
    final $dir = io.Directory(path.join($path));
    final List<io.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io.Directory> $dirs = $entities.whereType<io.Directory>();
    List<String> result = [];
    $dirs.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result.map(($x) => $x.replaceAll(r'\', r'/')).toList();
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

Future<String?> httpGetBodyAsync(String $urlString) async {
  try {
    var url = Uri.parse($urlString);
    var response = await http.get(url);
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
  final $run = run.CommandRunner(useUnixShell: useBash);
  return $run.run(command, returnCode: returnCode);
}

Future<dynamic> runAsync$(
  List<String> command, {
  List<String>? rest,
  bool returnCode = false,
  bool useBash = false,
  bool autoQuote = true,
}) async {
  var $list = <String>[];
  rest ??= <String>[];
  $list
    ..addAll(command)
    ..addAll(rest);
  String $executable = $list[0];
  List<String> $arguments = $list.sublist(1).toList();
  final $run = run.CommandRunner(useUnixShell: useBash);
  return $run.run$(
    $executable,
    arguments: $arguments,
    returnCode: returnCode,
    autoQuote: autoQuote,
  );
}

String _adjustVersionString(String $s) {
  List<String> $split = $s.split('.');
  List<String> $result = <String>[];
  for (int i = 0; i < $split.length; i++) {
    String $part = $split[i];
    String $part2 = '';
    bool isBeggining = true;
    for (int j = 0; j < $part.length; j++) {
      if (!isBeggining || (j == $part.length - 1)) {
        $part2 += $part[j];
      } else {
        if ($part[j] != '0') {
          $part2 += $part[j];
          isBeggining = false;
        }
      }
    }
    $result.add($part2);
  }
  return $result.join('.');
}

String lastChars(String s, int len) {
  return s.substring(s.length - len);
}

String timeBasedVersionString() {
  final now = DateTime.now();
  // final formatter1 = intl.DateFormat('yyyy.MMdd.HHmm');
  // String version = formatter1.format(now);
  String year = '${now.year}';
  String month = lastChars('0${now.month}', 2);
  String day = lastChars('0${now.day}', 2);
  String hour = lastChars('0${now.hour}', 2);
  String minute = lastChars('0${now.minute}', 2);
  String version = '$year.$month$day.$hour$minute';
  version = _adjustVersionString(version);
  return version;
}
