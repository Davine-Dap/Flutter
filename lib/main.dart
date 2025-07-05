import 'package:flutter/material.dart';
import 'package:flutter_3/presentation/item_type_list/cubit/item_type_index_cubit.dart';
import 'package:flutter_3/presentation/item_type_list/item_type_index_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

//Davine 233303030461 4 malam B
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ItemTypeIndexCubit(),
        child: const MyHomePage(title: "Dafter Jenis Barang"),
      ),
    );
  }
}
