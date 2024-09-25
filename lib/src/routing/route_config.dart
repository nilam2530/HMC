import 'package:go_router/go_router.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_pillar/add_pillar_view.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_pillar/kaizen_pillar_view.dart';
import 'package:web_responsive_flutter/src/features/dashboard/dashboard.dart';
import 'package:web_responsive_flutter/src/features/edit_request/edit_request.dart';
import 'package:web_responsive_flutter/src/features/locations/location_screen.dart';
import 'package:web_responsive_flutter/src/features/tables/AddRequest.dart';
import 'package:web_responsive_flutter/src/features/view_request/view_request.dart';
import 'package:web_responsive_flutter/src/routing/not_found_screen.dart';
import 'package:web_responsive_flutter/src/routing/shell_layout.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: '/mainScreen',
      debugLogDiagnostics: true,
      routes: [
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
              path: '/shivendra',
              builder: (context, state) => const KaizenPillarView(),
            ),
            GoRoute(
              path: '/addPillar',
              builder: (context, state) => const AddPillarView(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
