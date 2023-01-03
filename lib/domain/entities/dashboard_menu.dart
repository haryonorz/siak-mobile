import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siak_mobile/common/routes.dart';

class DashboardMenu extends Equatable {
  const DashboardMenu({
    required this.icon,
    required this.text,
    required this.goToPage,
  });

  final IconData icon;
  final String text;
  final String goToPage;

  @override
  List<Object?> get props => [
        icon,
        text,
        goToPage,
      ];
}

const menuList = [
  DashboardMenu(
    icon: FontAwesomeIcons.solidCalendarDays,
    text: 'Agenda',
    goToPage: Routes.agenda,
  ),
  DashboardMenu(
    icon: FontAwesomeIcons.solidFileLines,
    text: 'History',
    goToPage: Routes.agendaHistory,
  ),
];
