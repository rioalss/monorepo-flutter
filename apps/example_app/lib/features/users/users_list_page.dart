import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/core_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.usersTitle)),
      body: BlocBuilder<UsersListBloc, UsersListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (page) {
              if (page.items.isEmpty) {
                return Center(child: Text(l10n.usersEmpty));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: page.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = page.items[index];
                  return ListTile(
                    title: Text(user.displayName),
                    subtitle: Text(user.email ?? user.id),
                  );
                },
              );
            },
            failure: (message, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context
                        .read<UsersListBloc>()
                        .add(const UsersListRequested()),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
