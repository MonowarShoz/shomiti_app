import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/theming/app_assets.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/presentation/provider/home_menu_notifier.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';
import 'package:imsomitiapp/features/settings/presentation/provider/setting_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeMenuState = ref.watch(homeMenuNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                AppAssets.appLogo,
                //color: Colors.white,
                // height: 40,
                // width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Shomiti',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //fontSize: 24,
              ),
            ),
          ],
        ),

        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Notifications
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: const Color.fromARGB(255, 4, 65, 170),
            ),
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
              if (shouldLogout == true) {
                try {
                  final notifier = ref.read(logOutNotifierProvider.notifier);

                  await notifier.logOut();
                  await ref
                      .read(newauthStatusProvider.notifier)
                      .seUntAuthenticated();
                  //ref.read(authStatusProvider.notifier).state = AuthStatus.unauthenticated;

                  // final loggedOut = ref
                  //     .read(logOutNotifierProvider)
                  //     .value;
                  // if (loggedOut == true && context.mounted) {
                  //   context.goNamed(Routes.loginScreen);
                  // }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      body: homeMenuState.when(
        data: (menus) {
          if (menus.isEmpty) {
            return const Center(child: Text('No menu items available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return MenuGridItem(menu: menu);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(homeMenuNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMenuGridScreen extends ConsumerWidget {
  const HomeMenuGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsyncValue = ref.watch(homeMenuNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
        elevation: 0,
      ),
      body: menuAsyncValue.when(
        data: (menus) {
          if (menus.isEmpty) {
            return const Center(child: Text('No menu items available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return MenuGridItem(menu: menu);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(homeMenuNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuGridItem extends StatelessWidget {
  final MenuModel menu;

  const MenuGridItem({super.key, required this.menu});

  IconData _getIconForMenu(String menuName) {
    final name = menuName.toLowerCase();
    if (name.contains('dashboard')) return Icons.dashboard;
    if (name.contains('profile')) return Icons.person;
    if (name.contains('settings')) return Icons.settings;
    if (name.contains('report')) return Icons.assessment;
    if (name.contains('user')) return Icons.people;
    if (name.contains('product')) return Icons.inventory;
    if (name.contains('order')) return Icons.shopping_cart;
    if (name.contains('payment')) return Icons.payment;
    return Icons.menu;
  }

  Color _getColorForIndex(int id) {
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.deepOrange,
    ];
    return colors[id % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForIndex(menu.id!);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to menu.menuUrl
          // Navigator.pushNamed(context, menu.menuUrl);

          // Or show a snackbar for demonstration
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigating to ${menu.menuName}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.2), color.withOpacity(0.5)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconForMenu(menu.menuName!),
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  menu.menuName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (menu.level! > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'L${menu.level}',
                    style: TextStyle(
                      fontSize: 9,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
