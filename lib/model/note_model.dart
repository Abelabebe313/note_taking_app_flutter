class NoteModel {
  String id;
  String title;
  String content;
  String createdAt;
  String updatedAt;
  String tag;
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.tag,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'tag': tag,
    };
  }
}
