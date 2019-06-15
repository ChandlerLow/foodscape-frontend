class Broadcast {
  Broadcast({this.hasBroadcast, this.summary, this.message});

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(
      hasBroadcast: json['has_broadcast'],
      summary: json['summary'],
      message: json['message'],
    );
  }

  final bool hasBroadcast;
  final String summary;
  final String message;
}
