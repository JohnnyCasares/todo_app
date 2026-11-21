import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/utils/form_value.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/bloc/create_todo_entry_cubit.dart';

class CreateTodoEntryPageProvider extends StatelessWidget {
  const CreateTodoEntryPageProvider({super.key, required this.collectionId});
  final CollectionId collectionId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryCubit>(
      create: (context) => CreateTodoEntryCubit(
        collectionId: collectionId,
        addToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateToDoEntryPage(),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    routeName: 'create_todo_entry',
    child: Placeholder(),
  );

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'description'),
              validator: (value) {
                final currentValidationState =
                    context
                        .read<CreateTodoEntryCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.pending;

                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'This field needs at least two characters to be valid';
                  case ValidationStatus.success:
                  case ValidationStatus.pending:
                    return null;
                }
              },
              onChanged: (value) => context
                  .read<CreateTodoEntryCubit>()
                  .descriptionChanged(description: value),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final isValid = _formKey.currentState?.validate();
                if (isValid != true) return;

                final saved = await context
                    .read<CreateTodoEntryCubit>()
                    .submit();
                if (!context.mounted) return;

                if (saved) {
                  // `true` tells the detail page a new entry was created.
                  context.pop(true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not save the entry, try again'),
                    ),
                  );
                }
              },
              child: Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
