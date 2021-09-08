import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/translation_hook.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/providers/chuck_norris_joke_providers.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChuckNorrisJokeCard extends HookWidget {
  const ChuckNorrisJokeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewController = useProvider(chuckNorrisJokeViewControllerProvider);
    final status = useProvider(chuckNorrisStatusProvider).state;
    final joke = useProvider(chuckNorrisRandomJokeProvider).state;

    useAsyncEffect(
      () => viewController.fetchChuckNorrisRandomJoke(),
      [viewController],
    );

    return Card(
      child: status == Status.fulfilled && joke != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  joke.iconUrl ?? '',
                ),
                const SizedBox(height: 12),
                Text(joke.value)
              ],
            )
          : status == Status.rejected
              ? _ChuckNorrisJokeError(
                  onRetryPressed: () =>
                      viewController.fetchChuckNorrisRandomJoke())
              : const _ChuckNorrisJokeLoading(),
    );
  }
}

class _ChuckNorrisJokeLoading extends HookWidget {
  const _ChuckNorrisJokeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translation = useTranslation();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 12),
        Text(translation.loadingMessage),
      ],
    );
  }
}

class _ChuckNorrisJokeError extends HookWidget {
  final Function() onRetryPressed;

  const _ChuckNorrisJokeError({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewController = useProvider(chuckNorrisJokeViewControllerProvider);
    final translation = useTranslation();
    final error = useProvider(chuckNorrisErrorProvider).state;
    final errorString = useMemoized(() {
      return error?.toString();
    }, [error]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(translation.errorMessage),
        if (errorString != null) Text(errorString),
        IconButton(
          onPressed: onRetryPressed,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }
}
