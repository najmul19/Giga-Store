import 'package:giga_store/core/store.dart';
import 'package:giga_store/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  //singalten class
  // static final cartModel = CartModel._internal();
  // CartModel._internal();
  // factory CartModel() => cartModel;

  //catalog field
  late CatalogModel _catalog;
  //collection of ids - Store Ids of each Item
  final List<int> _itemIds = [];
  // Get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    // ignore: unnecessary_null_comparison
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  // get Items in the cart
  List<Item> get items => _itemIds.map((id) => _catalog.GetById(id)).toList();

  // Get Total Price

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //Remove Item
  // void removes(Item item) {
  //   _itemIds.remove(item.id);
  // }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);
  @override
  perform() {
    store?.cart._itemIds.add(item.id);
  }
}


class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);
  @override
  perform() {
    store?.cart._itemIds.remove(item.id);
  }
}