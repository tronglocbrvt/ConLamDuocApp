import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:conlamduoc/core/R.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show Codec;
import 'dart:convert';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

// Used for max age, the default is 24 hours
const int IMAGE_DOWNLOAD_CACHE_MAX_AGE_HOUR = 24;

// Used for max age, approximately 100 years (Not use the default above)
const int IMAGE_PERSISTENT_CACHE_MAX_AGE_DAY = 100 * 365; 

// Used for max entries
const int IMAGE_CACHE_MAX_NUMBER = 100; 

class ImageCacheManager {
  static final DiskCache _customDiskCache = DiskCache();
  static final DiskCache _persistentDiskCache = DiskCache(
      isPersistent: true,
      maxAge: Duration(days: IMAGE_PERSISTENT_CACHE_MAX_AGE_DAY));

  static bool isAssetImage(String image) {
    return image.startsWith("assets/");
  }

  static Widget getImage({
    @required String url,
    Key key,
    double scale = 1.0,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    FilterQuality filterQuality = FilterQuality.low,
    fadeInDuration,
  }) {
    if (url == null) {
      return Image.asset(
        R.images.default_image,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        filterQuality: filterQuality,
      );
    }

    if (isAssetImage(url)) {
      return Image.asset(
        url,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        filterQuality: filterQuality,
      );
    } else {
      if (url.length == 0) {
        return Image.asset(
          R.images.default_image,
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          filterQuality: filterQuality,
        );
      }

      Widget image = FadeInImage.assetNetwork(
        placeholder: R.images.default_image,
        image: url,
        fit: fit,
        fadeInDuration: (fadeInDuration == null
            ? new Duration(milliseconds: 100)
            : fadeInDuration),
        height: height,
        width: width,
        alignment: alignment,
        excludeFromSemantics: excludeFromSemantics,
        matchTextDirection: matchTextDirection,
        repeat: repeat,
        imageSemanticLabel: semanticLabel,
      );

      if (image == null) {
        return Image.asset(
          R.images.default_image,
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          filterQuality: filterQuality,
        );
      }

      return image;
    }
  }

  static CustomImageProvider getImageData({@required String url}) {
    if (url == null) {
      return CustomImageProvider(R.images.default_image,
          cache: _persistentDiskCache);
    }

    CustomImageProvider data = CustomImageProvider(url,
        cache: isAssetImage(url) ? _persistentDiskCache : _customDiskCache);
    if (data != null) {
      return data;
    }

    return CustomImageProvider(R.images.default_image,
        cache: _persistentDiskCache);
  }

  static void clear() {
    _customDiskCache.clear();
  }
}

class CustomImageProvider extends ImageProvider<CustomImageProvider> {
  CustomImageProvider(
    this.url, {
    this.scale = 1.0,
    this.cache,
  })  : assert(url != null),
        assert(scale != null);

  final String url;
  final double scale;
  final DiskCache cache;

  @override
  Future<CustomImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CustomImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(CustomImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
    );
  }

  Future<ui.Codec> _loadAsync(CustomImageProvider key) async {
    assert(key == this);

    String uId = key.url.hashCode.toString();

    Uint8List _cacheData = await _loadFromDiskCache(key, uId);
    if (_cacheData != null) {
      return await PaintingBinding.instance.instantiateImageCodec(_cacheData);
    }

    return null;
  }

  Future<Uint8List> _loadFromDiskCache(
      CustomImageProvider key, String uId) async {
    Uint8List data = await cache.load(uId);
    if (data != null) {
      return data;
    }

    if (cache.isPersistent) {
      ByteData bytes = await rootBundle.load(url);
      Uint8List rawPath = bytes.buffer.asUint8List();
      return rawPath;
    } else {
      Uint8List imageData = await _loadFromRemote(key.url);
      if (imageData != null) {
        await cache.save(uId, imageData);
        return imageData;
      } else {
        ByteData bytes = await rootBundle.load(R.images.default_image);
        Uint8List rawPath = bytes.buffer.asUint8List();
        return rawPath;
      }
    }
  }

  Future<Uint8List> _loadFromRemote(String url) async {
    assert(url != null);

    http.Response _response = await http.get(url);
    if (_response != null && _response.statusCode == 200)
      return _response.bodyBytes;

    return null;
  }
}

class DiskCache {
  DiskCache({
    this.maxEntries = IMAGE_CACHE_MAX_NUMBER,
    this.maxAge = const Duration(hours: IMAGE_DOWNLOAD_CACHE_MAX_AGE_HOUR),
    this.isPersistent = false,
  });

  final int maxEntries;
  final Duration maxAge;
  final bool isPersistent;

  Map<String, dynamic> _metadata;

  String _metaDataFileName() {
    return 'imagecache_metadata${isPersistent ? '_persistent' : ''}.json';
  }

  Future<void> _initMetaData() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File path = File(join(dir.path, _metaDataFileName()));
    if (path.existsSync()) {
      _metadata = json.decode(await path.readAsString());
    } else {
      _metadata = {};
    }
  }

  Future<void> _commitMetaData() async {
    File path = File(join(
        (await getApplicationDocumentsDirectory()).path, _metaDataFileName()));
    await path.writeAsString(json.encode(_metadata));
  }

  Future<Uint8List> load(String uid) async {
    if (_metadata == null) await _initMetaData();

    if (_metadata.containsKey(uid)) {
      if (!File(_metadata[uid]['path']).existsSync()) {
        _metadata.remove(uid);
        await _commitMetaData();
        return null;
      }

      if (DateTime.fromMillisecondsSinceEpoch(
              _metadata[uid]['createdTime'] + _metadata[uid]['maxAge'])
          .isBefore(DateTime.now())) {
        await File(_metadata[uid]['path']).delete();
        _metadata.remove(uid);
        await _commitMetaData();
        return null;
      }

      Uint8List data = await File(_metadata[uid]['path']).readAsBytes();
      return data;
    } else {
      return null;
    }
  }

  Future<void> save(String uid, Uint8List data) async {
    if (_metadata == null) await _initMetaData();
    Directory dir = Directory(join(
        (await getApplicationDocumentsDirectory()).path,
        'imagecache${isPersistent ? '_persistent' : ''}'));

    if (!dir.existsSync()) dir.createSync(recursive: true);
    await File(join(dir.path, uid)).writeAsBytes(data);

    Map<String, dynamic> metadata = {
      'path': join(dir.path, uid),
      'createdTime': DateTime.now().millisecondsSinceEpoch,
      'maxAge': maxAge.inMilliseconds,
    };

    _metadata[uid] = metadata;
    await _checkCacheSize();
    await _commitMetaData();
  }

  Future<void> _checkCacheSize() async {
    while (_metadata.length > maxEntries) {
      String key = _metadata.keys.first;
      if (File(_metadata[key]['path']).existsSync()) {
        await File(_metadata[key]['path']).delete();
      }

      _metadata.remove(key);
    }
  }

  void clear() async {
    Directory appDir = Directory(join(
        (await getApplicationDocumentsDirectory()).path,
        'imagecache${isPersistent ? '_persistent' : ''}'));
    File metadataFile = File(join(
        (await getApplicationDocumentsDirectory()).path, _metaDataFileName()));
    if (appDir.existsSync()) {
      await appDir.delete(recursive: true);
      if (metadataFile.existsSync()) {
        await metadataFile.delete();
      }

      _metadata = {};
    }
  }
}
