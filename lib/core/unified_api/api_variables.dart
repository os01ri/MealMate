import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'https';
  final _host = "address-house.net";
  // final _host = '192.168.243.1';
  // final _port = 5000;

  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      // port: _port,
      path: 'api/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  Uri uploadMedia() => _mainUri(path: 'mediaUpload');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  Uri _mobileUri(
          {required String path, Map<String, dynamic>? queryParameters}) =>
      _mainUri(
        path: 'mobile/$path',
        queryParameters: queryParameters,
      );

  Uri indexCities() => _mobileUri(path: 'city/index');
  Uri indexCitiesWithoutAuth() => _mainUri(path: "city/index");

  //////////////
  /////Auth/////
  //////////////
  Uri _auth({required String path}) => _mainUri(path: 'auth/user/$path');
  Uri login() => _auth(path: 'login');
  Uri logout() => _auth(path: 'logout');
  Uri validateRegister() => _auth(path: "validateRegister");
  Uri register() => _auth(path: 'register');
  Uri verifyCode() => _auth(path: 'sendOtp');
  Uri parentCode() => _auth(path: 'updateParentCode');
  Uri updatePhoneNumber() => _auth(path: 'phonenumber/update');
  Uri phoneNumberValidate() => _auth(path: 'phonenumber/validate');

  //////////
  ///User///
  /////////
  Uri _user({required String path, Map<String, dynamic>? params}) =>
      _mobileUri(path: "user/$path", queryParameters: params);

  Uri initData() => _mobileUri(path: "initialData/index");

  Uri changePassword() => _user(path: "updatePassword");

  Uri updateUserInfo() => _user(path: "update");
  //////////////////
  ///Points Award///
  ////////////////
  Uri getPoints() => _mobileUri(path: 'pointAward/index');
  //////////////////
  ///Qr Purchase///
  ////////////////
  Uri _qr({required String path, Map<String, dynamic>? queryParameters}) =>
      _mobileUri(
        path: 'qrCode/$path',
        queryParameters: queryParameters,
      );
  Uri qrStyle() => _mobileUri(path: 'qrCodeTemplate/index');
  Uri qrSms() => _qr(path: 'storeSms');
  Uri qrPhoneNumber() => _qr(path: 'storePhoneNumber');
  Uri qrWifi() => _qr(path: 'storeWifi');
  Uri qrContact() => _qr(path: 'storeContact');
  Uri qrUrl() => _qr(path: 'storeWebSiteUrl');
  Uri qrText() => _qr(path: 'storeText');
  Uri qrEmail() => _qr(path: "storeEmail");
  Uri qrWhatsapp() => _qr(path: 'storeWhatsapp');
  Uri qrInstagram() => _qr(path: "storeInstagram");
  Uri qrCalendar() => _qr(path: "storeCalendar");
  Uri qrFacebook() => _qr(path: "storeFacebook");
  Uri qrYoutube() => _qr(path: "storeYoutube");
  Uri qrPaypal() => _qr(path: "storePaypal");
  Uri qrTikTok() => _qr(path: "storeTikTok");
  Uri qrLinkedin() => _qr(path: "storeLinkedIn");

  ///////////////////
  ///subscription///
  /////////////////
  Uri _subscription({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'subscription/$path',
        queryParameters: queryParameters,
      );
  Uri getPrice() => _subscription(path: 'getPriceForCollectionOfAppService');
  Uri setSubscribe() => _subscription(path: "buyCollectionOfAppService");
  Uri getSubscriptionsCounts(Map<String, dynamic> params) => _subscription(
        path: "indexSubscriptionsCountsForUser",
        queryParameters: params,
      );
  Uri indexUserInactiveQrCodeSubscriptions() =>
      _qr(path: "subscription/indexInactive");
  Uri indexUserPreviousMiniMenuSubscriptions(Map<String, dynamic> params) =>
      _subscription(
        path: "getUserPreviousMiniMenuSubscriptions",
        queryParameters: params,
      );
  Uri indexUserPreviousQrCodesSubscriptions(Map<String, dynamic> params) =>
      _mobileUri(
        path: "qrCode/index",
        queryParameters: params,
      );

  /////////////////////
  ///citizen service///
  /////////////////////
  Uri indexCitizenServices() => _mobileUri(path: "citizenServiceClass/index");
  Uri indexCitizenServicesRequirement(Map<String, dynamic> params) =>
      _mobileUri(
        path: "citizenServiceRequirement/index",
        queryParameters: params,
      );
  //////////////
  ///favorite///
  /////////////
  Uri toggleFavorite() => _mobileUri(path: "favorite/toggleFavorite");
  Uri getAddressContentFavorite(Map<String, dynamic> params) => _mobileUri(
        path: "favorite/indexAddressContentForUser",
        queryParameters: params,
      );
  Uri getAddressShopFavorite(Map<String, dynamic> params) => _mobileUri(
        path: "favorite/indexAddressShopForUser",
        queryParameters: params,
      );
  /////////////////////////
  ///Favorite Suggestion///
  ////////////////////////

  Uri getFavoriteSuggestionContent(Map<String, dynamic> params) => _mobileUri(
        path: "favoriteSuggestion/indexAddressContentFavoriteSuggestionForUser",
        queryParameters: params,
      );
  Uri getFavoriteSuggestionShop(Map<String, dynamic> params) => _mobileUri(
        path: "favoriteSuggestion/indexAddressShopFavoriteSuggestionForUser",
        queryParameters: params,
      );

  /////////////
  ///content///
  /////////////
  Uri _content({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'addressContent/$path',
        queryParameters: queryParameters,
      );
  Uri indexInactiveContentSubscriptions(Map<String, dynamic> params) =>
      _content(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri reactivateAddressContentForUser({
    required Map<String, dynamic> params,
    required int subscriptionId,
    required int contentId,
  }) =>
      _content(
        path:
            "subscription/$subscriptionId/addressContent/$contentId/reactivate",
        queryParameters: params,
      );
  Uri extendAddressContentForUser({
    required Map<String, dynamic> params,
    required int subscriptionId,
    required int contentId,
  }) =>
      _content(
        path: "subscription/$subscriptionId/addressContent/$contentId/extend",
        queryParameters: params,
      );
  Uri indexContents({
    required Map<String, dynamic> queryParameters,
  }) =>
      _content(
        path: "index",
        queryParameters: queryParameters,
      );
  Uri indexUserContents(
    Map<String, dynamic>? queryParameters,
  ) =>
      _content(
        path: "indexForUser",
        queryParameters: queryParameters,
      );
  Uri showContent(int id) => _content(path: '$id/show');
  Uri showContentForUser(int id) => _content(path: "$id/showForUser");
  //////////////////////////
  ///content buy requests///
  //////////////////////////
  Uri _contentBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _content(
        path: "buyRequest/$path",
        queryParameters: queryParameters,
      );
  Uri showContentBuyRequest(int id) => _contentBuyRequest(path: '$id/show');
  Uri indexContentBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _contentBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyContentBuyRequest(int id) =>
      _contentBuyRequest(path: '$id/destroy');
  /////////////////////////////
  ///content upload requests///
  /////////////////////////////
  Uri _contentUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _content(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderContentUpload(int subscriptionId) => _contentUploadRequest(
        path: 'subscription/$subscriptionId/order',
      );
  Uri destroyContentUploadRequest(int id) =>
      _contentUploadRequest(path: '$id/destroy');
  Uri showContentUploadRequest(int id) =>
      _contentUploadRequest(path: '$id/show');
  Uri indexContentUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _contentUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  /////////////////////////////
  ///content update requests///
  /////////////////////////////
  Uri _contentUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _content(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderContentUpdate(int id) =>
      _contentUpdateRequest(path: 'addressContent/$id/order');
  Uri destroyContentUpdateRequest(int id) =>
      _contentUpdateRequest(path: '$id/destroy');
  Uri showContentUpdateRequest(int id) =>
      _contentUpdateRequest(path: '$id/show');
  Uri getContentUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _contentUpdateRequest(
        path: 'index',
        queryParameters: params,
      );
  //////////
  ///post///
  //////////
  Uri _post({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'post/$path',
        queryParameters: queryParameters,
      );
  Uri indexInactivePostSubscriptions(Map<String, dynamic> params) => _post(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri indexPosts({
    Map<String, dynamic>? parameters,
  }) =>
      _post(
        path: 'index',
        queryParameters: parameters,
      );
  Uri indexUserPosts({
    Map<String, dynamic>? parameters,
  }) =>
      _post(
        path: 'indexForUser',
        queryParameters: parameters,
      );
  Uri viewPost() => _post(path: "view");
  Uri toggleLikePost(int postId) => _post(path: "$postId/toggleLike");
  // TODO: remove
  Uri updatePost({
    required int id,
    Map<String, dynamic>? queryParameters,
  }) =>
      _post(
        path: '$id/update',
        queryParameters: queryParameters,
      );
  Uri getStatisticPostViews(int id, Map<String, dynamic> params) => _post(
        path: "$id/viewsStatistic",
        queryParameters: params,
      );
  Uri getStatisticPostLikes(int id, Map<String, dynamic> params) => _post(
        path: "$id/likesStatistic",
        queryParameters: params,
      );
  ///////////////////////
  ///post buy requests///
  ///////////////////////
  Uri _postBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _post(
        path: "buyRequest/$path",
        queryParameters: queryParameters,
      );
  Uri indexPostBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _postBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyPostBuyRequest(int id) => _postBuyRequest(path: '$id/destroy');
  Uri showPostBuyRequest(int id) => _postBuyRequest(path: '$id/show');

  //////////////////////////
  ///post upload requests///
  //////////////////////////
  Uri _postUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _post(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderPostUpload(int subscriptionId) => _postUploadRequest(
        path: 'subscription/$subscriptionId/order',
      );
  Uri destroyPostUploadRequest(int id) =>
      _postUploadRequest(path: '$id/destroy');
  Uri indexPostUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _postUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri showPostUploadRequest(int id) => _postUploadRequest(path: '$id/show');
  //////////////////////////
  ///post update requests///
  //////////////////////////
  Uri _postUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _post(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderPostUpdate(int id) => _postUpdateRequest(path: 'post/$id/order');
  Uri destroyPostUpdateRequest(int id) =>
      _postUpdateRequest(path: '$id/destroy');
  Uri showPostUpdateRequest(int id) => _postUpdateRequest(path: '$id/show');
  Uri getPostUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _postUpdateRequest(
        path: 'index',
        queryParameters: params,
      );
  //////////////////
  ///address shop///
  //////////////////
  Uri _addressShop({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'addressShop/$path',
        queryParameters: queryParameters,
      );
  Uri indexInactiveShopSubscriptions(Map<String, dynamic> params) =>
      _addressShop(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri reactivateAddressShopForUser({
    required Map<String, dynamic> params,
    required int subscriptionId,
    required int contentId,
  }) =>
      _addressShop(
        path: "subscription/$subscriptionId/addressShop/$contentId/reactivate",
        queryParameters: params,
      );
  Uri extendAddressShopForUser({
    required Map<String, dynamic> params,
    required int subscriptionId,
    required int contentId,
  }) =>
      _addressShop(
        path: "subscription/$subscriptionId/addressShop/$contentId/extend",
        queryParameters: params,
      );
  Uri indexShops({
    required Map<String, dynamic> queryParameters,
  }) =>
      _addressShop(
        path: "index",
        queryParameters: queryParameters,
      );
  Uri indexUserShops({
    Map<String, dynamic>? queryParameters,
  }) =>
      _addressShop(
        path: "indexForUser",
        queryParameters: queryParameters,
      );
  Uri showShop({
    required int id,
  }) =>
      _addressShop(
        path: "$id/show",
      );
  Uri showShopForUser({
    required int contentId,
  }) =>
      _addressShop(
        path: "$contentId/showForUser",
      );
  //TODO: remove
  Uri editAddressShop({required int id}) => _addressShop(path: "$id/update");
  //////////////////////////////
  ///address shop buy request///
  //////////////////////////////
  Uri _shopBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _addressShop(
        path: 'buyRequest/$path',
        queryParameters: queryParameters,
      );
  Uri getShopBuyDetails({
    required shopId,
    Map<String, dynamic>? queryParameters,
  }) =>
      _shopBuyRequest(
        path: 'addressShop/$shopId/getBuyDetails',
        queryParameters: queryParameters,
      );
  Uri orderShopBuyRequest({
    required shopId,
    Map<String, dynamic>? queryParameters,
  }) =>
      _shopBuyRequest(
        path: 'addressShop/$shopId/order',
        queryParameters: queryParameters,
      );
  Uri showShopBuyRequest(int id) => _shopBuyRequest(path: '$id/show');
  Uri indexShopBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _shopBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyShopBuyRequest(int id) => _shopBuyRequest(path: '$id/destroy');
  //////////////////////////////////
  ///address shop upload requests///
  //////////////////////////////////
  Uri _shopUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _addressShop(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderShopUpload(int subscriptionId) => _shopUploadRequest(
        path: 'subscription/$subscriptionId/order',
      );
  Uri destroyShopUploadRequest(int id) =>
      _shopUploadRequest(path: '$id/destroy');
  Uri indexShopUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _shopUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri showShopUploadRequest(int id) => _shopUploadRequest(path: '$id/show');
  //////////////////////////
  ///shop update requests///
  //////////////////////////
  Uri _shopUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _addressShop(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderShopUpdate(int id) =>
      _shopUpdateRequest(path: 'addressShop/$id/order');
  Uri destroyShopUpdateRequest(int id) =>
      _shopUpdateRequest(path: '$id/destroy');
  Uri showShopUpdateRequest(int id) => _shopUpdateRequest(path: '$id/show');
  Uri getShopUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _shopUpdateRequest(
        path: 'index',
        queryParameters: params,
      );
  ///////////////////////////
  ///address shop category///
  ///////////////////////////
  Uri _shopCategory({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'addressShopCategory/$path',
        queryParameters: queryParameters,
      );
  Uri indexShopCategoriesForUser({required int shopId}) =>
      _shopCategory(path: 'addressShop/$shopId/indexForUser');
  Uri indexShopCategories({required int shopId}) =>
      _shopCategory(path: "addressShop/$shopId/index");
  Uri addShopCategory(int shopId) => _shopCategory(
        path: "addressShop/$shopId/store",
      );
  //////////////
  // products //
  //////////////
  Uri _product({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'product/$path',
        queryParameters: queryParameters,
      );
  Uri indexProductsOffers(Map<String, dynamic> params) => _product(
        path: "indexSpecialOffer",
        queryParameters: params,
      );
  Uri indexTrendingProducts(Map<String, dynamic> params) => _product(
        path: "indexTrending",
        queryParameters: params,
      );
  Uri indexProducts(Map<String, dynamic> params) => _product(
        path: "index",
        queryParameters: params,
      );
  Uri indexProductsForShop({
    required Map<String, dynamic> queryParameters,
  }) =>
      _product(
        path: "indexForUser",
        queryParameters: queryParameters,
      );
  Uri showProductForUser(int id) => _product(
        path: "$id/showForUser",
      );
  Uri showProduct(int id) => _product(
        path: "$id/show",
      );
  Uri addOffer(int productId) => _product(path: '$productId/addOffer');
  Uri removeOffer(int productId) => _product(path: '$productId/removeOffer');
  Uri addProduct(int categoryId) => _product(
        path: "addressShopCategory/$categoryId/store",
      );
  Uri deleteProduct(int productId) => _product(path: "$productId/destroy");
  Uri updateProduct({required int productId}) =>
      _product(path: "$productId/update");
  ///////////
  ///story///
  ///////////
  Uri _story({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'story/$path',
        queryParameters: queryParameters,
      );
  Uri indexInactiveStoriesSubscriptions(Map<String, dynamic> params) => _story(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri indexUserStories(Map<String, dynamic> params) => _story(
        path: "indexForUser",
        queryParameters: params,
      );
  Uri showForUserStory(int id) => _story(path: '$id/showForUser');
  Uri showStory(int id) => _story(path: '$id/show');
  Uri indexStories(Map<String, dynamic> params) => _story(
        path: "index",
        queryParameters: params,
      );
  Uri reactivateStory({
    required int subscriptionId,
    required int storyId,
  }) =>
      _story(
        path: 'subscription/$subscriptionId/story/$storyId/reactivate',
      );

  ////////////////////////
  ///story buy requests///
  ////////////////////////
  Uri _storyBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _story(
        path: "buyRequest/$path",
        queryParameters: queryParameters,
      );
  Uri indexStoryBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _storyBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri showStoryBuyRequest(int id) => _storyBuyRequest(path: '$id/show');
  Uri destroyStoryBuyRequest(int id) => _storyBuyRequest(path: '$id/destroy');
  ///////////////////////////
  ///Story upload requests///
  ///////////////////////////
  Uri _storyUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _story(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderStoryUpload(int subscriptionId) => _storyUploadRequest(
        path: 'subscription/$subscriptionId/order',
      );
  Uri destroyStoryUploadRequest(int id) =>
      _storyUploadRequest(path: '$id/destroy');
  Uri showStoryUploadRequest(int id) => _storyUploadRequest(path: '$id/show');
  Uri indexStoryUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _storyUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  ///////////////////////////
  ///story update requests///
  ///////////////////////////
  Uri _storyUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _story(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderStoryUpdate(int id) => _storyUpdateRequest(path: 'story/$id/order');
  Uri destroyStoryUpdateRequest(int id) =>
      _storyUpdateRequest(path: '$id/destroy');
  Uri showStoryUpdateRequest(int id) => _storyUpdateRequest(path: '$id/show');
  Uri getStoryUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _storyUpdateRequest(
        path: 'index',
        queryParameters: params,
      );
  ////////////////////
  ////notification////
  ////////////////////
  Uri _notification({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'notification/$path',
        queryParameters: queryParameters,
      );

  Uri indexInactiveNotificationSubscriptions(Map<String, dynamic> params) =>
      _notification(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri showNotificationRecived(int id) => _notification(path: '$id/show');
  Uri indexUserNotifications(Map<String, dynamic> params) => _notification(
        path: "indexForUser",
        queryParameters: params,
      );
  Uri sendNotification(int notificationId) => _notification(
        path: "$notificationId/send",
      );
  Uri indexNotificationRecieved(Map<String, dynamic> params) =>
      _notification(path: 'indexReceived', queryParameters: params);
  //////////////////////////////
  ///Notification buy request///
  //////////////////////////////
  Uri _notificationBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _notification(
        path: 'buyRequest/$path',
        queryParameters: queryParameters,
      );
  Uri getNotificationBuyDetails({
    required notificationId,
    Map<String, dynamic>? queryParameters,
  }) =>
      _notificationBuyRequest(
        path: 'notification/$notificationId/getBuyDetails',
        queryParameters: queryParameters,
      );
  Uri orderNotificationBuyRequest({
    required notificationId,
    Map<String, dynamic>? queryParameters,
  }) =>
      _notificationBuyRequest(
        path: 'notification/$notificationId/order',
        queryParameters: queryParameters,
      );
  Uri indexNotificationBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _notificationBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyNotificationBuyRequest(int id) =>
      _notificationBuyRequest(path: '$id/destroy');
  Uri showNotificationBuyRequest(int id) =>
      _notificationBuyRequest(path: '$id/show');
  //////////////////////////////////
  ///Notification upload requests///
  //////////////////////////////////
  Uri _notificationUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _notification(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderNotificationUpload(int subscriptionId) => _notificationUploadRequest(
        path: "subscription/$subscriptionId/order",
      );
  Uri destroyNotificationUploadRequest(int id) =>
      _notificationUploadRequest(path: '$id/destroy');
  Uri showNotificationUploadRequest(int id) =>
      _notificationUploadRequest(path: '$id/show');
  Uri indexNotificationUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _notificationUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  //////////////////////////////////
  ///Notification update requests///
  //////////////////////////////////
  Uri _notificationUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _notification(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderNotificationUpdate(int id) =>
      _notificationUpdateRequest(path: 'notification/$id/order');
  Uri destroyNotificationUpdateRequest(int id) =>
      _notificationUpdateRequest(path: '$id/destroy');
  Uri showNotificationUpdateRequest(int id) =>
      _notificationUpdateRequest(path: '$id/show');
  Uri getNotificationUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _notificationUpdateRequest(
        path: 'index',
        queryParameters: params,
      );

  /////////////////
  /////qr code/////
  /////////////////
  Uri _qrCode({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: "qrCode/$path",
        queryParameters: queryParameters,
      );
  Uri indexQrCodes(
    Map<String, dynamic> params,
  ) =>
      _qrCode(
        path: 'index',
        queryParameters: params,
      );
  //////////////////////////////
  /////qr code buy requests/////
  //////////////////////////////
  Uri _qrCodeBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _qrCode(
        path: "buyRequest/$path",
        queryParameters: queryParameters,
      );
  Uri indexQrCodeBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _qrCodeBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyQrCodeBuyRequest(int id) => _qrCodeBuyRequest(path: '$id/destroy');
  Uri showQrCodeBuyRequest(int id) => _qrCodeBuyRequest(path: '$id/show');

  /////////////////
  ////Mini Menu////
  /////////////////
  Uri _miniMenu({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _mobileUri(
        path: 'miniMenu/$path',
        queryParameters: queryParameters,
      );
  Uri indexInactiveMiniMenuSubscriptions(Map<String, dynamic> params) =>
      _miniMenu(
        path: "subscription/indexInactive",
        queryParameters: params,
      );
  Uri reactivateMiniMenu({
    required int subscriptionId,
    required int miniMenuId,
  }) =>
      _miniMenu(
        path: "subscription/$subscriptionId/miniMenu/$miniMenuId/reactivate",
      );
  Uri extendMiniMenu({
    required int subscriptionId,
    required int miniMenuId,
  }) =>
      _miniMenu(
        path: "subscription/$subscriptionId/miniMenu/$miniMenuId/extend",
      );
  Uri showMiniMenuForUser({
    required int id,
  }) =>
      _miniMenu(path: "$id/showForUser");
  Uri indexUserMiniMenus(Map<String, dynamic> params) => _miniMenu(
        path: "indexForUser",
        queryParameters: params,
      );
  Uri indexMiniMenus(Map<String, dynamic> params) => _miniMenu(
        path: "index",
        queryParameters: params,
      );
  ///////////////////////////
  ///Mini Menu buy request///
  ///////////////////////////
  Uri _miniMenuBuyRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _miniMenu(
        path: 'buyRequest/$path',
        queryParameters: queryParameters,
      );
  Uri indexMiniMenuBuyRequests(
    Map<String, dynamic> params,
  ) =>
      _miniMenuBuyRequest(
        path: 'index',
        queryParameters: params,
      );
  Uri destroyMiniMenuBuyRequest(int id) =>
      _miniMenuBuyRequest(path: '$id/destroy');
  Uri showMiniMenuBuyRequest(int id) => _miniMenuBuyRequest(path: '$id/show');
  ///////////////////////////////
  ///Mini Menu upload requests///
  ///////////////////////////////
  Uri _miniMenuUploadRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _miniMenu(
        path: "uploadRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderMiniMenuUpload(int subscriptionId) => _miniMenuUploadRequest(
        path: "subscription/$subscriptionId/order",
      );
  Uri destroyMiniMenuUploadRequest(int id) =>
      _miniMenuUploadRequest(path: '$id/destroy');
  Uri showMiniMenuUploadRequest(int id) =>
      _miniMenuUploadRequest(path: '$id/show');
  Uri indexMiniMenuUploadRequest(
    Map<String, dynamic> params,
  ) =>
      _miniMenuUploadRequest(
        path: 'index',
        queryParameters: params,
      );
  ///////////////////////////////
  ///Mini Menu update requests///
  ///////////////////////////////
  Uri _miniMenuUpdateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _miniMenu(
        path: "updateRequest/$path",
        queryParameters: queryParameters,
      );
  Uri orderMiniMenuUpdate(int id) =>
      _miniMenuUpdateRequest(path: 'miniMenu/$id/order');
  Uri destroyMiniMenuUpdateRequest(int id) =>
      _miniMenuUpdateRequest(path: '$id/destroy');
  Uri showMiniMenuUpdateRequest(int id) =>
      _miniMenuUpdateRequest(path: '$id/show');
  Uri indexMiniMenuUpdateRequest(
    Map<String, dynamic> params,
  ) =>
      _miniMenuUpdateRequest(path: 'index', queryParameters: params);
  //////////////
  ///Category///
  //////////////
  Uri indexCategoriesByCity(Map<String, dynamic> params) => _mobileUri(
        path: 'category/index',
        queryParameters: params,
      );

  ///
  Uri homeAds() => _mobileUri(path: 'homeAd/showForMobile');
}
