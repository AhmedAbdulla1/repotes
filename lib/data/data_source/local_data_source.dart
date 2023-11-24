// import 'package:reports/data/network/error_handler.dart';
//
// String cacheHomeKey = 'CACHE HOME KEY';
// String cacheStoresDetailsKey = 'CACHE STORES DETAILS KEY';
//
// abstract class LocalDataSource {
//
//
//   // Future<StoresDetailsResponse> storeDetailsResponse();
//
//   Future<void> saveHomeToCache( documentSnapshot);
//
//   // Future<void> saveStoreDetailsToCache(StoresDetailsResponse storesDetailsResponse);
//
//   void clearCache();
//
//   void removeFromCache(String key);
// }
//
// class LocalDataSourceImpl extends LocalDataSource {
//   Map<String, CachedItem> cacheMap = {};
//
//   @override
//   Future<DocumentSnapshot> homeResponse(bool internet) async {
//     CachedItem? cachedItem = cacheMap[cacheHomeKey];
//     if (internet) {
//       if (cachedItem != null && cachedItem.isValid(6000)) {
//         return cachedItem.data;
//       } else {
//         throw ErrorHandler.handle(DataSource.cacheError);
//       }
//     } else {
//       if (cachedItem != null) {
//         return cachedItem.data;
//       } else {
//         throw ErrorHandler.handle(DataSource.cacheError);
//       }
//     }
//   }
//
//   @override
//   Future<void> saveHomeToCache(DocumentSnapshot documentSnapshot) async {
//     print(documentSnapshot);
//     cacheMap[cacheHomeKey] = CachedItem(data: documentSnapshot);
//   }
//
//   @override
//   void clearCache() {
//     cacheMap.clear();
//   }
//
//   @override
//   void removeFromCache(String key) {
//     cacheMap.remove(key);
//   }
//
// // @override
// // Future<StoresDetailsResponse> storeDetailsResponse() async {
// //   CachedItem? cachedItem = cacheMap[cacheStoresDetailsKey];
// //
// //   if(cachedItem!=null && cachedItem.isValid(60000)){
// //     print('cache2');
// //
// //     return cachedItem.data;
// //   }
// //   else{
// //     print('not cache');
// //     throw ErrorHandler.handle(DataSource.cacheError);
// //   }
// // }
// //
// // @override
// // Future<void> saveStoreDetailsToCache(StoresDetailsResponse storesDetailsResponse) async{
// //   cacheMap[cacheStoresDetailsKey]=CachedItem(data:  storesDetailsResponse);
// // }
// }
//
// class CachedItem {
//   dynamic data;
//   int cacheTime = DateTime.now().millisecondsSinceEpoch;
//
//   CachedItem({required this.data});
// }
//
// extension CachedItemExtension on CachedItem {
//   bool isValid(int expirationTime) {
//     int checkTime = DateTime.now().millisecondsSinceEpoch;
//     bool isValid = checkTime - cacheTime < expirationTime;
//     return isValid;
//   }
// }
