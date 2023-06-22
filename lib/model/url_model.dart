class UrlModel {
  String? url;

  UrlModel({required this.url});

  factory UrlModel.fromJson(Map<String, dynamic>? json) {
    return UrlModel(url: json!['result_url']);
  }
}
