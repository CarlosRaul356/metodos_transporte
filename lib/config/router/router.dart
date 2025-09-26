import 'package:go_router/go_router.dart';
import 'package:metodos_transporte/presentation/screens/home_screen.dart';
import 'package:metodos_transporte/presentation/screens/vogel_method_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: "/vogelMethod",
      builder: (context, state) => VogelMethodScreen(),
    )
  ]
);