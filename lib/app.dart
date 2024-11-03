import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/pages/course/course_page.dart';
import 'package:peer_instruction_student/pages/login/forget_password_page.dart';
import 'package:peer_instruction_student/pages/login/login_page.dart';
import 'package:peer_instruction_student/pages/login/register_page.dart';
import 'package:peer_instruction_student/pages/message/message_page.dart';
import 'package:peer_instruction_student/pages/user/user_page.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.class_outlined),
                  label: '课程',
                  selectedIcon: Icon(Icons.class_rounded)),
              NavigationDestination(
                  icon: Icon(Icons.message_outlined),
                  label: '消息',
                  selectedIcon: Icon(Icons.message_rounded)),
              NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: '我的',
                  selectedIcon: Icon(Icons.person_rounded)),
            ],
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (value) => navigationShell.goBranch(value)));
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _courseNavigatorKey = GlobalKey<NavigatorState>();
final _messageNavigatorKey = GlobalKey<NavigatorState>();
final _userNavigatorKey = GlobalKey<NavigatorState>();

class PeerInstructionStudentApp extends StatelessWidget {
  PeerInstructionStudentApp({super.key});

  final _router = GoRouter(
      initialLocation: "/course",
      redirect: (context, state) {
        if (!Global.isLogin) {
          return "/login";
        } else {
          return null;
        }
      },
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavbar(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _courseNavigatorKey,
              routes: [
                GoRoute(
                    path: "/course",
                    builder: (context, state) => const CoursePage()),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _messageNavigatorKey,
              routes: [
                GoRoute(
                    path: "/message",
                    builder: (context, state) => const MessagePage()),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _userNavigatorKey,
              routes: [
                GoRoute(
                    path: "/user",
                    builder: (context, state) => const UserPage()),
              ],
            )
          ],
        ),
        GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
        GoRoute(
            path: "/register",
            builder: (context, state) => const RegisterPage()),
        GoRoute(
            path: "/forget_password",
            builder: (context, state) => const ForgetPasswordPage()),
      ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalUser>(create: (_) => LocalUser())
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: "同伴教学法支撑平台学生端",
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
        ),
      ),
    );
  }
}
