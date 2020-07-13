import 'package:base/generated/json/base/json_convert_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestEntity with JsonConvert<TestEntity>,ChangeNotifier{
	String aa;
	int name;
	void setName(String aa){
		this.aa=aa;
		notifyListeners();
	}
}
