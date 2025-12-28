import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/routing/routes.dart';
import 'package:imsomitiapp/core/theming/app_assets.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Home/presentation/provider/home_menu_notifier.dart';
import 'package:imsomitiapp/features/Home/presentation/provider/home_sub_menu_notifier.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';
import 'package:imsomitiapp/features/settings/presentation/provider/setting_notifier.dart';

import 'menugrid_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeMenuState = ref.watch(homeparentMenuNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
            icon: Icon(Icons.logout, color: const Color.fromARGB(255, 4, 65, 170)),
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Logout')),
                    ],
                  );
                },
              );
              if (shouldLogout == true) {
                try {
                  final notifier = ref.read(logOutNotifierProvider.notifier);

                  await notifier.logOut();
                  await ref.read(newauthStatusProvider.notifier).seUntAuthenticated();
                  //ref.read(authStatusProvider.notifier).state = AuthStatus.unauthenticated;

                  // final loggedOut = ref
                  //     .read(logOutNotifierProvider)
                  //     .value;
                  // if (loggedOut == true && context.mounted) {
                  //   context.goNamed(Routes.loginScreen);
                  // }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
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
                return MenuGridItem(menu: menu, ref: ref);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (error is ApiErrorHandler) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${error.apiErrorModel.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => ref.refresh(homeparentMenuNotifierProvider), child: const Text('Retry')),
                ],
              ),
            );
          } else {
            return Center(child: Text('Error: ${error.toString()}'));
          }
        },
      ),
    );
  }
}

class HomeMenuGridScreen extends ConsumerWidget {
  const HomeMenuGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsyncValue = ref.watch(homeparentMenuNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Menu'), centerTitle: true, elevation: 0),
      body: menuAsyncValue.when(
        data: (menus) {
          if (menus.isEmpty) {
            return const Center(child: Text('No menu items available'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                return MenuGridItem(menu: menu, ref: ref);
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
              ElevatedButton(onPressed: () => ref.refresh(homeparentMenuNotifierProvider), child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
final List<Color> tileColors = [
  Color(0xFF1E293B), // Slate 800
  Color(0xFF334155), // Slate 700
  Color(0xFF475569), // Slate 600
  Color(0xFF64748B), // Slate 500
  Color(0xFF94A3B8), // Slate 400
  Color(0xFFCBD5E1), // Slate 300
];


