import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/settings/settings_cubit.dart';
import 'package:shop_app/bloc/settings/settings_state.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../localizations.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/ayarlar';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsCubit settings;

  _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          AppLocalizations.of(context).getTranslate(
            'selectlanguage',
          ),
        ),
        message: Text(
          AppLocalizations.of(context).getTranslate(
            'message',
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              settings.changeLanguage("en");
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context).getTranslate(
                'english',
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              settings.changeLanguage("tr");
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context).getTranslate(
                'turkish',
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context).getTranslate(
                'cancel',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    settings = context.read<SettingsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAA419),
        title: Text(AppLocalizations.of(context).getTranslate('settings')),
        actions: const <Widget>[],
      ),
      drawer: AppDrawer(),
      body:
          BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language_outlined),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        AppLocalizations.of(context).getTranslate(
                          'language',
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _showActionSheet(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          " ${state.language}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.dark_mode_outlined),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        AppLocalizations.of(context).getTranslate(
                          'darkMode',
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    value: state.darkmode,
                    onChanged: (value) {
                      settings.changeTheme(value);
                    },
                  )
                ],
              )
            ],
          ),
        );
      }),
    ));
  }
}
