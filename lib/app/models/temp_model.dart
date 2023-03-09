class TempMessage {
  String? id;
  String? textMessage;
  String? sendeTime;

  TempMessage({this.id, this.textMessage, this.sendeTime});

  TempMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    textMessage = json['textMessage'];
    sendeTime = json['sendeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['textMessage'] = textMessage;
    data['sendeTime'] = sendeTime;
    return data;
  }
}

class TempModel {
  String? id;
  List<TempMessage?>? messages;

  TempModel({this.id, this.messages});

  TempModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['messages'] != null) {
      messages = <TempMessage>[];
      json['messages'].forEach((v) {
        messages!.add(TempMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['messages'] =
        messages != null ? messages!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
