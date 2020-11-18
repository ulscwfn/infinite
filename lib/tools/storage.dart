import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart' show required;
import 'package:shared_preferences/shared_preferences.dart';

/// 本地缓存插件封装
class Storage {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// 获取String类型数据
  Future<String> getString(String key) async {
    assert(key is String, '返回参数只接收string类型');
    var storage = await prefs;
    return storage.getString(key);
  }

  /// 获取Map类型数据
  Future<Map<String, V>> getMap<V>(String key) async {
    var storage = await prefs;
    var data = storage.getString(key);
    if (data == null) {
      return null;
    } else {
      var json = convert.jsonDecode(data);
      Map<String, V> conversion = (json as Map).cast();
      return conversion;
    }
  }

  /// 获取List类型数据
  Future<List<V>> getList<V>(String key) async {
    var storage = await prefs;
    var stringData = storage.getString(key);
    var json = convert.jsonDecode(stringData);
    if (json == null) {
      return null;
    } else {
      List<V> conversion = (json as List).map<V>((it) {
        var itemType = it.runtimeType.toString();
        if (itemType.contains('Map')) {
          var vt = (it as Map).cast();
          return vt as V;
        } else {
          return it as V;
        }
      }).toList();
      return conversion;
    }
  }

  /// 写入String类型数据
  Future<bool> setString({
    @required String key,
    @required String value,
  }) async {
    var storage = await prefs;
    return storage.setString(key, value);
  }

  /// 写入Map类型数据
  Future<bool> setMap<K, V>({
    @required String key,
    @required Map<K, V> value,
  }) async {
    var storage = await prefs;
    // var data = storage.getString(key);
    var conversion = convert.jsonEncode(value);
    return storage.setString(key, conversion);
  }

  /// 写入Map类型数据
  Future<bool> setList<V>({
    @required String key,
    @required V value,
  }) async {
    assert(value is List, '数据类型只能为List');
    var storage = await prefs;
    var conversion = convert.jsonEncode(value);
    return storage.setString(key, conversion);
  }

  /// 删除对应key值的数据
  void remove(String key) async {
    SharedPreferences storage = await this.prefs;
    await storage.remove(key);
  }

  /// 清空所用数据
  void clear() async {
    SharedPreferences storage = await this.prefs;
    storage.clear();
  }
}
