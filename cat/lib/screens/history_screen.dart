import 'dart:io';

import 'package:cat/bloc/cat_bloc.dart';
import 'package:cat/bloc/cat_event.dart';
import 'package:cat/bloc/cat_state.dart';
import 'package:cat/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  final List<HistoryModel> dates;
  const HistoryScreen({Key? key, required this.dates}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateFormat dateFormat = DateFormat();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd(Platform.localeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat"),
      ),
      body: ListView.builder(
        itemCount: widget.dates.length,
        itemBuilder: (context, index) {
          return Center(
            child: Text(widget.dates[index].date.split('.').first.padLeft(8)),
          );
        },
      ),
    );
  }
}
