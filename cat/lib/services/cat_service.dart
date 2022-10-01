import 'dart:typed_data';
import 'package:cat/model/cat_model.dart';
import 'package:cat/model/history_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CatService {
  late Box<HistoryModel> _history;

  Future<void> init() async {
    Hive.registerAdapter(HistoryModelAdapter());
    _history = await Hive.openBox<HistoryModel>('date');
    print(1);
    await _history.clear();
    //
    // await _tasks.add(Task('testuser1', 'Subscribe to Flutter From Scratch', true));
    // await _tasks.add(Task('flutterfromscratch', 'Comment on the video', false));
  }

  void addDate(final String date) {
    print(2);
    _history.add(HistoryModel(date));
  }

  List<HistoryModel> getDates() {
    final tasks = _history.values.toList();
    print(tasks);
    return tasks;
  }

  Future<CatModel> fetchCat() async {
    final date = DateTime.now();
    final url = "https://cataas.com/cat?${date.millisecondsSinceEpoch}";
    final response = await http.read(Uri.parse(url));
    return CatModel(Uint8List.fromList(response.codeUnits), date);
  }
}
