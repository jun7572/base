library base_plugin.common;


import 'package:base/data_base.dart';

import 'base_presenter.dart';
import 'dialog_manager.dart';
import 'entity_generator.dart';
import 'http_manager.dart';
import 'page_manager.dart';


class BaseConfig {
  //数据缓存
  static DataBase dataBase = DefaultDataBase();
//
//  //实体类格式化
  static EntityBase entityBase = DefaultEntityBase();

  //网络请求
  static HttpManager httpBase = DefaultHttpManager.initHttpManager(
//    baseUrl: 'http://47.103.219.158:31103/api/v1',
//    imageUrl: 'http://47.103.219.158:31103',
//    ossUrl: 'http://47.103.219.158:31103',
//    baseUrl: 'http://172.16.10.39:8086/api/v1',
//    imageUrl: 'http://172.16.10.39:8086/',
//    ossUrl: 'http://172.16.10.39:8086/',

//    baseUrl: 'http://172.16.10.36:10093/api/v1',
//    imageUrl: 'http://172.16.10.36:10093',
//    ossUrl: 'http://172.16.10.36:10093',

    baseUrl: 'http://172.16.10.52:8086/api/v1',
    imageUrl: 'http://172.16.10.52:8086',
    ossUrl: 'http://172.16.10.52:8086',
    isDebug: true,
  );

  //对话框
  static DialogManager dialogBase = DefaultDialogManager();

  //页面
  static PageManager pageBase = DefaultPageManager();

  //presenter配置
  static PresenterBase presenterBase = DefaultPresenterBase();
}
