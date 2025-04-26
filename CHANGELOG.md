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
