 import 'package:base/base_presenter.dart';
import 'package:base/test/test_entity.dart';
import 'package:base/test/test_page.dart';

mixin TestPresenter on BasePresenter<TestPage,TestEntity>{
  @override
  // TODO: implement dataFuture
  Future get dataFuture =>null;
}