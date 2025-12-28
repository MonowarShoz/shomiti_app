import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/remote/model/parent_menu_model.dart';
import '../provider/home_sub_menu_notifier.dart';


class MenuGridItem extends StatelessWidget {
  final ParentMenuModel menu;
  final WidgetRef ref;

  const MenuGridItem({super.key, required this.menu, required this.ref});

  String _getIconForMenu(String menuName) {
    final name = menuName.toLowerCase();
    if (name.contains('dashboard')) return AppAssets.dashboard;
    if (name.contains('usermanage')) return AppAssets.usermanage;
    if (name.contains('member')) return AppAssets.memberinfo;
    if (name.contains('project')) return AppAssets.project;
    if (name.contains('kisti')) return AppAssets.kistisubscription;
    if (name.contains('accounts')) return AppAssets.accounts;
    if (name.contains('expense')) return AppAssets.expense;
    if (name.contains('loan')) return AppAssets.loan;
    if (name.contains('finance')) return AppAssets.finance;
    if (name.contains('reports')) return AppAssets.reports;
    return AppAssets.appLogo;
  }





  @override
  Widget build(BuildContext context) {
    final color = ColorsManager().getrColorForIndex(menu.id!);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () async {
          await ref.read(subMenuNotifierProvider.notifier).loadSubMenu(menu.id!);
          if (context.mounted) {
            context.pushNamed(Routes.subMenu, extra: {'menuName': menu.menuName, 'icon': _getIconForMenu(menu.menuName!), 'color': color});
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.08), color.withOpacity(0.15)],
            ),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Image.asset(_getIconForMenu(menu.menuName ?? ''), width: 30, height: 30, color: color),
              ),
              const SizedBox(height: 8),
              // Text with better readability
              Expanded(

                child: Center(
                  child: Text(
                    menu.menuName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      // height: 1.3,
                      //  letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
