import 'package:flutter_hooks/flutter_hooks.dart';

void useAsyncEffect(
  Function() effect, [
  List<Object?>? keys,
  Function()? dispose,
]) {
  useEffect(() {
    Future.microtask(() => effect());
    return dispose?.call();
  }, keys);
}
