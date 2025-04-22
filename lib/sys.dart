import 'dart:core';
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:process_run/shell.dart' as pr;

//import 'package:dynamic_function/dynamic_function.dart';
import 'package:misc/misc.dart' as misc;

final _$shell = pr.Shell(
  stdoutEncoding: convert.utf8,
  stderrEncoding: convert.utf8,
);

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

Future<List<io.ProcessResult>> runAsync(String command, {bool? useBash}) async {
  String $commandLine = command;
  useBash ??= false;
  if (useBash) {
    $commandLine = "bash -c '${$commandLine}'";
  }
  print('${getCwd()}>${$commandLine}');
  return _$shell.run($commandLine);
}

Future<List<io.ProcessResult>> runAsync$(
  List<String> command, {
  List<String>? rest,
  bool? useBash,
}) async {
  var $list = <String>[];
  rest ??= <String>[];
  $list
    ..addAll(command)
    ..addAll(rest);
  String $commandLine = misc.makeCommandLine($list);
  return runAsync($commandLine, useBash: useBash);
}

// final dynamic run$ = DynamicFunction((
//     List<dynamic> $positional,
//     Map<Symbol, dynamic> $named,
//     ) {
//   if ($positional.isEmpty) {
//     throw '${$positional.length} arguments supplied to command\$()';
//   }
//   dynamic $cmd = $positional[0];
//   List<String> $cmdArgs = <String>[];
//   for (int $i = 1; $i < $positional.length; $i++) {
//     $cmdArgs.add($positional[$i]);
//   }
//   checkNamed($named, ['rest']);
//   List<String> $rest =
//   ($named[Symbol('rest')] == null)
//       ? <String>[]
//       : $named[Symbol('rest')] as List<String>;
//   for (int $i=0; $i<$rest.length; $i++) {
//     $cmdArgs.add($rest[$i]);
//   }
//   run($cmd, $cmdArgs);
//   return null;
// });
