class MailCategory {
  String? category;
  int? mailamount;
  List<Mails>? mails;
  bool isExpanded = false;

  MailCategory(
      {this.category, this.mailamount, this.mails, this.isExpanded = false});

  MailCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    mailamount = json['mailamount'];
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
    data['mailamount'] = mailamount;
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

  Mails({required this.id, this.author, this.title, this.content});

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
