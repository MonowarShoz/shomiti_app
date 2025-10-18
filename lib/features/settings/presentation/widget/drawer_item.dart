import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/base_widget/app_custom_dialog.dart';
import 'package:imsomitiapp/core/routing/routes.dart';

import 'package:imsomitiapp/features/settings/presentation/provider/setting_notifier.dart';
import 'package:imsomitiapp/features/settings/presentation/widget/drawer_option_list.dart';


class DrawerItemScreen extends ConsumerWidget {
  const DrawerItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DrawerOptionList(
      onOptionClicked: (route) => _handleDrawerOptionClick(route, ref, context),
    );
  }

  _handleDrawerOptionClick(String route, WidgetRef ref,BuildContext context)async{
    switch(route){
      case Routes.logout:
      AppCustomDialog.show(
        context: context,
          title: 'Confirm ',
            message: 'Ask logout',
       okAction: ()async{
        try{
         //  ref.invalidate(homeMenuNotifierProvider);
          final logOutNotifier = ref.read(logOutNotifierProvider.notifier);
          await logOutNotifier.logOut();

        }catch(e){

        }

       }, okActionText: "logout",
       cancelAction: () {
         
       },
       cancelText: 'Cancel'
       );
    }


  }
}