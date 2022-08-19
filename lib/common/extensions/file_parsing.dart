import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

extension FileParsing on File {
  File compresed() {
    late File file;
    async compressAndGetFile(this, '').then((value) => file = value);
    return file;
  }
}

Future<File> compressAndGetFile(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 88,
    rotate: 180,
  );

  return result;
}
