import 'package:get/get.dart';
import '../../app/base_api_service.dart';
import 'court_model.dart';

class CourtController extends GetxController {
  var courts = <Court>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var searchQuery = ''.obs;
  var filterStatus = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourts();
  }

  Future<void> fetchCourts() async {
    isLoading.value = true;
    error.value = '';
    try {
      final api = BaseApiService(baseUrl: 'https://api.bicharachar.com/api/');
      final response = await api.get('courts');

      if (response != null && response['success'] == true && response['list'] != null) {
        courts.value = List<Court>.from(
          (response['list'] as List).map((e) => Court.fromJson(e)),
        );
      } else {
        error.value = response['message'] ?? 'Failed to load courts.';
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  List<Court> get filteredCourts {
    final query = searchQuery.value.toLowerCase();
    final status = filterStatus.value;
    return courts.where((court) {
      final matchesQuery = query.isEmpty ||
        court.name.toLowerCase().contains(query) ||
        (court.address?.toLowerCase().contains(query) ?? false) ||
        (court.phone?.toLowerCase().contains(query) ?? false);
      final matchesStatus = status == 'All' || (court.status?.toLowerCase() == status.toLowerCase());
      return matchesQuery && matchesStatus;
    }).toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void updateStatus(String value) {
    filterStatus.value = value;
  }
}
