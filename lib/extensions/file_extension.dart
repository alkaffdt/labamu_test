import 'dart:io';

extension FileExtension on File {
  static String? preSignedUrl;

  bool get isImage {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final fileExtension = path.split('.').last.toLowerCase();
    return imageExtensions.contains(fileExtension);
  }

  bool get isVideo {
    final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv'];
    final fileExtension = path.split('.').last.toLowerCase();
    return videoExtensions.contains(fileExtension);
  }
}
