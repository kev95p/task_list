import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_list/src/tasks_feature/task_add_form.dart';
import 'package:task_list/src/tasks_feature/task_detail.dart';
import 'package:task_list/src/tasks_feature/task_item_model.dart';
import 'package:task_list/src/tasks_feature/task_list_view.dart';
import 'package:task_list/src/tasks_feature/tasks_cubit.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case TaskAddForm.routeName:
                      if (routeSettings.arguments != null) {
                        return TaskAddForm(
                            taskToEdit:
                                routeSettings.arguments as TaskItemModel);
                      }
                      return const TaskAddForm();
                    case TaskDetail.routeName:
                      final task = routeSettings.arguments as TaskItemModel;
                      return TaskDetail(task: task);
                    case TaskListView.routeName:
                    default:
                      return const TaskListView();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
