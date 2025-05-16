import 'package:chef_app/main_page/main_page_components/widgets/selectChef.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String tag;
  final List<String> selectedItems;

  const CartPage({super.key, required this.tag, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> itemCategoryMap = {
      "Paneer Tikka": "Starters",
      "Chicken Tikka": "Starters",
      "Spring Rolls": "Starters",
      "Veg Manchurian": "Starters",
      "Dal Tadka": "Main Course",
      "Dal Makhani": "Main Course",
      "Moong Dal": "Main Course",
      "Jeera Rice": "Main Course",
      "Veg Pulao": "Main Course",
      "Biryani": "Main Course",
      "Paneer Butter Masala": "Main Course",
      "Mix Veg": "Main Course",
      "Kadhai Mushroom": "Main Course",
      "Butter Chicken": "Main Course",
      "Egg Curry": "Main Course",
      "Mutton Rogan Josh": "Main Course",
      "Butter Naan": "Main Course",
      "Tandoori Roti": "Main Course",
      "Missi Roti": "Main Course",
      "Gulab Jamun": "Desserts",
      "Rasgulla": "Desserts",
      "Kheer": "Desserts",
      "Brownie": "Desserts",
      "Ice Cream": "Desserts",
      "Jalebi": "Desserts",
      "Cold Drink": "Beverages",
      "Mocktail": "Beverages",
      "Lassi": "Beverages",
      "Tea": "Beverages",
      "Coffee": "Beverages",
      "Juice": "Beverages",
    };

    final Map<String, List<String>> groupedItems = {};
    for (var item in selectedItems) {
      final category = itemCategoryMap[item] ?? "Other";
      groupedItems.putIfAbsent(category, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🏷️ TAG DISPLAY
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFff9a9e), Color(0xFFfad0c4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Event Tag: ${tag.toUpperCase()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 📦 ITEM LIST
            Expanded(
              child:
                  groupedItems.isEmpty
                      ? const Center(
                        child: Text(
                          "No items saved.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                      : ListView(
                        children:
                            groupedItems.entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ...entry.value.map(
                                      (item) => Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent.withOpacity(
                                            0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
            ),

            // 🍽️ BUTTON TO CHEF PAGE
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ChefSelectionPage(selectedItems: selectedItems),
                  ),
                );
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text("Chef's Selection View"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
