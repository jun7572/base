import 'package:base/test/test_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

final router = Router();
var usersHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TestPage(params["id"].first,int.parse(params["iid"].first));
});
void defineRoutes() {
  //一种可以传中文
//  router.define("/test/:id", handler: usersHandler);

  router.define("/test", handler: usersHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
}
