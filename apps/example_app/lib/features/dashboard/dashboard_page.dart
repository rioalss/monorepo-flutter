import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/core_state.dart';
import 'package:core_ui/core_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:example_app/router/route_paths.dart';
import 'package:flutter/material.dart' hide DatePickerDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final userId = context.read<SessionCubit>().state.userIdOrNull;
    if (!mounted || userId == null || userId.isEmpty) return;
    context.read<UserDetailBloc>().add(UserDetailRequested(userId));
  }

  Future<void> _logout() async {
    await context.read<SessionCubit>().logout();
  }

  String _localeLabel(Locale? locale) {
    final appLocale =
        locale == null ? null : SupportedLocales.fromLocale(locale);
    if (appLocale == null) {
      return locale?.languageCode ?? 'system';
    }
    return SupportedLocales.displayName(appLocale);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
        actions: [
          BlocBuilder<LocaleCubit, Locale?>(
            builder: (context, locale) {
              return IconButton(
                onPressed: () => context.read<LocaleCubit>().cycle(),
                icon: const Icon(Icons.language),
                tooltip: l10n.commonLocaleTooltip(_localeLabel(locale)),
              );
            },
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              final icon = switch (mode) {
                ThemeMode.light => Icons.light_mode,
                ThemeMode.dark => Icons.dark_mode,
                ThemeMode.system => Icons.brightness_auto,
              };
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().cycle(),
                icon: Icon(icon),
                tooltip: l10n.commonThemeTooltip(mode.name),
              );
            },
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: l10n.dashboardLogout,
          ),
        ],
      ),
      body: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text(l10n.dashboardLoadingProfile)),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (user) => Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardWelcome(user.displayName),
                    style: AppTypography.fs24.semibold
                        .color(context.colorTokens.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.dashboardUserId(user.id)),
                  if (user.email != null)
                    Text(l10n.dashboardUserEmail(user.email!)),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () => context.push(RoutePaths.users),
                    icon: const Icon(Icons.people),
                    label: Text(l10n.dashboardViewAllUsers),
                  ),
                  FilledButton.icon(
                    onPressed: () async {
                      final date = await DatePickerDialog.showSingle(
                        context,
                        title: l10n.dashboardPickDate,
                        confirmLabel: l10n.commonOk,
                        cancelLabel: l10n.commonCancel,
                        initialDate: selectedDate,
                      );
                      if (!context.mounted || date == null) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.dashboardSelectedDate(
                                date.toLocal().toString()),
                          ),
                        ),
                      );
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(l10n.dashboardDatePicker),
                  ),
                  FilledButton.icon(
                    onPressed: () async {
                      final dateRange = await DatePickerDialog.showRange(
                        context,
                        title: l10n.dashboardPickDate,
                        confirmLabel: l10n.commonOk,
                        cancelLabel: l10n.commonCancel,
                        initialDateRange: selectedDateRange,
                      );
                      if (!context.mounted || dateRange == null) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.dashboardSelectedDateRange(
                              dateRange.start.toLocal().toString(),
                              dateRange.end.toLocal().toString(),
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        selectedDateRange = dateRange;
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(l10n.dashboardDateRangePicker),
                  ),
                ],
              ),
            ),
            failure: (message, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _loadUser,
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
