import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/features/counter/bloc/counter_bloc.dart';
import 'package:adm_panel_v2/features/counter/bloc/counter_event.dart';
import 'package:adm_panel_v2/features/counter/bloc/counter_state.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Страница счетчика с использованием BLoC и MIX
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc()..add(const CounterIncremented()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter with BLoC + MIX'),
        ),
        body: const _CounterView(),
      ),
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Заголовок с использованием MIX стилей
            StyledText(
              'Счетчик',
              style: MixStyles.headingLarge,
            ),
            const SizedBox(height: 32),
            // Отображение значения счетчика
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterLoaded) {
                  return StyledText(
                    '${state.value}',
                    style: Style(
                      $text.style.fontSize(64),
                      $text.style.fontWeight(FontWeight.bold),
                      $text.style.color(AppColors.primary),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 48),
            // Кнопки управления с использованием MIX стилей
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Кнопка уменьшения
                Pressable(
                  onPress: () {
                    context.read<CounterBloc>().add(const CounterDecremented());
                  },
                  child: Box(
                    style: MixStyles.outlinedButton,
                    child: StyledText(
                      '-',
                      style: MixStyles.outlinedButton,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Кнопка сброса
                Pressable(
                  onPress: () {
                    context.read<CounterBloc>().add(const CounterReset());
                  },
                  child: Box(
                    style: MixStyles.textButton,
                    child: StyledText(
                      'Reset',
                      style: MixStyles.textButton,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Кнопка увеличения
                Pressable(
                  onPress: () {
                    context.read<CounterBloc>().add(const CounterIncremented());
                  },
                  child: Box(
                    style: MixStyles.primaryButton,
                    child: StyledText(
                      '+',
                      style: MixStyles.primaryButton,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
