import 'package:go_router/go_router.dart';
import 'package:metodos_transporte/presentation/screens/fill_table_screen.dart';
import 'package:metodos_transporte/presentation/screens/home_screen.dart';
import 'package:metodos_transporte/presentation/screens/select_transport_problem_screen.dart';
import 'package:metodos_transporte/presentation/screens/vogel_method_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: "/vogel_method/:id",
      builder: (context, state){
        int id = int.tryParse(state.pathParameters["id"]??"-1")!;
        return VogelMethodScreen(id: id,);
      }
    ),
    GoRoute(
      path: "/select_transport_problem",
      builder: (context, state) => SelectTransportProblemScreen(),
    ),
    GoRoute(
      path: "/fill_table/:name/:sources/:destinations",
      builder: (context, state){
        final String name = state.pathParameters["name"]??"";
        final int sources = int.tryParse(state.pathParameters["sources"]??"")??2;
        final int destinations = int.tryParse(state.pathParameters["destinations"]??"")??2;
        return FillTableScreen(name: name, sources: sources, destinations: destinations);
      },
    ),
  ]
);