import 'package:flutter/material.dart';
import './base_view_model.dart';
import '../di/locator.dart';

abstract class BaseState<T extends BaseViewModel, P extends StatefulWidget>
    extends State<P> {
  T viewModel = getIt<T>();

  @override
  void initState() {
    viewModel.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (getIt.isRegistered<T>(instance: viewModel)) {
      //getIt.resetLazySingleton<T>(instance: viewModel);
    } else {
      viewModel.dispose();
    }
    super.dispose();
  }
}

class Consumer<T extends Listenable> extends StatelessWidget {
  const Consumer({super.key, required this.builder, required this.viewModel});
  final T viewModel;
  final Widget Function(BuildContext context, T viewModel) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (c, _) => builder(c, viewModel),
    );
  }
}

class BaseInheritedNotifier<T extends BaseViewModel>
    extends InheritedNotifier<T> {
  final T viewModel;

  const BaseInheritedNotifier(
      {super.key, required this.viewModel, required super.child});

  static T of<T extends BaseViewModel>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BaseInheritedNotifier<T>>()!
        .viewModel;
  }
}
