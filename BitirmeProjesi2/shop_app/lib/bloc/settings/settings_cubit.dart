import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(super.initialState);
  changeLanguage(String lang) async {
    final newState = SettingsState(
      language: lang,
      darkmode: state.darkmode,
    );
    
    final SharedPreferences memory = await SharedPreferences.getInstance();
     memory.setString("language", lang );
     emit(newState);
  }

  changeTheme(bool darkMode) async {
    final newState = SettingsState(
      language: state.language,
      darkmode: darkMode,
    );
    
    final SharedPreferences memory = await SharedPreferences.getInstance();
     memory.setBool("darkMode", darkMode);
     emit(newState);
  }
}
