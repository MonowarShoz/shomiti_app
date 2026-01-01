import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/routing/routes.dart';
import 'package:imsomitiapp/features/Home/presentation/provider/home_sub_menu_notifier.dart';

class SubmenuScreen extends ConsumerWidget {
  final String menuTitle;
  final String headersubMenuIcon;
  final Color subMenuColor;

  const SubmenuScreen({super.key, required this.menuTitle, required this.headersubMenuIcon, required this.subMenuColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subMenuState = ref.watch(subMenuNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            //Icon(headersubMenuIcon),
            //const SizedBox(width: 8),
            Text(menuTitle),
          ],
        ),
      ),
      body: subMenuState.when(
        data: (subMenuList) {
          if (subMenuList.isEmpty) {
            return const Center(child: Text('No menu items available'));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: subMenuList.length,
              itemBuilder: (context, index) {
                final subMenu = subMenuList[index];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        navigatingToModule(context, subMenu.menuName ?? '');
                        // navigatingToModule(context,menu.menuName ?? "");
                        // Navigate to menu.menuUrl
                        // Navigator.pushNamed(context, menu.menuUrl);

                        // Or show a snackbar for demonstration
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Navigating to ${menu.menuName}'),
                        //     duration: const Duration(seconds: 1),
                        //   ),
                        // );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),

                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [subMenuColor.withOpacity(0.2), subMenuColor.withOpacity(0.5)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: subMenuColor.withOpacity(0.2), shape: BoxShape.circle),
                              child: Image.asset(headersubMenuIcon,height: 30,width: 30,),
                            ),
                            const SizedBox(height: 8),
                            Flexible(
                              child: Text(
                                subMenu.menuName!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[800], height: 1.2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Retry loading the submenu
                      ref.invalidate(subMenuNotifierProvider);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: subMenuColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(subMenuColor)),
                const SizedBox(height: 16),
                Text('Loading $menuTitle...', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              ],
            ),
          );
        },
      ),
    );
  }

  void navigatingToModule(BuildContext context, String menuName) {
    switch (menuName) {
      case "Member Info":
        context.pushNamed(Routes.memberInfo);

        break;
      case "Kisti Info":
        context.pushNamed(Routes.kistiInfo);
        break;
      case "Project":
        context.pushNamed(Routes.project);
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Under Construction ${menuName}'), duration: const Duration(seconds: 1)));
    }
  }
}
