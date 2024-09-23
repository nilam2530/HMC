import 'package:go_router/go_router.dart';
import 'package:web_responsive_flutter/src/features/dashboard/dashboard.dart';
import 'package:web_responsive_flutter/src/features/edit_request/edit_request.dart';
import 'package:web_responsive_flutter/src/features/locations/location_screen.dart';
import 'package:web_responsive_flutter/src/features/tables/AddRequest.dart';
import 'package:web_responsive_flutter/src/features/view_request/view_request.dart';
import 'package:web_responsive_flutter/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/routing/shell_layout.dart';


class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: '/mainScreen',
      debugLogDiagnostics: true,
      routes: [
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
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
