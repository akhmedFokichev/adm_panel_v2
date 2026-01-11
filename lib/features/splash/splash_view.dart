import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/features/splash/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) {
        // ViewModel сам управляет навигацией - правильный MVVM подход
        viewModel.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: SplashContent(),
          ),
        );
      },
    );
  }
}

/// Виджет контента splash экрана
class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Логотип или иконка приложения
        Icon(
          Icons.local_shipping,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        // Название приложения
        Text(
          'RU Delivery',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 48),
        // Индикатор загрузки
        CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
