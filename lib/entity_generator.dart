import 'dart:convert';

import 'package:base/test/test_entity.dart';


class DefaultEntityBase extends EntityBase {
  //格式化列表实体类
  @override
  T generateListFormJson<T>(List<dynamic> mapList) {
    if (mapList == null) return null;

    switch (T.toString()) {
//      case "List<LearnCommonCategoryEntity>":
//        return mapList
//            .map((data) => LearnCommonCategoryEntity.fromJson(
//                data as Map<String, dynamic>))
//            .toList() as T;
      default:
        return super.generateListFormJson(mapList);
    }
  }

  //格式化一般实体类
  @override
  T generateFormJson<T>(data) {
    if (data == null) return null;

    switch (T.toString()) {
      case "TestEntity":
        return TestEntity().fromJson(data) as T;
      default:
        return super.generateFormJson(data);
    }
  }
}

//实体类与json互转代码
abstract class EntityBase {
  //是否为列表
  static bool _isList<T>() {
    return T.toString().startsWith('List');
  }

  T formJson<T>(data) {
    if (_isList<T>()) {
      return generateListFormJson(data);
    } else {
      return generateFormJson(data);
    }
  }

  T generateFormJson<T>(data) {
    switch (T.toString()) {
      case 'String':
        return json.encode(data) as T;
      case 'Map<String, dynamic>':
        return data as T;
      default:
        return null;
    }
  }

  T generateListFormJson<T>(List<dynamic> mapList) {
    switch (T.toString()) {
      case 'List':
      case 'List<dynamic>':
        return mapList.map((data) => data).toList() as T;
      case 'List<String>':
        return mapList.map((data) => data as String).toList() as T;
      case 'List<int>':
        return mapList.map((data) => data as int).toList() as T;
      case 'List<bool>':
        return mapList.map((data) => data as bool).toList() as T;
      case 'List<double>':
        return mapList.map((data) => data as double).toList() as T;
      default:
        return [] as T;
    }
  }
}
