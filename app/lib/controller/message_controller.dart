class Message{
  final String? message;

  Message.fromJson(Map<String, dynamic> json)
  : message = json["message"];

}