import 'package:newz/util/rawResponse.dart';

class Regions {
  String? code;
  String? country;

  Regions({this.code, this.country});

  Regions.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['country'] = this.country;
    return data;
  }
}

final List<Regions> regionList =
    regionsRaw.map<Regions>((e) => Regions.fromJson(e)).toList();

final Map<String, Regions> regionMap = {
  for (var v in regionsRaw) v['code']: Regions.fromJson(v)
};
