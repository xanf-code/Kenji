class CommunityModel {
  List<Messages> messages;
  Response response;

  CommunityModel({this.messages, this.response});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? Response.fromJson(json['response'] as Map<String, dynamic>)
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages.add(Messages.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Response {
  int status;

  Response({this.status});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class Messages {
  int id;
  String body;
  String createdAt;
  User user;
  URLSource source;
  List<Links> links;

  Messages(
      {this.id, this.body, this.createdAt, this.user, this.source, this.links});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    body = json['body'] as String;
    createdAt = json['created_at'] as String;
    user = json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    source = json['source'] != null
        ? URLSource.fromJson(json['source'] as Map<String, dynamic>)
        : null;
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class User {
  String username;
  String name;
  String avatarUrl;
  String avatarUrlSsl;
  String joinDate;
  bool official;
  String identity;

  User({
    this.username,
    this.name,
    this.avatarUrl,
    this.avatarUrlSsl,
    this.joinDate,
    this.identity,
    this.official,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'] as String;
    name = json['name'] as String;
    avatarUrl = json['avatar_url'] as String;
    avatarUrlSsl = json['avatar_url_ssl'] as String;
    joinDate = json['join_date'] as String;
    official = json['official'] as bool;
    identity = json['identity'] as String;
  }
}

class Source {
  int id;
  String title;
  String url;

  Source({this.id, this.title, this.url});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    url = json['url'] as String;
  }
}

class Links {
  String title;
  String url;
  String shortenedUrl;
  String shortenedExpandedUrl;
  String description;
  String image;
  String createdAt;
  String videoUrl;
  URLSource source;

  Links(
      {this.title,
      this.url,
      this.shortenedUrl,
      this.shortenedExpandedUrl,
      this.description,
      this.image,
      this.createdAt,
      this.videoUrl,
      this.source});

  Links.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    url = json['url'] as String;
    shortenedUrl = json['shortened_url'] as String;
    shortenedExpandedUrl = json['shortened_expanded_url'] as String;
    description = json['description'] as String;
    image = json['image'] as String;
    createdAt = json['created_at'] as String;
    videoUrl = json['video_url'] as String;
    source = json['source'] != null
        ? URLSource.fromJson(json['source'] as Map<String, dynamic>)
        : null;
  }
}

class URLSource {
  String name;
  String website;

  URLSource({this.name, this.website});

  URLSource.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    website = json['website'] as String;
  }
}
