import 'package:flutter/foundation.dart' as found;
import 'package:r_logger/r_logger.dart';
const logger = Logger();
//日志工具
class Logger {
  const Logger();

  final bool inProduction = const bool.fromEnvironment("dart.vm.product");

  void print(String content) => found.debugPrint(content);

  RLogger get _log{
   if(RLogger.instance==null){
     RLogger.initLogger(tag: 'Logger',fileName: '',filePath: '',isWriteFile: false);
   }
    return RLogger.instance;
  }

  void d(String content) {
    if (!inProduction) _log.d(content);
  }

  void j(String content) {
    if (!inProduction) _log.j(content);
  }

  void e(String message, Object error, StackTrace stackTrace,) {
    if (!inProduction) _log.e(message,error,stackTrace);
  }

}
