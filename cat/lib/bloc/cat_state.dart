import 'package:cat/model/cat_model.dart';
import 'package:cat/model/history_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CatState {}

class CatInitial extends CatState {}

class LoadingCatState extends CatState {}

class LoadedCatState extends CatState {
  final CatModel cat;
  final List<HistoryModel> dates;
  LoadedCatState(
    this.cat,
    this.dates,
  );
}

class FailedCatState extends CatState {
  final String error;
  FailedCatState(this.error);
}
