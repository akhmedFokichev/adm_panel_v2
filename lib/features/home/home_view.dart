import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/features/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(model.title),
          ),
          body: Center()),
    );
  }
}

