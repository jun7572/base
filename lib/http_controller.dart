import 'package:base/common.dart';
import 'package:flutter/services.dart';

//这里添加请求接口
import 'dart:io';

import 'package:dio/dio.dart';


class HttpController {
  static int rows = 10;

  ///  获取绘本第一级分类及三级分类
  static Future<Response> getCartoonBookCategoryList({String categoryId}) {
    Map<String, dynamic> params = {};

    if (categoryId != null) params["p_id"] = categoryId;
    return BaseConfig.httpBase.get("/school_app_painted_category/list", params);
  }
//
//  /// 获取第二级绘本列表
//  static Future<Response> getSecondClassCartoonBookList(String categoryId) {
//    Map<String, dynamic> params = {"p_id": categoryId};
//    return BaseConfig.httpBase.get("/school_app_painted/list", params);
//  }
//
//  /// 获取第四级绘本列表
//  static Future<Response> getCartoonBookVideoMoreList(int page,
//      {String categoryId, String parentId}) {
//    Map<String, dynamic> params = {"page": page, "rows": rows};
//    params["category_id"] = categoryId;
//    params["p_id"] = parentId;
//
//    return BaseConfig.httpBase.get("/school_app_painted/page", params);
//  }
//
//  static Future<Response> getAppIndex({bool user_type}) {
//    Map<String, dynamic> params = {};
//    if (user_type != null) params['user_type'] = user_type ? 1 : 2;
//
//    return BaseConfig.httpBase.get("/school_app_skip_login/app_index", params);
//  }
//
//  static Future<Response> getAuthCode(String username) async {
//    return BaseConfig.httpBase
//        .postJson("/school_app_skip_login/sendAuthCode", {"mobile": username});
//  }
//
//  //密码登录
//  static Future<Response> passwordLogin(
//      {String username,
//      String password,
//      double lat,
//      double lon,
//      String city,
//      String province,
//      String address,
//      int is_erp_stu}) async {
//    return BaseConfig.httpBase
//        .postJson("/school_app_skip_login/mobile_pwd_login", {
//      "mobile": username,
//      "password": password,
//      "produce": Platform.isIOS ? 1 : Platform.isAndroid ? 2 : 0,
//      "produce_version": (await PackageInfo.fromPlatform())?.version,
//      "device": await Utils.getDeviceName(),
//      "os": await Utils.getDeviceOS(),
//      "lat": lat,
//      "lon": lon,
//      "city": city,
//      "province": province,
//      "addr": address,
//      'is_erp_stu': is_erp_stu,
//    });
//  }
//
//  static Future<Response> login(
//      {String username,
//      String code,
//      double lat,
//      double lon,
//      String city,
//      String province,
//      String address,
//      int is_erp_stu}) async {
//    return BaseConfig.httpBase.postJson("/school_app_skip_login/mobile_login", {
//      "mobile": username,
//      "authCode": code,
//      "produce": Platform.isIOS ? 1 : Platform.isAndroid ? 2 : 0,
//      "produce_version": (await PackageInfo.fromPlatform())?.version,
//      "device": await Utils.getDeviceName(),
//      "os": await Utils.getDeviceOS(),
//      "lat": lat,
//      "lon": lon,
//      "city": city,
//      "province": province,
//      "addr": address,
//      'is_erp_stu': is_erp_stu,
//    });
//  }
//
//  static Future<Response> wechatLogin(
//      {String authCode,
//      double lat,
//      double lon,
//      String city,
//      String province,
//      String address}) async {
//    return BaseConfig.httpBase.postJson("/school_app_skip_login/wechat_login", {
//      "code": authCode,
//      "produce": Platform.isIOS ? 1 : Platform.isAndroid ? 2 : 0,
//      "produce_version": (await PackageInfo.fromPlatform())?.version,
//      "device": await Utils.getDeviceName(),
//      "os": await Utils.getDeviceOS(),
//      "lat": lat,
//      "lon": lon,
//      "city": city,
//      "province": province,
//      "addr": address,
//    });
//  }
//
//  // 绑定手机号码
//  static Future<Response> bindPhoneNumber(
//      String phone, String authCode, String bindToken) async {
//    return BaseConfig.httpBase.postJsonWithToken(
//        "/school_app_user/bind_mobile",
//        {
//          "Mobile": phone,
//          "AuthCode": authCode,
//          "device": await Utils.getDeviceInfo()
//        },
//        bindToken);
//  }
//
//  static Future<Response> getUserInfo() async {
//    return BaseConfig.httpBase.get("/school_app_user/get", {});
//  }
//
//  static Future<Response> updateUserAvatar(File file) async {
//    return BaseConfig.httpBase.postForm(
//        "/system_app_attachment/upload_attachment", {
//      "type": "image:avatar",
//      "file": await MultipartFile.fromFile(file.path)
//    });
//  }
//
//  //上传作业文件
//  static Future<Response> uploadHomework(File file) async {
//    return BaseConfig.httpBase.postForm(
//        "/system_app_attachment/upload_attachment", {
//      "type": "file:erp_stu",
//      "file": await MultipartFile.fromFile(file.path)
//    });
//  }
//
//  static Future<Response> updateUserInfo(
//      {String avatarUrl, int sex, String nickName, int birthday}) async {
//    return BaseConfig.httpBase.postJson("/school_app_user/update", {
//      "avatar": avatarUrl,
//      "sex": sex,
//      "nickname": nickName,
//      "birthday": birthday
//    });
//  }
//
//  static Future<Response> networkTest() async {
//    return Dio().get("https://www.baidu.com/");
//  }
//
//  static Future<Response> getLearnParkIndex() async {
//    return BaseConfig.httpBase.get("/school_app_index/learning_park", null);
//  }
//
//  static Future<Response> getNotInLearnParkIndex() async {
//    return BaseConfig.httpBase
//        .get("/school_app_skip_login/learning_park", null);
//  }
//
//  static Future<Response> getCartoonBook(String id) async {
//    return BaseConfig.httpBase.get("/school_app_painted/get", {"id": id});
//  }
//
//  static Future<Response> getIsCollect(String id) async {
//    if (imStore.isLogin)
//      return BaseConfig.httpBase
//          .get("/school_app_collect/has", {"collect_id": id});
//    else
//      return Response(data: {
//        "code": 0,
//      });
//  }
//
//  static Future<Response> getIsCollectCategory(String id) async {
//    return BaseConfig.httpBase
//        .get("/school_app_collect_category/has", {"collect_id": id});
//  }
//
//  static Future<Response> getFileHead(String downloadUrl) {
//    return BaseConfig.httpBase.head(downloadUrl);
//  }
//
//  static Future<Response> downloadCartoonBook(
//      String downloadUrl, String filePath,
//      {ProgressCallback progressCallback}) async {
//    return BaseConfig.httpBase
//        .download(downloadUrl, filePath, onReceiveProgress: progressCallback);
//  }
//
//  static Future<Response> updateCartoonStep(String bookId, String schedule) {
//    return BaseConfig.httpBase.postJson("/school_app_painted_schedule/add",
//        {"painted_id": bookId, "schedule": schedule});
//  }
//
//  static Future<Response> getCartoonStep(String bookId) {
//    return BaseConfig.httpBase
//        .get("/school_app_painted_schedule/get", {"painted_id": bookId});
//  }
//
//  static Future<Response> uploadCartoonRecordAttachment(File file) async {
//    return BaseConfig.httpBase.postForm(
//        "/system_app_attachment/upload_attachment", {
//      "type": "voice:painted",
//      "file": await MultipartFile.fromFile(file.path)
//    });
//  }
//
//  ///添加绘本配音
//  static Future<Response> updateCartoonRecord(
//      String bookId,
//      String fileUrl,
//      String score,
//      num averageScore,
//      num highestScore,
//      num lowestScore,
//      num accuracyScore,
//      num fluencyScore,
//      num integrityScore,
//      {String materialId,
//      String activityId}) async {
//    return BaseConfig.httpBase.postJson(
////        "/school_app_painted_voice/${ActivityDetailCalendarPresenter.isFinish ? 'update' : 'add'}",
//        "/school_app_painted_voice/add",
//        {
//          "painted_id": bookId,
//          "voice": fileUrl,
//          "score": score,
//          "average_score": averageScore,
//          "highest_score": highestScore,
//          "lowest_score": lowestScore,
//          "score_fluency": fluencyScore,
//          "score_integrity": integrityScore,
//          "score_accuracy": accuracyScore,
//          if (materialId != null) ...{
//            "material_id": materialId,
//          },
//          if (activityId != null) ...{
//            "activity_id": activityId,
//          },
//          "state": 4,
//        });
//  }
//
//  static Future<Response> getCartoonRecordUrl(String bookId) async {
//    return BaseConfig.httpBase
//        .get("/school_painted_voice/list", {"painted_id": bookId});
//  }
//
//  // type 收藏类型 1.配音 2.绘本 3.儿歌 4.动画
//  // rawType 收藏类型 0. 音频 1. 视频
//  static Future<Response> addCollect(CollectType type, String collectId,
//      {int rawType}) async {
//    Map<String, dynamic> params = {
//      "collect_id": collectId,
//      "type": type.index + 1
//    };
//    if (rawType != null) params['raw_type'] = rawType;
//    return BaseConfig.httpBase.postJson("/school_app_collect/add", params);
//  }
//
//  // type 收藏分类类型 1.配音 2.绘本 3.儿歌 4.动画
//  static Future<Response> addCollectCategory(
//      CollectType type, String collectCategoryId) async {
//    return BaseConfig.httpBase.postJson("/school_app_collect_category/add",
//        {"collect_id": collectCategoryId, "type": type.index + 1});
//  }
//
//  static Future<Response> cancelCollect(List<Map> collectId) async {
//    return BaseConfig.httpBase
//        .postObject("/school_app_collect/cancel", collectId);
//  }
//
//  static Future<Response> cancelCategoryCollect(List<Map> collectId) async {
//    return BaseConfig.httpBase
//        .postObject("/school_app_collect_category/cancel", collectId);
//  }
//
//  static Future<Response> getCollect(CollectType type, [int page]) {
//    Map<String, dynamic> params = {'type': type.index + 1};
//
//    if (page != null) params['page'] = page;
//
//    return BaseConfig.httpBase.get('/school_app_collect/page', params);
//  }
//
//  static Future<Response> getCollectCategory(CollectType type) {
//    return BaseConfig.httpBase
//        .get('/school_app_collect_category/page', {'type': type.index + 1});
//  }
//
//  ///  获取动画第一级分类
//  static Future<Response> getCartoonCategoryList({String categoryId}) {
//    Map<String, dynamic> params = {};
//    if (categoryId != null) params["p_id"] = categoryId;
//    return BaseConfig.httpBase.get("/school_app_cartoon_category/list", params);
//  }
//
//  /// 获取第二级动画列表
//  static Future<Response> getSecondClassCartoonVideoList(String categoryId) {
//    Map<String, dynamic> params = {"p_id": categoryId, "size": 4};
//    return BaseConfig.httpBase.get("/school_app_cartoon/list", params);
//  }
//
//  // 第三层查询 display=0为目录 display=1为文件
//  static Future<Response> getThirdCartoonVideo(
//      {String parentId, int display, int page, int rows}) {
//    Map<String, dynamic> params = {
//      "p_id": parentId,
//      "display": display,
//      "page": page,
//      "rows": rows ?? HttpController.rows
//    };
//    return BaseConfig.httpBase.get("/school_app_cartoon_category/more", params);
//  }
//
//  /// 获取动画视频剧集
//  static Future<Response> getCartoonVideo(String id) {
//    return BaseConfig.httpBase.get("/school_app_cartoon/more",
//        {"page": 1, "rows": 1000, "category_id": id});
//  }
//
//  /// 获取歌曲第一级分类
//  static Future<Response> getSongCategoryList({String categoryId}) {
//    Map<String, dynamic> params = {};
//    if (categoryId != null) params["p_id"] = categoryId;
//    return BaseConfig.httpBase.get("/school_app_song_category/list", params);
//  }
//
//  /// 获取歌曲二级分类名称
//  static Future<Response> getSecondClassSongList(String categoryId) {
//    Map<String, dynamic> params = {"p_id": categoryId};
//    return BaseConfig.httpBase.get("/school_app_song/list", params);
//  }
//
//  // 第三层查询 display=0为目录 display=1为文件
//  static Future<Response> getThirdSongList(
//      {String parentId, int display, int page, int rows, int type}) {
//    Map<String, dynamic> params = {
//      "p_id": parentId,
//      "display": display,
//      "page": page,
//      "rows": rows ?? HttpController.rows,
//      "type": type
//    };
//    return BaseConfig.httpBase.get("/school_app_song_category/more", params);
//  }
//
//  /// 获取歌曲专辑下的歌曲
//  static Future<Response> getSongs(String categoryId, int type) {
//    return BaseConfig.httpBase.get("/school_app_song/more",
//        {"page": 1, "rows": 1000, "category_id": categoryId, "type": type});
//  }
//
//  /// 获取歌曲专辑的信息
//  static Future<Response> getSongCategoryDetail(String categoryId) {
//    return BaseConfig.httpBase
//        .get("/school_app_song_category/get", {"id": categoryId});
//  }
//
//  /// 获取歌曲是否收藏（同时计数功能）
//  static Future<Response> getSong(String songId) {
//    return BaseConfig.httpBase.get("/school_app_song/get", {"id": songId});
//  }
//
//  /// 统计单个视频播放数 //2020-4-28 可以获取视频信息
//  static Future<Response> updateVideoStatistics(String id) {
//    return BaseConfig.httpBase.get("/school_app_cartoon/get", {"id": id});
//  }
//
//  ///  获取配音第一级分类及三级分类
//  static Future<Response> getDubbingCategoryList({String categoryId}) {
//    Map<String, dynamic> params = {};
//    if (categoryId != null) params["p_id"] = categoryId;
//    return BaseConfig.httpBase.get("/school_app_video_category/list", params);
//  }
//
//  /// 获取第二级配音列表
//  static Future<Response> getSecondClassDubbingVideoList(String categoryId,
//      {int type = 0, int ageGroup}) {
//    Map<String, dynamic> params = {
//      "p_id": categoryId,
//      "type": type,
//    };
//    if (ageGroup != 1) {
//      params['age_group'] = ageGroup - 1;
//    }
//    return BaseConfig.httpBase.get("/school_app_video/list", params);
//  }
//
//  /// 获取第四级配音列表
//  static Future<Response> getDubbingVideoMoreList(int page,
//      {String categoryId, String parentId, int type = 0}) {
//    Map<String, dynamic> params = {"page": page, "rows": rows};
//    params["category_id"] = categoryId;
//    params["p_id"] = parentId;
//    params["type"] = type;
//
//    return BaseConfig.httpBase.get("/school_app_video/page", params);
//  }
//
//  /// 获取show一级分类
//  static Future<Response> getDubbingShowCategoryList({String categoryId}) {
//    Map<String, dynamic> params = {};
//    if (categoryId != null) params["p_id"] = categoryId;
//    return BaseConfig.httpBase.get("/school_app_dub_category/list", params);
//  }
//
//  /// 获取配音详情
//  static Future<Response> getDubbingVideo(String videoId) {
//    return BaseConfig.httpBase.get("/school_app_video/detail", {"id": videoId});
//  }
//
//  //我的作品，配音
//  static Future<Response> getOpusDubbing(int type, [int page]) {
//    Map<String, dynamic> map = {
//      "type": type,
//      'rows': rows,
//    };
//
//    if (page != null) map['page'] = page;
//
//    return BaseConfig.httpBase.get("/school_app_works/page", map);
//  }
//
//  /// 获取用户配音详情
//  static Future<Response> getUserDubbing(String voiceId) {
//    return BaseConfig.httpBase.get("/school_app_voice/detail", {"id": voiceId});
//  }
//
//  /// 获取回复数据列表
//  static Future<Response> getUserDubbingReply(String voiceId, int page) {
//    return BaseConfig.httpBase.get("/school_app_voice/comment",
//        {"voice_id": voiceId, "page": page, "rows": rows});
//  }
//
//  /// 获取更多回复列表
//  static Future<Response> getUserDubbingReplyMore(
//      String voiceId, String parentId, int page) {
//    return BaseConfig.httpBase.get("/school_app_voice/comment_more", {
//      "voice_id": voiceId,
//      "parent_id": parentId,
//      "page": page,
//      "rows": rows
//    });
//  }
//
//  /// 获取楼主回复详情
//  static Future<Response> getUserDubbingReplyDetail(String hostId) {
//    return BaseConfig.httpBase
//        .get("/school_app_voice/comment_get", {"id": hostId});
//  }
//
//  /// 回复配音视频
//  static Future<Response> addVideoComment(String voiceId, String content,
//      {String parentId, String path}) {
//    Map<String, dynamic> params = Map();
//    params["voice_id"] = voiceId;
//    params["content"] = content;
//    if (parentId != null) params["parent_id"] = parentId;
//    if (path != null) params["path"] = path;
//    return BaseConfig.httpBase
//        .postJson("/school_app_voice/comment_add", params);
//  }
//
//  /// 点赞用户配音
//  static Future<Response> praiseUserDubbing(String voiceId) {
//    return BaseConfig.httpBase
//        .get("/school_app_voice_praise/praise", {"id": voiceId});
//  }
//
//  /// 是否点赞用户配音
//  static Future<Response> hasPraiseUserDubbing(String voiceId) {
//    return BaseConfig.httpBase
//        .get("/school_app_voice_praise/has", {"id": voiceId});
//  }
//
//  /// 获取配音视频素材详情
//  static Future<Response> getDubbingVideoDetail(String videoId) {
//    return BaseConfig.httpBase.get("/school_app_video/get", {"id": videoId});
//  }
//
//  /// 上传配音视频
//  static Future<Response> uploadDubbingVideoAttachment(
//      File file, ProgressCallback onProgressCallBack) async {
//    return BaseConfig.httpBase.postForm(
//        "/system_app_attachment/upload_attachment",
//        {
//          "type": "voice:video",
//          "file": await MultipartFile.fromFile(file.path)
//        },
//        onSendProgress: onProgressCallBack);
//  }
//
//  /// 添加配音视频
//  static Future<Response> addUserDubbingVideo(
//      String videoId,
//      String voice,
//      String score,
//      int averageScore,
//      int highestScore,
//      int lowestScore,
//      DubbingType type,
//      int fluencyScore,
//      int integrityScore,
//      int accuracyScore,
//      {String materialId,
//      String activityId}) {
//    return BaseConfig.httpBase.postJson(
////        "/school_app_voice/${ActivityDetailCalendarPresenter.isFinish ? 'update' : 'add'}",
//        "/school_app_voice/add",
//        {
//          "video_id": videoId,
//          "voice": voice,
//          "DubbingType": type.index,
//          "score": score,
//          "average_score": averageScore,
//          "highest_score": highestScore,
//          "lowest_score": lowestScore,
//          "fluency_score": fluencyScore,
//          "integrity_score": integrityScore,
//          "accuracy_score": accuracyScore,
//          if (materialId != null) ...{
//            "material_id": materialId,
//          },
//          if (activityId != null) ...{
//            "activity_id": activityId,
//          },
//          "state": 4,
//        });
//  }
//
//  //获取配音海报下载地址
//  static Future<Response> getDubbingSharePic(String code) async {
//    return BaseConfig.httpBase
//        .get("/school_app_user/share_qrcode", {"type": 0, "id": code});
//  }
//
//  /// 获取后台设置字典
//  static Future<Response> getAppConfig() async {
//    return BaseConfig.httpBase
//        .get("/system_app_v2/get_optionset_by_code", {"code": "app_config"});
//  }
//
//  //获取我的课堂
//  static Future<Response> appClassScheduleStu({
//    int choice,
//    String time,
//    int page,
//  }) {
//    Map<String, dynamic> params = {
//      'rows': rows,
//    };
//    if (time != null) params['time'] = time;
//    if (choice != null) params['choice'] = choice;
//    if (page != null) params['page'] = page;
//    return BaseConfig.httpBase
//        .get('/school_app_class_schedule_stu/cs_page', params);
//  }
//
//  static Future<Response> appClassStuTaskList({int id, int cssId}) {
//    Map<String, dynamic> params = {};
//    if (id != null) params['cs_id'] = id;
//    if (cssId != null) params['css_id'] = cssId;
//    return BaseConfig.httpBase
//        .get('/school_app_class_schedule_stu/stu_task_list', params);
//  }
//
//  static Future<Response> appStuTaskFinish(int csId, String cstfId,
//      {List<Map<String, dynamic>> finishList, String stuFinishDesc}) {
//    Map<String, dynamic> params = {
//      'cs_id': csId.toString(),
//      'cstf_id': cstfId,
//    };
//    if (finishList != null && finishList.isNotEmpty)
//      params['file_list'] = finishList;
//    else
//      params['file_list'] = [];
//
//    if (stuFinishDesc != null) params['stu_finish_desc'] = stuFinishDesc;
//    return BaseConfig.httpBase
//        .postJson('/school_app_class_schedule_stu/stu_task_finish', params);
//  }
//
//  // 上传反馈附件
//  static Future<Response> uploadFeedbackAttachments(
//      {List<String> files}) async {
//    List<MultipartFile> multipartFiles = List();
//    for (String file in files) {
//      multipartFiles.add(await MultipartFile.fromFile(file));
//    }
//
//    return BaseConfig.httpBase
//        .postForm("/system_app_attachment/upload_attachment", {
//      "type": "image:feedback",
//      "file": multipartFiles,
//    });
//  }
//
//  // 添加反馈
//  static Future<Response> addFeedback(
//      {int type,
//      String content,
//      int accept,
//      String contact,
//      List<String> attachments}) async {
//    Map<String, dynamic> params = {
//      "type": type,
//      "Content": content,
//      "Contact": contact,
//      "Attachments": attachments,
//    };
//    if (accept != null) params["Accept"] = accept;
//
//    return BaseConfig.httpBase.postJson("/school_app_feedback/add", params);
//  }
//
//  // 具体反馈
//  static Future<Response> getFeedback({String id}) async {
//    return BaseConfig.httpBase.get("/school_app_feedback/get", {
//      "id": id,
//    });
//  }
//
//  // 历史反馈列表
//  static Future<Response> getFeedbackHistoryList(int page) {
//    return BaseConfig.httpBase
//        .get("/school_app_feedback/page", {"page": page, "rows": rows});
//  }
//
//  // 课堂评价
//  static Future<Response> schoolAppClassScheduleStuEvaluation(
//      String cs_id, String css_id, int effect, int service, String content) {
//    return BaseConfig.httpBase
//        .postJson("/school_app_class_schedule_stu/evaluation", {
//      "cs_id": cs_id,
//      "css_id": css_id,
//      "effect": effect,
//      "service": service,
//      "content": content
//    });
//  }
//
//  // 课堂评价
//  static Future<Response> getSchoolAppClassScheduleStuEvaluation(
//      String cs_id, String css_id) {
//    return BaseConfig.httpBase
//        .get("/school_app_class_schedule_stu/get_evaluation", {
//      "cs_id": cs_id,
//      "css_id": css_id,
//    });
//  }
//
//  // 课堂实录
//  static Future<Response> schoolAppClassScheduleStuStuFile(
//      {int page, String startTime, String endTime}) {
//    Map<String, dynamic> params = {
//      'rows': rows,
//    };
//    if (page != null) params['page'] = page;
//    if (startTime != null) params['start_time'] = startTime;
//    if (endTime != null) params['end_time'] = endTime;
//
//    return BaseConfig.httpBase
//        .get("/school_app_class_schedule_stu/stu_file", params);
//  }
//
//  // 课堂反馈
//  static Future<Response> getAppClassScheduleStuCsStuFeedback(
//      int csId, int cssId) {
//    return BaseConfig.httpBase.get(
//        "/school_app_class_schedule_stu/cs_stu_feedback",
//        {"cs_id": csId, "css_id": cssId});
//  }
//
//  // 获取推荐列表
//  static Future<Response> getRecommendList({int page}) {
//    return BaseConfig.httpBase.get(
//        "/school_app_class_schedule_stu/get_recommend_list",
//        {"page": page, "rows": rows});
//  }
//
//  // 添加推荐学员
//  static Future<Response> addRecommendList({String phone, String name}) {
//    return BaseConfig.httpBase.postJson(
//        "/school_app_class_schedule_stu/add_mkt_stu", {
//      "stu_name": name,
//      "stu_phone": phone,
//      "pa_id": imStore.userInfo?.paId
//    });
//  }
//
//  // 交易合同
//  static Future<Response> getAppClassScheduleStuGetOrderInfo([int page]) {
//    Map<String, dynamic> params = {
//      'row': rows,
//    };
//
//    if (page != null) params['page'] = page;
//
//    return BaseConfig.httpBase
//        .get("/school_app_class_schedule_stu/get_order_info", params);
//  }
//
//  // 消息
//  static Future<Response> schoolMessage(int choice, [int page]) {
//    Map<String, dynamic> params = {
//      'choice': choice,
//    };
//    if (page != null) params['page'] = page;
//
//    return BaseConfig.httpBase.get("/school_message/page", params);
//  }
//
//  // 获取我的剩余学时
//  static Future<Response> getLeftLearningHour() {
//    return BaseConfig.httpBase
//        .get("/school_app_class_schedule_stu/get_order_hour", {});
//  }
//
//  // 获取任务打卡
//  static Future<Response> getTaskList({String time}) {
//    Map<String, dynamic> params = {};
//    if (time != null) params['time'] = time;
//
//    return BaseConfig.httpBase
//        .get("/school_app_activity/get_activity_list", params);
//  }
//
//  // 获取活动打卡
//  static Future<Response> getActivityList({int page, int dated}) {
//    Map<String, dynamic> params = {
//      'rows': rows,
//    };
//    if (page != null) params['page'] = page;
//    if (dated != null) params['dated'] = dated;
//    return BaseConfig.httpBase
//        .get("/school_applet_myactivity/applet_get_myactivity", params);
//  }
//
//  // 获取活动列表
//  static Future<Response> getASchoolAppletList({int page, int applet}) {
//    Map<String, dynamic> params = {
//      'rows': rows,
//    };
//
//    if (page != null) params['page'] = page;
//    if (applet != null) params['applet'] = applet;
//
//    return BaseConfig.httpBase.get("/school_applet_activity/page", params);
//  }
//
//  // 获取活动列表
//  static Future<Response> getSchoolAppletActivityDetail(String id) {
//    Map<String, dynamic> params = {'id': id};
//    return BaseConfig.httpBase
//        .get("/school_applet_activity/applet_get", params);
//  }
//
//  // 获取任务打卡记录  //显示在日历上的
//  static Future<Response> getActivityRecordInfo(String year) {
//    Map<String, dynamic> params = {'year': year};
//    return BaseConfig.httpBase
//        .get("/school_app_activity/get_activity_record_info", params);
//  }
//
//  // 获取指定分类的文章
//  static Future<Response> getArticleByCategoryId(String categoryId) {
//    return BaseConfig.httpBase
//        .get("/school_app_article/get", {"category": categoryId});
//  }
//
//  //获取我的课堂实录
//  static Future<Response> getCourseVideo(String csId, String cssId) {
//    return BaseConfig.httpBase
//        .get('/school_app_class_schedule_stu/cs_stu_content_file', {
//      'cs_id': csId,
//      'css_id': cssId,
//    });
//  }
//
//  //获取活动学习日历
//  static Future<Response> getActivityCalendar(String id) {
//    return BaseConfig.httpBase.get('/school_applet_myactivity/get_calendar', {
//      'id': id,
//    });
//  }
//
//  //获取活动报名状态
//  static Future<Response> getSignUpStatus(String id) {
//    return BaseConfig.httpBase.get('/school_applet_myactivity/sign_up_status', {
//      'id': id,
//    });
//  }
//
//  //获取材料详情
//  static Future<Response> getMaterialDetail(String id) {
//    return BaseConfig.httpBase
//        .get('/school_applet_myactivity/get_material_detail', {
//      'id': id,
//    });
//  }
//
//  //获取课堂详情
//  static Future<Response> getCsDetail(int cs_id, int css_id) {
//    return BaseConfig.httpBase.get('/school_app_class_schedule_stu/cs_detail', {
//      'cs_id': cs_id,
//      'css_id': css_id,
//    });
//  }
//
//  //获取活动排行榜
//  static Future<Response> getActivityRange(String id) {
//    return BaseConfig.httpBase.get('/school_applet_ranking/page', {
//      'id': id,
//    });
//  }
//
//  //活动视频配音作品发布
//  static Future<Response> voiceAppletPushVoice(String id) {
//    return BaseConfig.httpBase.get('/school_applet_voice/push_voice', {
//      'id': id,
//    });
//  }
//
//  //任务打卡发布   //任务打卡 动画打卡也使用这个,不传voice_id
//  static Future<Response> voiceTaskPushVoice(
//      String activity_id, String material_id, String voice_id) {
//    //'/school_app_activity/push_voice?activity_id='+activity_id+"&material_id="+material_id+"&voice_id="+voice_id
//    return BaseConfig.httpBase.postJson('/school_app_activity/push_voice', {
//      'activity_id': activity_id,
//      'material_id': material_id,
//      'voice_id': voice_id
//    });
//  }
//
//  //活动绘本配音作品发布
//  static Future<Response> paintedAppletPushVoice(String id) {
//    return BaseConfig.httpBase.get('/school_applet_painted/push_voice', {
//      'id': id,
//    });
//  }
//
//  //打卡完成，查看天数
//  static Future<Response> rankingPushDetail(String id, String type) {
//    return BaseConfig.httpBase.get('/school_applet_ranking/push_detail', {
//      'id': id,
//      'type': type,
//    });
//  }
//
//  //获取积分商城首页
//  static Future<Response> getAppGiftPage({int page, int size}) {
//    return BaseConfig.httpBase.get('/school_app_mall_gift/home_page', {
//      if (page != null) ...{'page': page},
//      if (size != null) ...{'size': size},
//    });
//  }
//
//  //获取积分商城商品详情
//  static Future<Response> getAppGiftPageDetail(String id) {
//    return BaseConfig.httpBase.get('/school_app_mall_gift/gift_detail', {
//      'id': id,
//    });
//  }
//
//  //获取积分商城商品详情   sg_num:    // 数量       gift_id:    // 礼品id
//  static Future<Response> confirmOrder(
//    List<GiftPostEntity> list,
//  ) {
//    //  /school_app_mall_gift/confirm_order
//
//    var params = {"gift": list};
//
//    return BaseConfig.httpBase
//        .postObject('/school_app_mall_gift/confirm_order', params);
//  }
//
//  //获取积分商城商品详情
//  static Future<Response> getSchoolAppGiftPage(int gift_type,
//      {int page, int size}) {
//    return BaseConfig.httpBase.get('/school_app_mall_gift/page', {
//      'gift_type': gift_type,
//      if (page != null) ...{"page": page},
//      if (size != null) ...{"size": size},
//    });
//  }
//
//  static Future<Response> checkUpgrade(int type, String version) {
//    return BaseConfig.httpBase.postJson('/school_app_version/check',
//        {'app_type': type, 'version': version, 'client_type': 1});
//  }
//
//  //添加到购物车
//  static Future<Response> addShoppingCart(GiftPostEntity giftPostEntity) {
//    //  /school_shopping_cart/add
//
//    return BaseConfig.httpBase
//        .postObject('/school_shopping_cart/add', giftPostEntity.toJson());
//  }
//
//  //添加个人地址
//  static Future<Response> addPersonalAddress(AddressPersonalContent entity) {
//    //  /school_shopping_cart/add
//    var params = {
//      "recipient_name": entity.recipientName,
//      "recipient_phone": entity.recipientPhone,
//      "recipient_adress": entity.recipientAdress,
//      "recipient_region": entity.recipientRegion,
//      "is_default": entity.isDefault
//    };
//    return BaseConfig.httpBase.postObject('/school_fin_recipient/add', params);
//  }
//
//  //修改个人地址
//  static Future<Response> updatePersonalAddress(AddressPersonalContent entity) {
//    //  /school_shopping_cart/add
//    var params = {
//      "recipient_name": entity.recipientName,
//      "recipient_phone": entity.recipientPhone,
//      "recipient_adress": entity.recipientAdress,
//      "recipient_region": entity.recipientRegion,
//      "id": entity.id,
//      "is_default": entity.isDefault
//    };
//    return BaseConfig.httpBase
//        .postObject('/school_fin_recipient/update', params);
//  }
//
//  //查询所有的地址
//  static Future<Response> getPersonalAddress() {
//    //  /school_shopping_cart/add
//    var params = {"page": 1, "rows": 100};
//    return BaseConfig.httpBase.get('/school_fin_recipient/page', params);
//  }
//
//  //订单详情
//  static Future<Response> getOrderDetail(int id) {
//    //  /school_shopping_cart/add
//    var params = {"order_id": id};
//    return BaseConfig.httpBase
//        .get('/school_app_mall_gift/order_detail', params);
//  }
//
//  //获取购物车列表
//  static Future<Response> getShoppingCart() {
//    //  /school_shopping_cart/add
//    var params = {"page": 1, "rows": 100};
//    return BaseConfig.httpBase.get('/school_shopping_cart/page', params);
//  }
//
//  //改变购物车的数字
//  static Future<Response> updateShoppingCartItem(
//      String id, int num, String xh_jf) {
//    //  /school_shopping_cart/add
//    var params = {"id": id, "sg_num": num, "xh_jf": xh_jf};
//    return BaseConfig.httpBase
//        .postObject('/school_shopping_cart/update', params);
//  }
//
//  //删除购物车的一项
//  static Future<Response> deleteShoppingCartItem(String id) {
//    //  /school_shopping_cart/add
//    List<dynamic> list = [];
//    list.add({"id": id});
//    return BaseConfig.httpBase.postObject('/school_shopping_cart/delete', list);
//  }
//
//  //获取购物车列表,这后台设计的........无语
//  static Future<Response> postSelectedSHoppingCart(
//      List<String> list, String xh_jf) {
//    //  /school_shopping_cart/add
//    var params = {"gift": list, 'xh_jf': xh_jf};
//    return BaseConfig.httpBase
//        .postObject('/school_shopping_cart/empty_cart', params);
//  }
//
//  //支付接口
//  static Future<Response> integralPay(
//      String orderId, String recipientInfoId, String xh_jf) {
//    //  /school_shopping_cart/add
//    var params = {
//      "order_id": orderId,
//      "recipient_info_id": recipientInfoId,
//      "xh_jf": xh_jf
//    };
//    return BaseConfig.httpBase
//        .postJson('/school_app_mall_gift/pay_order', params);
//  }
//
////查询一个地址
//  static Future<Response> getOneAddressDetail(String id) {
//    //  /school_shopping_cart/add
//    var params = {"id": id};
//    return BaseConfig.httpBase.get('/school_fin_recipient/detail', params);
//  }
//
//  //订单列表
//  static Future<Response> getOrderList() {
//    //  /school_shopping_cart/add
//    var params = {"page": 1, "rows": 200};
//    return BaseConfig.httpBase.get('/school_app_mall_gift/order_list', params);
//  }
//
//  //积分列表
//  static Future<Response> getPointsList() {
//    //  /school_shopping_cart/add
//    var params = {"page": 1, "rows": 200};
//    return BaseConfig.httpBase.get('/school_app_mall_gift/points_list', params);
//  }
//
//  //获取指定用户积分
//  static Future<Response> getUserPoints() {
//    //  /school_shopping_cart/add
//
//    return BaseConfig.httpBase.get('/school_app_mall_gift/cur_point', {});
//  }
//
//  static Future<Response> schoolStudyRd(
//      List<Map<String, dynamic>> datas) async {
//    return BaseConfig.httpBase
//        .postJson("/school_study_rd/add", {'data': datas});
//  }
//
//  static Future<Response> getAmapSchoolLocation() async {
//    return BaseConfig.httpBase.get("/school_map/all_addr", null);
//  }
//
//  static Future<Response> changePwd(
//      String old, String new1, String new2) async {
//    return BaseConfig.httpBase.postForm("/school_app_user/change_pwd", {
//      'old': old,
//      'new1': new1,
//      'new2': new2,
//    });
//  }
//
//  static Future<Response> forgetPwd(
//      String mobile, String captcha, String new1, String new2) async {
//    return BaseConfig.httpBase.postForm("/school_app_skip_login/forget_pwd", {
//      'mobile': mobile,
//      'captcha': captcha,
//      'new1': new1,
//      'new2': new2,
//    });
//  }
//
//  // 获取online级别
//  static Future<Response> getOnlineLevel() async {
//    return BaseConfig.httpBase.get("/online_skip_login/online_ent", {});
//  }
//
//  // 获取online级别单元列表
//  static Future<Response> getOnlineLevelUtilList({String levelId}) async {
//    return BaseConfig.httpBase
//        .get("/online_skip_login/page_by_level", {"level_id": levelId});
//  }
//
//  // 获取online单元课程列表
//  static Future<Response> getOnlineUtilCourseList({String utilId}) async {
//    return BaseConfig.httpBase
//        .get("/online_course/page_by_unit", {"unit_id": utilId});
//  }
//
//  // 获取online课程详情
//  static Future<Response> getOnlineCourseDetail({String courseId}) async {
//    return BaseConfig.httpBase
//        .get("/online_course/course_with_topics", {"course_id": courseId});
//  }
//
//  // 获取online级别支付列表
//  static Future<Response> getOnlineUtilFeeList({String levelId}) async {
//    return BaseConfig.httpBase
//        .get("/online_course_unit/unit_can_buy", {"level_id": levelId});
//  }
//
//  // 请求级别购买接口
//  static Future<Response> getBuyLevel({String levelId}) async {
//    return BaseConfig.httpBase
//        .get("/online_order/create_order", {"goods_id": levelId});
//  }
//
//  // 请求购买单元接口
//  static Future<Response> getBuyUtils({List<String> utilsId}) async {
//    return BaseConfig.httpBase
//        .postJson("/online_order/create_order_for_unit", {"unit_id": utilsId});
//  }
//
//  // 添加学习记录
//  static Future<Response> postOnlineStudyLog({Map data}) async {
////    int voicePoint = onlineStatistics.recordScoreList.length == 0
////        ? 0
////        : ((onlineStatistics.recordScoreList
////                        .reduce((value, element) => value + element) *
////                    20) /
////                onlineStatistics.recordScoreList.length)
////            .round();
////    int answerPoint = onlineStatistics.correctList.length == 0
////        ? 0
////        : (onlineStatistics.correctList.where((element) => element).length *
////                100 /
////                onlineStatistics.correctList.length)
////            .round();
//
//    return BaseConfig.httpBase.postJson("/online_study_log/add_log", data);
//  }
//
//  // 判断是否购买单元
//  static Future<Response> getIsBuyUtil({String utilId}) async {
//    return BaseConfig.httpBase
//        .get("/online_course/unit_buy_state", {"unit_id": utilId});
//  }
//
//  // 创建购买单元订单
//  static Future<Response> getCreateOrder({List<String> utilsId}) async {
//    return BaseConfig.httpBase
//        .postJson("/online_order/create_order_for_unit", {"unit_id": utilsId});
//  }
//
//  // 获取订单详情
//  static Future<Response> getOrderInfo(String orderId) async {
//    return BaseConfig.httpBase.get("/online_order/get", {"order_id": orderId});
//  }
//
//  // 获取微信支付参数
//  static Future<Response> getBuyInfoByWeChat({String orderId}) async {
//    return BaseConfig.httpBase
//        .get("/online_order/order_wechat", {"order_id": orderId});
//  }
//
//  static Future<Response> getOrderHourDetail(int class_type) async {
//    Map<String, dynamic> params = {
//      "class_type": class_type,
//    };
//    return BaseConfig.httpBase.get("/school_app_class_schedule_stu/get_order_hour_detail", params);
//  }
//
//  //检查是否已经推荐过学员
//  static Future<Response> addMktStuCheck(String phone) async {
//    Map<String, dynamic> params = {
//      "phone": phone,
//    };
//    return BaseConfig.httpBase.get("/school_app_class_schedule_stu/add_mkt_stu_check", params);
//    }
//
//  //检查是否已经推荐过学员
//  static Future<Response> appCartoonCategory(String id) async {
//    Map<String, dynamic> params = {
//      "id": id,
//    };
//    return BaseConfig.httpBase.get("/school_app_cartoon_category/get",params);
//  }
//
//  //上传查可兔录音文件
//  static Future<Response> uploadOnlineRecordAttachment(File file) async {
//    return BaseConfig.httpBase.postForm(
//        "/system_app_attachment/upload_attachment", {
//      "type": "voice:topic",
//      "file": await MultipartFile.fromFile(file.path)
//    });
//  }
//
//  //上传查可兔录音文件
//  static Future<Response> schoolAppClassScheduleStu(int type,int page,int rows) async {
//    return BaseConfig.httpBase.get(
//        "/school_app_class_schedule_stu/cs_info_list?=1&page=1&rows=10", {
//      "type": type,
//      "page": page,
//      "rows": rows,
//    });
//  }
//
//  // 获取分享月报接口
//  static Future<Response> getOnlineMonthReport(String id) async {
//    return BaseConfig.httpBase.get("/online_course_unit/share_report", {
//      "id": id,
//    });
//  }
//
//  // 获取体验课入口页
//  static Future<Response> getOnlineExperienceEnt() async {
//    return BaseConfig.httpBase.get("/online_skip_login/online_ent_for_exper", {});
//  }
//
//  // 创建查可兔体验课订单
//  static Future<Response> getCreateExperienceOrder({List<String> cateId}) async {
//    return BaseConfig.httpBase
//        .postJson("/online_order/create_order_for_exper_by_wechat", {"cate_id": cateId});
//  }
//
//  // 我的课堂查可兔体验列表接口
//  static Future<Response> getOnlineExperienceClassList() async {
//    return BaseConfig.httpBase
//        .get("/online_exper_cate/class_list", {});
//  }
//
//  // 查可兔体验课列表
//  static Future<Response> getOnlineExperienceCourseList(String id) async {
//    return BaseConfig.httpBase
//        .get("/online_exper_course/list", {"id": id});
//  }
//
//  // 获取online体验课程详情
//  static Future<Response> getOnlineExperienceCourseDetail({String id}) async {
//    return BaseConfig.httpBase
//        .get("/online_exper_course/detail", {"id": id});
//  }
//
//
//  // 查可兔添加记录
//  static Future<Response> addOnlineExperienceLog(String id) async {
//    return BaseConfig.httpBase
//        .get("/online_study_log/add_log_for_exper", {"id": id});
//  }
//
//  // 获取学员资料里面学校的地址
//  static Future<Response> getStudentSchoolAddress(String id) async {
//    return BaseConfig.httpBase.get("/school_app_user/get_sch_info", {
//      "erp_stu_id": id,
//    });
//  }


}

enum CollectType { Dubbing, Paint, Song, video }

enum DubbingType {
  Video,
  Show,
}
