import 'dart:io';

import 'package:cat/bloc/cat_bloc.dart';
import 'package:cat/bloc/cat_event.dart';
import 'package:cat/bloc/cat_state.dart';
import 'package:cat/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Center(child: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatInitial) {
            return const Text("Hold on!");
          } else if (state is LoadingCatState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 25),
                Text("Loading"),
              ],
            );
          } else if (state is LoadedCatState) {
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        child: Image.memory(state.cat.payload),
                      ),
                      const SizedBox(height: 25),
                      Text("Updated ${dateFormat.format(state.cat.from)}"),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<CatBloc>().add(RefreshCatEvent());
                            },
                            child: const Text("Reload Image"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HistoryScreen(
                                        dates: state.dates,
                                      )));
                            },
                            child: const Text("Go to history page"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is FailedCatState) {
            return Text(state.error);
          }
          return const Text("Unknown");
        },
      )),
    );
  }
}
