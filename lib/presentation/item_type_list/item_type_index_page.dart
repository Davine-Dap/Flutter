import 'package:flutter/material.dart';
import 'package:flutter_3/presentation/edit_item_type/edit_item_page.dart';
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
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.itemTypes.length,
                itemBuilder: (context, index) {
                  ItemType itemType = state.itemTypes[index];
                  return Card(
                    child: ListTile(
                      title: Text(itemType.name),
                      subtitle: Text(itemType.status ?? 'N/A'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditItemPage(item: itemType),
                                ),
                              );
                              context.read<ItemTypeIndexCubit>().index();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      ),
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
        tooltip: 'Tambah Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
