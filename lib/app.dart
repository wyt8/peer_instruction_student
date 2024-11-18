import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/pages/class/class_page.dart';
import 'package:peer_instruction_student/pages/class/exercise_page.dart';
import 'package:peer_instruction_student/pages/course/course_list_page.dart';
import 'package:peer_instruction_student/pages/course/course_page.dart';
import 'package:peer_instruction_student/pages/discussion/discussion_page.dart';
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
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          redirect: (context, state) {
            if (!Global.isLogin) {
              return "/login";
            } else {
              return null;
            }
          },
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavbar(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _courseNavigatorKey,
              routes: [
                GoRoute(
                    path: "/course",
                    builder: (context, state) => const CourseListPage()),
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
        GoRoute(
          redirect: (context, state) {
            if (!Global.isLogin) {
              return "/login";
            } else {
              return null;
            }
          },
          path: "/course/:course_id",
          builder: (context, state) => CoursePage(
              courseId: int.parse(state.pathParameters['course_id']!),
              courseName:
                  (state.extra! as Map<String, dynamic>)['course_name']!,
              courseImageUrl:
                  (state.extra! as Map<String, dynamic>)['course_image_url']!),
          routes: [
            GoRoute(
              path: "discussion/:discussion_id",
              builder: (context, state) => DiscussionPage(
                courseId: int.parse(state.pathParameters['course_id']!),
                discussionId: int.parse(state.pathParameters['discussion_id']!),
                discussionTitle:
                    (state.extra! as Map<String, dynamic>)['discussion_title']!,
                discussionContent: (state.extra!
                    as Map<String, dynamic>)['discussion_content']!,
                createdTime:
                    (state.extra! as Map<String, dynamic>)['created_time']!,
                posterAvatar:
                    (state.extra! as Map<String, dynamic>)['poster_avatar']!,
                posterName:
                    (state.extra! as Map<String, dynamic>)['poster_name']!,
              ),
            ),
            GoRoute(
                path: "class/:class_id",
                builder: (context, state) => ClassPage(
                      courseId: int.parse(state.pathParameters['course_id']!),
                      classId: int.parse(state.pathParameters['class_id']!),
                    ))
          ],
        ),
        GoRoute(path: '/exercise/:exercise_id', builder: (context, state) => ExercisePage(
          exerciseId: int.parse(state.pathParameters['exercise_id']!),
          index: (state.extra! as Map<String, dynamic>)['index']!,
          time: (state.extra! as Map<String, dynamic>)['time']!,
          exerciseContent: (state.extra! as Map<String, dynamic>)['exercise_content']!,
          exerciseOptions: (state.extra! as Map<String, dynamic>)['exercise_options']!,
          myOption: (state.extra! as Map<String, dynamic>)['my_option'],
          rightOption: (state.extra! as Map<String, dynamic>)['right_option'],
        ))
      ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalUser>(create: (_) => LocalUser())
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: "同伴课堂",
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Alibaba_PuHuiTi",
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF4C6ED7))),
        ),
      ),
    );
  }
}
