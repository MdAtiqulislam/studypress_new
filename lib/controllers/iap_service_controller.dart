import 'dart:async';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPService extends GetxController {
  final InAppPurchase _iap = InAppPurchase.instance;

  final RxList<ProductDetails> products = <ProductDetails>[].obs;
  final RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isProcessing = false.obs;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final Set<String> productIds = {
    "premium_101_5_3_month",
  };

  @override
  void onInit() {
    super.onInit();
    initIAP();
  }

  Future<void> initIAP() async {
    isLoading.value = true;

    final available = await _iap.isAvailable();
    if (!available) {
      isLoading.value = false;
      return;
    }

    final response = await _iap.queryProductDetails(productIds);

    print("IAP Error: ${response.error}");
    print("Not Found IDs: ${response.notFoundIDs}");

    products.assignAll(response.productDetails);

    _subscription = _iap.purchaseStream.listen(
      _listenToPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (e) => print("Purchase Stream Error: $e"),
    );

    isLoading.value = false;
  }

  void buy(ProductDetails product) {
    isProcessing.value = true;
    final param = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: param);
  }

  void restore() {
    isProcessing.value = true;
    _iap.restorePurchases();
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchase in purchaseDetailsList) {
      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _verifyAndComplete(purchase);
          break;
        case PurchaseStatus.error:
          isProcessing.value = false;
          Get.snackbar("Purchase Error", purchase.error?.message ?? "");
          break;
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.canceled:
          isProcessing.value = false;
          break;
      }
    }
  }

  Future<void> _verifyAndComplete(PurchaseDetails purchase) async {
    try {
      // 🔐 Server verification should be here
      purchases.add(purchase);
      await _iap.completePurchase(purchase);
      Get.snackbar("Success", "Subscription Activated");
    } finally {
      isProcessing.value = false;
    }
  }

  ProductDetails? getById(String id) {
    try {
      return products.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
