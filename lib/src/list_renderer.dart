import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class ListRenderer<T> extends ObjectRenderer<List<T>> {
  ObjectRendererAdapter<T> objectRendererAdapter = (object) => StringRenderer<T>()..object = object;
  List<T> _object = <T>[];
  final List<ObjectRenderer<T>> _renderers = <ObjectRenderer<T>>[];

  ListRenderer() : super('ListRenderer');

  @override
  List<T> get object => _object;

  @override
  set object(List<T> newList) {
    _object = newList;
    if (newList.length < _renderers.length) {
      for (var i = newList.length; i < _renderers.length; i++) {
        _renderers[i].remove();
      }
    }
    var i = 0;
    for (final renderer in _renderers) {
      renderer.object = newList[i];
      i++;
    }
    if (newList.length > _renderers.length) {
      for (var i = _renderers.length; i < newList.length; i++) {
        final renderer = objectRendererAdapter(newList[i]);
        _renderers.add(renderer);
        add(renderer);
      }
    }
  }
}
