import 'package:flutter/material.dart';

@immutable
abstract class CatEvent {}

class RequestCatEvent extends CatEvent {}

class RefreshCatEvent extends CatEvent {}

class OpenAppEvent extends CatEvent {}
