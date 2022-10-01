import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 1)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String date;

  HistoryModel(
    this.date,
  );

  @override
  String toString() {
    return date;
  }
}
