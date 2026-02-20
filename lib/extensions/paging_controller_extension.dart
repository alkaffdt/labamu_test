import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PagingControllerExt<KeyType, ItemType>
    on PagingController<KeyType, ItemType> {
  void insertItem(ItemType item, {int Function(ItemType a, ItemType b)? sort}) {
    final current = itemList;
    if (current == null) return;

    final newList = [item, ...current];

    if (sort != null) {
      newList.sort(sort);
    }

    itemList = newList;
  }

  void updateItem(
    ItemType item, {
    required bool Function(ItemType element) matcher,
    int Function(ItemType a, ItemType b)? sort,
  }) {
    final current = itemList;
    if (current == null) return;

    final index = current.indexWhere(matcher);
    if (index == -1) return;

    final newList = [...current];
    newList[index] = item;

    if (sort != null) {
      newList.sort(sort);
    }

    itemList = newList;
  }

  void upsertItem(
    ItemType item, {
    required bool Function(ItemType element) matcher,
    int Function(ItemType a, ItemType b)? sort,
  }) {
    final current = itemList;
    if (current == null) return;

    final index = current.indexWhere(matcher);

    if (index == -1) {
      insertItem(item, sort: sort);
      return;
    }

    updateItem(item, matcher: matcher, sort: sort);
  }

  void removeWhere(bool Function(ItemType element) matcher) {
    final current = itemList;
    if (current == null) return;

    itemList = current.where((e) => !matcher(e)).toList();
  }

  void replaceAll(List<ItemType> items) {
    itemList = items;
  }
}
