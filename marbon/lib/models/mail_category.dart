class MailCategory {
  String? category;
  List<Mails>? mails;
  bool isExpanded = false;
  bool isChecked = false;

  MailCategory(
      {this.category,
      this.mails,
      this.isExpanded = false,
      this.isChecked = false});

  MailCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['mails'] != null) {
      mails = <Mails>[];
      json['mails'].forEach((v) {
        mails!.add(Mails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (mails != null) {
      data['mails'] = mails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mails {
  int? id;
  String? author;
  String? title;
  String? content;
  bool isChecked = false;

  Mails(
      {required this.id,
      this.author,
      this.title,
      this.content,
      this.isChecked = true});

  Mails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}
