## 0.0.1

 - Initial release

## 0.0.2

- Added: isInDebugMode

## 0.0.3

- Added: fileExists() and directoryExists()

## 0.0.4

- Added: pathExtension()

## 0.0.5

- Modified pathFiles() and pathDirectories()

## 2025.420.1441

- Added version tag to GitHub repository

## 2025.421.300

- pathFiles() now accepts optional recursive flag: List<String> pathFiles(String path, [bool? recursive])

## 2025.421.938

- Added: httpGetBodyAsync()

## 2025.421.2149

- Added: runAsync()

## 2025.422.2227

- sys.dart: final _ = pr.Shell(stdoutEncoding: convert.utf8, stderrEncoding: convert.utf8);

## 2025.422.2335

- sys.runAsync() now accepts optional named parameter useBash

## 2025.422.2341

- Introduced runAsync() and runAsync$()

## 2025.424.246

- Removed dependency to process_run and introduced dependency to run package

## 2025.424.1510

- Follows function signature change of run package

## 2025.424.1524

- Added returnCode named parameter to runAsync() and runAsync$()

## 2025.424.1611

- Added: timeBasedVersionString()

## 2025.424.1853

- Removed dependency to run package

## 2025.425.243

- Modified pathDirectoryName()

## 2025.426.1427

- Added: void writeFileBytes(String $path, Uint8List $data), void writeFileString(String $path, String $data) and void unzipToDirectory(String $zipPath, String $destDir)

## 2025.426.1452

- Modified so that writeFileString() calls std.adjustTextNewlines() before writing to file

## 2025.426.1725

- Updated dependencies: std: ^2025.426.1637

## 2025.426.2033

- Update dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.426.1725
+version: 2025.426.2033
-  output: ^1.0.7
+  output: ^2025.426.2027
```

## 2025.426.2256

- Followed change of std:CommandRunner.run$() signature

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.426.2033
+version: 2025.426.2256
-  std: ^2025.426.1637
+  std: ^2025.426.2248
```

## 2025.427.1718

- Update dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.426.2256
+version: 2025.427.1718
-  std: ^2025.426.2248
+  std: ^2025.427.52
```

## 2025.428.1721

- Update dpendency to std package

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.427.1718
+version: 2025.428.1721
-  std: ^2025.427.52
+  std: ^2025.428.1703
```

## 2025.430.1853

- Added: pathExpand()

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.428.1721
+version: 2025.430.1853
-  std: ^2025.428.1703
+  std: ^2025.430.1833
```

## 2025.430.2029

- Modified: runAsync() and runAsync$()

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.430.1853
+version: 2025.430.2029
-  std: ^2025.430.1833
+  std: ^2025.430.2012
```

## 2025.430.2147

- Moved function bodies of some functions to std package

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.430.2029
+version: 2025.430.2147
-  path: ^1.9.1
-  std: ^2025.430.2012
+  std: ^2025.430.2138
```

## 2025.501.850

- Modified readFileString()

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.430.2147
+version: 2025.501.850
-  std: ^2025.430.2138
+  std: ^2025.501.843
```

## 2025.502.2143

- Added: uuidTimeBased(), uuidRandom(), uuidForNamespace(String ns), sha512(Uint8List bytes), installBinaryToTempDir(Uint8List bytes, {String prefix = '', suffix = '', int trial = 0})

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.501.850
+version: 2025.502.2143
+  crypto: ^3.0.6
+  debug_output: ^2025.502.2007
-  std: ^2025.501.843
+  path: ^1.9.1
+  std: ^2025.502.2031
+  uuid: ^4.5.1
-  lints: ^5.1.1
-  output: ^2025.430.1731
+  lints: ^5.1.1
```

## 2025.502.2255

- Fixed bug of pathFullName() not returning full path

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.502.2143
+version: 2025.502.2255
-  crypto: ^3.0.6
-  std: ^2025.502.2031
-  uuid: ^4.5.1
+  std: ^2025.502.2210
```

## 2025.502.2257

- Removed debug print codes

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.502.2255
+version: 2025.502.2257
-  debug_output: ^2025.502.2007
-  path: ^1.9.1
+  debug_output: ^2025.502.2007
```

## 2025.502.2337

- Update package dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.502.2257
+version: 2025.502.2337
-  std: ^2025.502.2210
+  std: ^2025.502.2329
```

## 2025.503.6

- Added adjustPackageName(String name)

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.502.2337
+version: 2025.503.6
-  std: ^2025.502.2329
+  std: ^2025.502.2358
```

## 2025.503.56

- Added reformatUglyYaml(String yaml) and reformatUglyYamlFile(String yamlPath)

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.503.6
+version: 2025.503.56
```

## 2025.503.117

- Modified unzipToDirectory() and untarToDirectory() so that they accept both archive path and archive bytes for input

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.503.56
+version: 2025.503.117
```

## 2025.504.647

- Fixed a bug of pathExpand()

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.503.117
+version: 2025.504.647
-  std: ^2025.502.2358
+  std: ^2025.504.612
```

## 2025.504.1149

- Added 'String get pathOfUserDir'

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.504.647
+version: 2025.504.1149
-  std: ^2025.504.612
+  std: ^2025.504.1143
```

## 2025.504.1255

- Added pathJoin(List<String> parts)

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.504.1149
+version: 2025.504.1255
-  std: ^2025.504.1143
+  std: ^2025.504.1244
```

## 2025.513.437

- Added class CommandRunner from std/commaond_runner.dart

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.504.1255
+version: 2025.513.437
-  http: ^1.3.0
+  http: ^1.4.0
-  debug_output: ^2025.502.2007
+  debug_output: ^2025.504.1731
```

## 2025.523.1959

- Update dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.513.437
+version: 2025.523.1959
-  std: ^2025.504.1244
+  std: ^2025.523.1954
-  test: ^1.25.15
+  test: ^1.26.2
-  lints: ^5.1.1
+  lints: ^6.0.0
```

## 2025.525.2335

- Update dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.523.1959
+version: 2025.525.2335
-  std: ^2025.523.1954
+  std: ^2025.525.1954
```

## 2025.526.1802

- Update dependencies

```
--- a/pubspec.yaml
+++ b/pubspec.yaml
-version: 2025.525.2335
+version: 2025.526.1802
-  std: ^2025.525.1954
+  std: ^2025.526.1751
```
