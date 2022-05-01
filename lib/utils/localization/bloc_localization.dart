import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:urbanspaces/utils/localization/pref_language.dart';

import 'app_localizations.dart';


enum LocaleEvent { en, tr }

class BlocLocalization extends Bloc<LocaleEvent, Locale> {
  BlocLocalization(Locale initialState) : super(initialState);

  Locale get initialState => const Locale("en");

  @override
  Stream<Locale> mapEventToState(LocaleEvent event) async* {
    Locale locale = event == LocaleEvent.tr ? const Locale("tr") : const Locale("en");
    await AppLocalizations.updateLocale(locale);
    PrefUtils.saveLanguage(locale);
    yield locale;
  }
}