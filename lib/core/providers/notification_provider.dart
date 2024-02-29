import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;
  int currentPage = 1;
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  Future<void> getNotifications({
    bool isRefresh = false,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      if (isRefresh) {
        currentPage = 1;
        isLastPage = false;
      }

      _notifications.clear();

      var response =
          await Endpoint.urlNotification(page: currentPage.toString());
      if (response['code'] == 200) {
        for (var notification in response['data']['data']) {
          _notifications.add(NotificationModel.fromJson(notification));
        }

        if (response['data']['next_page_url'] == null) {
          isLastPage = true;
        } else {
          currentPage++;
        }

        isLoading = false;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
