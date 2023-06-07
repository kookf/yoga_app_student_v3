import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// 授权管理
import 'package:permission_handler/permission_handler.dart';

/// 图片缓存管理
import 'package:cached_network_image/cached_network_image.dart';

/// 保存文件或图片到本地
import 'package:image_gallery_saver/image_gallery_saver.dart';

class AppUtil {
  /// 保存图片到相册
  ///
  /// 默认为下载网络图片，如需下载资源图片，需要指定 [isAsset] 为 `true`。
  static Future<void> saveImage(String imageUrl, {bool isAsset: false}) async {
    try {
      if (imageUrl == null) {
        BotToast.showText(text: '保持失敗,圖片不存在!');
      }

      /// 权限检测
      PermissionStatus storageStatus = await Permission.storage.status;
      if (storageStatus != PermissionStatus.granted) {
        storageStatus = await Permission.storage.request();
        if (storageStatus != PermissionStatus.granted) {
          BotToast.showText(text: '無法儲存圖片,請先授權!');
        }
      }

      /// 保存的图片数据
      Uint8List imageBytes;
      File? file;

      if (isAsset == true) {
        /// 保存资源图片
        ByteData bytes = await rootBundle.load(imageUrl);
        imageBytes = bytes.buffer.asUint8List();
      } else {
        /// 保存网络图片

        CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
        BaseCacheManager manager = image.cacheManager ?? DefaultCacheManager();
        // Map<String, String>? headers = image.httpHeaders;
        file = await manager.getSingleFile(
          image.imageUrl,
          // headers: headers,
        );
        imageBytes = await file.readAsBytes();
      }

      /// 保存图片
      final result = await ImageGallerySaver.saveFile(file!.path);

      if (result == null || result == '') throw '图片保存失败';
      BotToast.showText(text: '已存儲到本地相冊');
      print("保存成功${result}");
    } catch (e) {
      BotToast.showText(text: '無效的圖片地址');
      print(e.toString());
    }
  }
}
