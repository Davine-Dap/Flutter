import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_3/core/item_type_repository.dart';
import 'package:flutter_3/presentation/add_item_type/cubit/add_item_cubit.dart';

class AddItemTypePage extends StatefulWidget {
  const AddItemTypePage({super.key});

  @override
  State<AddItemTypePage> createState() => _AddItemTypePageState();
}

class _AddItemTypePageState extends State<AddItemTypePage> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add item type")),
      body: BlocProvider(
        create:
            (context) => AddItemCubit(itemTypeRepository: ItemTypeRepository()),
        child: BlocConsumer<AddItemCubit, AddItemState>(
          listener: (context, state) {
            if (state is AddItemSuccess) {
              final snackBar = SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            }
            if (state is AddItemError) {
              final snackBar = SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is AddItemLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: codeController,
                    decoration: const InputDecoration(label: Text("Code")),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(label: Text("Name")),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(label: Text("Status")),
                    items:
                        [
                          {"value": "Active", "label": "Active"},
                          {"value": "Non-Active", "label": "Non-Active"},
                        ].map((e) {
                          return DropdownMenuItem(
                            value: e['value'],
                            child: Text(e['label']!),
                          );
                        }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        selectedStatus = val;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final code = codeController.text;
                      final name = nameController.text;

                      if (code.isEmpty ||
                          name.isEmpty ||
                          selectedStatus == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Semua field harus diisi"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      context.read<AddItemCubit>().submit(
                        code,
                        name,
                        selectedStatus!,
                      );
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
