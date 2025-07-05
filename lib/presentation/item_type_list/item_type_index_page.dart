import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_3/presentation/add_item_type/add_item_type.dart';
import 'package:flutter_3/data/model/item_type.dart';
import 'package:flutter_3/presentation/item_type_list/cubit/item_type_index_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocBuilder<ItemTypeIndexCubit, ItemTypeIndexState>(
        builder: (context, state) {
          if (state is ItemTypeIndexLoaded) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.itemTypes.length,
                itemBuilder: (context, index) {
                  ItemType itemType = state.itemTypes[index];
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(itemType.name),
                        Text(itemType.toString()),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is ItemTypeIndexError) {
            return Text(state.message);
          }
          if (state is ItemTypeIndexLoading) {
            return const CircularProgressIndicator();
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemTypePage()),
          );
          context.read<ItemTypeIndexCubit>().index();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
