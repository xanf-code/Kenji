class InsiderNewsModel {
  List<Data> data;

  InsiderNewsModel({this.data});

  InsiderNewsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Data {
  String id;
  String type;
  Attributes attributes;
  Links links;

  Data({this.id, this.type, this.attributes, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    type = json['type'] as String;
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'] as Map<String, dynamic>)
        : null;
    if (json['links'] != null) {
      links = Links.fromJson(json['links'] as Map<String, dynamic>);
    } else {
      links = null;
    }
  }
}

class Attributes {
  String publishOn;
  String title;

  Attributes({this.publishOn, this.title});

  Attributes.fromJson(Map<String, dynamic> json) {
    publishOn = json['publishOn'] as String;
    title = json['title'] as String;
  }
}

class Links {
  String self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] as String;
  }
}
