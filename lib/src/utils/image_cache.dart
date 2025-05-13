import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCacheHelper {
  final BuildContext context;

  ImageCacheHelper(this.context);

  Future<void> cacheImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imageAssetsList =
        manifestMap.keys
            .where((path) => path.startsWith('assets/images/'))
            .toList();

    if (!context.mounted) return;

    for (var imagePath in imageAssetsList) {
      final extension = imagePath.split('.').last.toLowerCase();

      switch (extension) {
        case 'png':
        case 'jpg':
        case 'jpeg':
        case 'gif':
        case 'webp':
          await _cacheNormalImage(imagePath);
          break;
        case 'svg':
          await _cacheSvgImage(imagePath);
          break;
        default:
          debugPrint('Unsupported image format: $imagePath');
      }
    }
  }

  Future<void> _cacheNormalImage(String imagePath) async {
    try {
      await precacheImage(AssetImage(imagePath), context);
    } catch (e) {
      debugPrint('Failed to cache normal image: $imagePath - $e');
    }
  }

  Future<void> _cacheSvgImage(String imagePath) async {
    try {
      final loader = SvgAssetLoader(imagePath);
      await svg.cache.putIfAbsent(
        loader.cacheKey(null),
        () => loader.loadBytes(null),
      );
    } catch (e) {
      debugPrint('Failed to cache SVG image: $imagePath - $e');
    }
  }
}
