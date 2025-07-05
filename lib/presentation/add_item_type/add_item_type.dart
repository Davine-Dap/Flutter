import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class AddItemState {}

class AddItemInitial extends AddItemState {}

class AddItemSuccess extends AddItemState {
  final String message;
  AddItemSuccess(this.message);
}

class AddItemError extends AddItemState {
  final String message;
  AddItemError(this.message);
}

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());
  void submit(String code, String name, String status) {}
}

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
      appBar: AppBar(title: Text("Add item type")),
      body: BlocProvider(
        create: (context) => AddItemCubit(),
        child: BlocConsumer<AddItemCubit, AddItemState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(label: Text("Code")),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(label: Text("Name")),
                ),
                DropdownButtonFormField(
                  items:
                      [
                        {"value": "Active", "label": "Active"},
                        {"value": "Non-Active", "label": "Non-Active"},
                      ].map((e) {
                        return DropdownMenuItem(
                          child: Text(e['label']!),
                          value: e['value'],
                        );
                      }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      selectedStatus = val!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final code = codeController.text;
                    final name = nameController.text;
                    debugPrint(code);
                    debugPrint(name);
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
                  child: Text("Simpan"),
                ),
              ],
            );
          },
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
        ),
      ),
    );
  }
}
