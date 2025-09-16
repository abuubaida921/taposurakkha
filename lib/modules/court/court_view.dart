import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'court_controller.dart';
import 'court_model.dart';

class CourtView extends StatelessWidget {
  const CourtView({super.key});

  @override
  Widget build(BuildContext context) {
    final CourtController controller = Get.put(CourtController());
    return Scaffold(
      appBar: AppBar(title: const Text('Court')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search courts',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.updateSearch,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Status: '),
                Obx(() => DropdownButton<String>(
                  value: controller.filterStatus.value,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All')),
                    DropdownMenuItem(value: 'active', child: Text('Active')),
                    DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.updateStatus(value);
                  },
                )),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.error.isNotEmpty) {
                  return Center(child: Text(controller.error.value, style: const TextStyle(color: Colors.red)));
                }
                if (controller.filteredCourts.isEmpty) {
                  return const Center(child: Text('No courts available.'));
                }
                return ListView.builder(
                  itemCount: controller.filteredCourts.length,
                  itemBuilder: (context, index) {
                    final Court court = controller.filteredCourts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(court.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                                Text(court.status ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            if (court.address != null && court.address!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.blueGrey),
                                    const SizedBox(width: 4),
                                    Expanded(child: Text(court.address!)),
                                  ],
                                ),
                              ),
                            if (court.phone != null && court.phone!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text('Phone: ${court.phone!}', style: const TextStyle(fontSize: 13)),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.info_outline, size: 18),
                                    label: const Text('Details'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(90, 36),
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text(court.name),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (court.address != null && court.address!.isNotEmpty)
                                                  Text('Location: ${court.address!}'),
                                                if (court.phone != null && court.phone!.isNotEmpty)
                                                  Text('Phone: ${court.phone!}'),
                                                if (court.email != null && court.email!.isNotEmpty)
                                                  Text('Email: ${court.email!}'),
                                                if (court.about != null && court.about!.isNotEmpty)
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Text('About: ${court.about!}'),
                                                  ),
                                                if (court.governmentRegistrationNumber != null && court.governmentRegistrationNumber!.isNotEmpty)
                                                  Text('Govt. Reg. No: ${court.governmentRegistrationNumber!}'),
                                                if (court.status != null && court.status!.isNotEmpty)
                                                  Text('Status: ${court.status!}'),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(ctx).pop(),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
