import 'package:base/base_presenter.dart';
import 'package:base/test/presenter/Testpresenter.dart';
import 'package:base/test/test_entity.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget{
  final String id;
  TestPage(this.id,this.iid);
  final int iid;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPageState();
  }
  
}
class TestPageState extends State<TestPage> with BasePresenter<TestPage,TestEntity>, TestPresenter{
  @override
  // TODO: implement buildWidget
  Widget get buildWidget =>Scaffold(
    appBar: AppBar(),
    body: Column(
      children: <Widget>[
        Text(widget.id),
        Text(widget.iid.toString()),
        GestureDetector(
          onTap: (){

          },
        ),
      ],
    ),
  );

}