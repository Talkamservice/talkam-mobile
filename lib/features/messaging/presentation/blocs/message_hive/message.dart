import 'package:hive_ce/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.timestamp,
  });
}
