import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

/// RepaintBoundary ile widget'ı ekran görüntüsüne çevirip paylaşır.
/// Instagram Stories, WhatsApp Status, genel paylaşım için.
class ShareScreenshotService {
  ShareScreenshotService._();
  static final instance = ShareScreenshotService._();

  /// Widget'ı PNG olarak yakala.
  Future<Uint8List?> captureWidget(GlobalKey key, {double pixelRatio = 3.0}) async {
    try {
      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('captureWidget error: $e');
      return null;
    }
  }

  /// Widget'ı yakala ve paylaş.
  Future<void> captureAndShare(
    GlobalKey key, {
    String text = '',
    double pixelRatio = 3.0,
  }) async {
    final bytes = await captureWidget(key, pixelRatio: pixelRatio);
    if (bytes == null) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/gooffgrid_share.png');
    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }

  /// Instagram Stories'e özel paylaşım (share_plus ile).
  Future<void> shareToInstagramStory(
    GlobalKey key, {
    String? stickerText,
  }) async {
    final bytes = await captureWidget(key, pixelRatio: 3.0);
    if (bytes == null) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/gooffgrid_story.png');
    await file.writeAsBytes(bytes);

    // Instagram Stories share intent
    await Share.shareXFiles(
      [XFile(file.path)],
      text: stickerText ?? '#gooffgrid',
    );
  }
}
