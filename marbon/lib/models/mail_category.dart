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
    if (json["removableMailList"] != null) {
      mails = <Mails>[];
      json["removableMailList"].forEach((v) {
        mails!.add(Mails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (mails != null) {
      data["removableMailList"] = mails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mails {
  int? id;
  int? msgNum;
  int? msgId;
  String? sender;
  String? subject;
  String? contents;
  String? tag;
  String? recivedDate;
  bool isChecked = false;

  //       "attachmentSize": 0,
  //       "attachments": [],

  Mails(
      {required this.id,
      this.msgNum,
      this.msgId,
      this.sender,
      this.subject,
      this.contents,
      this.tag,
      this.recivedDate,
      this.isChecked = true});

  Mails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msgNum = json['mgsNum'];
    msgId = json['msgId'];
    sender = json['sender'];
    subject = json['subject'];
    contents = json['contents'];
    tag = json['tag'];
    recivedDate = json['recivedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mgsNum'] = msgNum;
    data['msgId'] = msgId;
    data['author'] = sender;
    data['subject'] = subject;
    data['contents'] = contents;
    data['tag'] = tag;
    data['recivedDate'] = recivedDate;
    return data;
  }
}
