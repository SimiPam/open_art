import 'package:open_art/shared/models/layout_model.dart';
import 'package:rxdart/rxdart.dart';

class LayoutService {
  PublishSubject<LayoutConfig> layout$ = PublishSubject<LayoutConfig>();
  PublishSubject<bool> bottomInset$ = PublishSubject<bool>();

  // used to displayed positioned items on specific regions of the screen as an overlay.
  // Example includes: menu options in dashboard, side sticker contents in most pages
  List<DashboardOverlayConfig> _activeOverlay = <DashboardOverlayConfig>[];
  PublishSubject<List<DashboardOverlayConfig>> activeOverlay$ =
      PublishSubject<List<DashboardOverlayConfig>>();

  PublishSubject<ProfileLayoutConfig> profileMenu$ =
      PublishSubject<ProfileLayoutConfig>();

  void updateMenu(ProfileLayoutConfig cfg) {
    profileMenu$.add(cfg);
  }

  void updateLayout(LayoutConfig cfg) {
    layout$.add(cfg);
  }

  // used to add overlay content to list of already existing ones on the screen
  void addOverlay(DashboardOverlayConfig item) {
    final List<DashboardOverlayConfig> list =
        _activeOverlay ?? <DashboardOverlayConfig>[];

    final DashboardOverlayConfig already = list.firstWhere(
      (DashboardOverlayConfig element) => element.id == item.id,
      orElse: () => null,
    );

    if (already == null) {
      list.add(item);
    } else {
      throw Exception('${item.id} is already in overlay list');
    }

    _activeOverlay = list;
    activeOverlay$.add(list);
  }

  // removes overlay items from list entirely to free up memory and reduce list size
  void removeOverlay(String id) {
    final List<DashboardOverlayConfig> list =
        _activeOverlay ?? <DashboardOverlayConfig>[];

    list.removeWhere((DashboardOverlayConfig element) => element.id == id);

    _activeOverlay = list;
    activeOverlay$.add(list);
  }
}
