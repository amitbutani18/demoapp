import 'package:demoapp/Models/item_model.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  var itemList = <ItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getItems();
  }

  Future<void> getItems() async {
    itemList.clear();
    ItemViewModel itemViewModel = ItemViewModel();
    var itemListReponse = await itemViewModel.getItemApiCall();
    itemListReponse.forEach((key, value) {
      printInfo(info: "Key $key  Value $value");
      itemList.add(ItemModel.fromJson(value));
    });
  }
}
