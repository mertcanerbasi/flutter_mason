import './app_router.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMapInit(typeSafe: true)
Route? onGenerateRoute(RouteSettings routeSettings) =>
    $onGenerateRoute(routeSettings);
