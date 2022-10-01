import 'package:cat/bloc/cat_bloc.dart';
import 'package:cat/bloc/cat_event.dart';
import 'package:cat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const Cat());
}

class Cat extends StatelessWidget {
  const Cat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CatBloc()
              ..add(
                OpenAppEvent(),
              )
              ..add(
                RequestCatEvent(),
              ),
          )
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
