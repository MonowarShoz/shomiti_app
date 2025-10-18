import 'package:flutter/material.dart';

import 'package:imsomitiapp/core/routing/routes.dart';
import 'package:imsomitiapp/core/theming/app_dimensions.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';

import 'package:imsomitiapp/features/settings/presentation/widget/logout_state_listener.dart';

class DrawerOptionList extends StatelessWidget {
  final ValueChanged<String> onOptionClicked;

  const DrawerOptionList({super.key, required this.onOptionClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          color: const Color.fromARGB(255, 4, 65, 170),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SchoolLogoWidget(),
             // DashboardWelcomeWidget()

            ],
          ),
        ),
       

        // ..._buildDrawerItems('Dashboard', Icons.dashboard, Routes.dashboard),
        // ..._buildDrawerItems('Saved Road', Icons.download, Routes.inventory),
        ..._buildDrawerItems('Log Out', Icons.logout, Routes.logout),
        //LogoutStateListener(),
      ],
    );
  }

  List<Widget> _buildDrawerItems(String title, IconData icon, String route) {
    return [
      ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () {
          onOptionClicked(route);
        },
      ),
      Divider(
        color: ColorsManager.grayShade300,
        indent: AppDimensions.padding_10,
        endIndent: AppDimensions.padding_10,
        thickness: AppDimensions.height_1,
        height: AppDimensions.height_1,
      ),
    ];
  }
}
