import 'package:base/test/test_entity.dart';

testEntityFromJson(TestEntity data, Map<String, dynamic> json) {
	if (json['aa'] != null) {
		data.aa = json['aa']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toInt();
	}
	return data;
}

Map<String, dynamic> testEntityToJson(TestEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['aa'] = entity.aa;
	data['name'] = entity.name;
	return data;
}