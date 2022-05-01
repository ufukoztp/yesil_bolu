import 'package:flutter/material.dart';

import '../../features/providers/home_provider.dart';
import '../../utils/localization/app_localizations.dart';
import 'detail_card.dart';

Column infoCard({required HomePageProvider homePageProvider,required BuildContext context}) {
  HomePageProvider _homePageProvider=homePageProvider;
  return Column(children: [
    detailCard(title: AppLocalizations.getString('accessible'),icon: Icons.accessible,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].engellidostu!,content: AppLocalizations.getString('accessible_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('sport_field'),icon: Icons.fitness_center,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].sporalani!,content:AppLocalizations.getString('Spor_Alani_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('eat'),icon: Icons.free_breakfast,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].yemeicme!,content:AppLocalizations.getString('eat_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('wc'),icon: Icons.wc,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].tuvalet!,content: AppLocalizations.getString('wc_content'),context: context),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('culture'),icon: Icons.museum,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].kultureloge!,content: AppLocalizations.getString('culture_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('car_park'),icon: Icons.directions_car,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].otopark!, content: 'Otopark',context: context),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('sit_field'),icon: Icons.airline_seat_recline_normal,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].oturmaalani!,content: AppLocalizations.getString('sit_fields_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('basketball'),icon: Icons.sports_basketball_rounded,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].basketbol!,content: AppLocalizations.getString('Basketbol_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('bicycle_path'),icon: Icons.directions_bike_outlined,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].bisikletyolu!,content: AppLocalizations.getString('Bisiklet_Yolu_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('running_track'),icon: Icons.directions_run,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].kosuparkuru!,content: AppLocalizations.getString('Kosu_Parkuru_content'),context: context ),
    const SizedBox(height: 30,),
    detailCard(title:  AppLocalizations.getString('wifi'),icon: Icons.wifi,enabled: _homePageProvider.park[_homePageProvider.parkListPosition].wifi!,content: AppLocalizations.getString('Wifi_content'),context: context ),
  ],);
}
