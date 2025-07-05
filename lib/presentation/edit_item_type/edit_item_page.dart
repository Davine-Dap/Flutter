import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_3/data/model/item_type.dart';
import 'package:flutter_3/presentation/edit_item_type/cubit/edit_item_cubit.dart';

class EditItemPage extends StatefulWidget {
  final ItemType item;
  const EditItemPage({super.key, required this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late final TextEditingController codeController;
  late final TextEditingController nameController;
  late String? selectedStatus;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController(text: widget.item.code);
    nameController = TextEditingController(text: widget.item.name);
    selectedStatus = widget.item.status;
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item")),
      body: BlocProvider(
        create: (context) => EditItemCubit(),
        child: BlocConsumer<EditItemCubit, EditItemState>(
          listener: (context, state) {
            if (state is EditingItemSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop(true);
            }
            if (state is EditingItemError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is EditItemLoading;

            return AbsorbPointer(
              absorbing: isLoading,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            labelText: "Code",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedStatus,
                          decoration: const InputDecoration(
                            labelText: "Status",
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Active",
                              child: Text("Active"),
                            ),
                            DropdownMenuItem(
                              value: "Non-Active",
                              child: Text("Non-Active"),
                            ),
                          ],
                          onChanged:
                              (val) => setState(() => selectedStatus = val),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
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
                            context.read<EditItemCubit>().update(
                              widget.item.id,
                              code,
                              name,
                              selectedStatus!,
                            );
                          },
                          child: const Text("Update"),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()),
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
