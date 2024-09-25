import 'package:go_router/go_router.dart';
import 'package:web_responsive_flutter/src/features/admin/Kaizen_loss/add_loss.dart';
import 'package:web_responsive_flutter/src/features/admin/Kaizen_loss/kaizen_loss_view.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_pillar/kaizen_pillar_view.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_theme/add_theme.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_theme/kaizen_theme_view.dart';
import 'package:web_responsive_flutter/src/features/authentication/login/login_screen.dart';
import 'package:web_responsive_flutter/src/features/dashboard/dashboard.dart';
import 'package:web_responsive_flutter/src/features/edit_request/edit_request.dart';
import 'package:web_responsive_flutter/src/features/kaizenform/kaizen_tabs.dart';
import 'package:web_responsive_flutter/src/features/locations/location_screen.dart';
import 'package:web_responsive_flutter/src/features/splash/splash_screen.dart';
import 'package:web_responsive_flutter/src/features/tables/AddRequest.dart';
import 'package:web_responsive_flutter/src/features/view_request/view_request.dart';
import 'package:web_responsive_flutter/src/routing/not_found_screen.dart';
import 'package:web_responsive_flutter/src/routing/route_names.dart';
import 'package:web_responsive_flutter/src/features/sidebar/shell_layout.dart';

import '../features/admin/kaizen_pillar/add_pillar_view.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.getPath,
          name: AppRoute.splash.getName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoute.login.getPath,
          name: AppRoute.login.getName,
          builder: (context, state) => const LoginScreen(),
        ),
        // Define a ShellRoute for the side menu and dashboard screens
        ShellRoute(
          builder: (context, state, child) {
            return ShellLayout(child: child); // Your shell layout widget
          },
          routes: [
            GoRoute(
              path: '/mainScreen',
              builder: (context, state) => const Dashboard(),
            ),
            GoRoute(
              path: '/requests',
              builder: (context, state) => const AddRequest(),
            ),
            GoRoute(
              path: '/editrequest',
              builder: (context, state) => const EditRequestScreen(),
            ),
            GoRoute(
              path: '/viewrequest',
              builder: (context, state) => const ViewRequestScreen(),
            ),
            GoRoute(
              path: '/location',
              builder: (context, state) => const LocationScreen(),
            ),
            GoRoute(
              path: '/kaizenform',
              builder: (context, state) => const KaizensTabs(),
            ),
            GoRoute(
              path: '/shivendra',
              builder: (context, state) => const KaizenPillarView(),
            ),
            GoRoute(
              path: '/kaizenTheme',
              builder: (context, state) => const KaizenThemeView(),
            ),
            GoRoute(
              path: '/kaizenAddPillar',
              builder: (context, state) => const AddPillarView(),
            ),
            GoRoute(
              path: '/kaizenAddTheme',
              builder: (context, state) => const AddThemeView(),
            ),
            GoRoute(
              path: '/kaizenLoss',
              builder: (context, state) => const KaizenLossView(),
            ),
            GoRoute(
              path: '/kaizenAddLoss',
              builder: (context, state) => const AddLoss(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
