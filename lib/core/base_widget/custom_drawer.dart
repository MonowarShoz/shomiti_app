import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imsomitiapp/features/settings/presentation/widget/drawer_item.dart';



class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Drawer(child: DrawerItemScreen()));
  }
}
