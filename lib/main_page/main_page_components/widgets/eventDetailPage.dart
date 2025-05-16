import 'package:flutter/material.dart';
import 'cartPage.dart';

class EventDetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String tag;

  const EventDetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.tag,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final Set<String> selectedItems = {};
  final Set<String> savedItems = {};
  final Map<String, bool> subCategoryExpanded = {};
  bool mainCourseExpanded = false;
  final Map<String, bool> simpleCategoryExpanded = {
    "Starters": false,
    "Desserts": false,
    "Beverages": false,
  };

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void saveSelections() {
    setState(() {
      savedItems.addAll(selectedItems);
      selectedItems.clear();

      // Collapse all expanded dropdowns
      mainCourseExpanded = false; // Collapse Main Course dropdown
      subCategoryExpanded.updateAll(
        (key, value) => false,
      ); // Collapse subcategories
      simpleCategoryExpanded.updateAll(
        (key, value) => false,
      ); // Collapse simple categories
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Items saved!")));
  }

  Widget buildMainCourseDropdown() {
    final Map<String, List<String>> mainCourse = {
      "Dal": ["Dal Tadka", "Dal Makhani", "Moong Dal"],
      "Rice": ["Jeera Rice", "Veg Pulao", "Biryani"],
      "Veg": ["Paneer Butter Masala", "Mix Veg", "Kadhai Mushroom"],
      "Non-Veg": ["Butter Chicken", "Egg Curry", "Mutton Rogan Josh"],
      "Roti": ["Butter Naan", "Tandoori Roti", "Missi Roti"],
    };

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3E3E3E), Color(0xFF2A2A2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          initiallyExpanded: mainCourseExpanded,
          onExpansionChanged: (val) => setState(() => mainCourseExpanded = val),
          iconColor: Colors.amberAccent,
          collapsedIconColor: Colors.white54,
          title: Text(
            "🍛 Main Course",
            style: TextStyle(
              color: Colors.amberAccent.shade200,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          children:
              mainCourse.entries.map((entry) {
                final isExpanded = subCategoryExpanded[entry.key] ?? false;
                return ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 20, right: 10),
                  title: Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white54,
                  ),
                  onExpansionChanged: (val) {
                    setState(() {
                      subCategoryExpanded[entry.key] = val;
                    });
                  },
                  children: [
                    Container(
                      color: const Color(0xFF2A2A2A),
                      child: Column(
                        children:
                            entry.value.map((item) {
                              return ListTile(
                                title: Text(
                                  item,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Icon(
                                  selectedItems.contains(item)
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color:
                                      selectedItems.contains(item)
                                          ? Colors.greenAccent
                                          : Colors.white54,
                                ),
                                onTap: () => toggleSelection(item),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget buildSimpleCategory(String title, List<String> items, Color color) {
    final String categoryKey = title.replaceAll(
      RegExp(r'[^\w]'),
      '',
    ); // to use as key safely
    final bool isExpanded = simpleCategoryExpanded[categoryKey] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: (val) {
          setState(() {
            simpleCategoryExpanded[categoryKey] = val;
          });
        },
        iconColor: Colors.white,
        collapsedIconColor: Colors.white70,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        children: [
          Container(
            color: const Color(0xFF2A2A2A),
            child: Column(
              children:
                  items.map((item) {
                    return ListTile(
                      title: Text(
                        item,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        selectedItems.contains(item)
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            selectedItems.contains(item)
                                ? Colors.greenAccent
                                : Colors.white54,
                      ),
                      onTap: () => toggleSelection(item),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => CartPage(
                        tag: widget.tag,
                        selectedItems: savedItems.toList(),
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: widget.tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Choose Your Menu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          buildSimpleCategory("🥗 Starters", [
            "Paneer Tikka",
            "Chicken Tikka",
            "Spring Rolls",
            "Veg Manchurian",
          ], Colors.teal),
          buildMainCourseDropdown(),
          buildSimpleCategory("🍰 Desserts", [
            "Gulab Jamun",
            "Rasgulla",
            "Kheer",
            "Brownie",
            "Ice Cream",
            "Jalebi",
          ], Colors.pinkAccent),
          buildSimpleCategory("🥤 Beverages", [
            "Cold Drink",
            "Mocktail",
            "Lassi",
            "Tea",
            "Coffee",
            "Juice",
          ], Colors.deepOrangeAccent),

          // Save Button
          if (selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton.icon(
                onPressed: saveSelections,
                icon: const Icon(Icons.save),
                label: const Text("Save Selection"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'cartPage.dart';

// class EventDetailPage extends StatefulWidget {
//   final String title;
//   final String imagePath;
//   final String tag;

//   const EventDetailPage({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     required this.tag,
//   });

//   @override
//   State<EventDetailPage> createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   final Set<String> selectedItems = {};
//   final Set<String> savedItems = {};
//   final Map<String, bool> subCategoryExpanded = {};
//   bool mainCourseExpanded = false;

//   void toggleSelection(String item) {
//     setState(() {
//       if (selectedItems.contains(item)) {
//         selectedItems.remove(item);
//       } else {
//         selectedItems.add(item);
//       }
//     });
//   }

//   void saveSelections() {
//     setState(() {
//       savedItems.addAll(selectedItems);
//       selectedItems.clear(); // optional
//     });

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("Items saved!")));
//   }

//   Widget buildMainCourseDropdown() {
//     final Map<String, List<String>> mainCourse = {
//       "Dal": ["Dal Tadka", "Dal Makhani", "Moong Dal"],
//       "Rice": ["Jeera Rice", "Veg Pulao", "Biryani"],
//       "Veg": ["Paneer Butter Masala", "Mix Veg", "Kadhai Mushroom"],
//       "Non-Veg": ["Butter Chicken", "Egg Curry", "Mutton Rogan Josh"],
//       "Roti": ["Butter Naan", "Tandoori Roti", "Missi Roti"],
//     };

//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF3E3E3E), Color(0xFF2A2A2A)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ExpansionTile(
//           initiallyExpanded: mainCourseExpanded,
//           onExpansionChanged: (val) => setState(() => mainCourseExpanded = val),
//           iconColor: Colors.amberAccent,
//           collapsedIconColor: Colors.white54,
//           title: Text(
//             "🍛 Main Course",
//             style: TextStyle(
//               color: Colors.amberAccent.shade200,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           children:
//               mainCourse.entries.map((entry) {
//                 final isExpanded = subCategoryExpanded[entry.key] ?? false;
//                 return ExpansionTile(
//                   tilePadding: const EdgeInsets.only(left: 20, right: 10),
//                   title: Text(
//                     entry.key,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   trailing: Icon(
//                     isExpanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: Colors.white54,
//                   ),
//                   onExpansionChanged: (val) {
//                     setState(() {
//                       subCategoryExpanded[entry.key] = val;
//                     });
//                   },
//                   children: [
//                     Container(
//                       color: const Color(0xFF2A2A2A),
//                       child: Column(
//                         children:
//                             entry.value.map((item) {
//                               return ListTile(
//                                 title: Text(
//                                   item,
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                                 trailing: Icon(
//                                   selectedItems.contains(item)
//                                       ? Icons.check_circle
//                                       : Icons.radio_button_unchecked,
//                                   color:
//                                       selectedItems.contains(item)
//                                           ? Colors.greenAccent
//                                           : Colors.white54,
//                                 ),
//                                 onTap: () => toggleSelection(item),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ],
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }

//   Widget buildSimpleCategory(String title, List<String> items, Color color) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ExpansionTile(
//         iconColor: Colors.white,
//         collapsedIconColor: Colors.white70,
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         children: [
//           Container(
//             color: const Color(0xFF2A2A2A),
//             child: Column(
//               children:
//                   items.map((item) {
//                     return ListTile(
//                       title: Text(
//                         item,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       trailing: Icon(
//                         selectedItems.contains(item)
//                             ? Icons.check_circle
//                             : Icons.radio_button_unchecked,
//                         color:
//                             selectedItems.contains(item)
//                                 ? Colors.greenAccent
//                                 : Colors.white54,
//                       ),
//                       onTap: () => toggleSelection(item),
//                     );
//                   }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E1E1E),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: Text(
//           widget.title,
//           style: const TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart, color: Colors.white),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => CartPage(
//                         tag: widget.tag,
//                         selectedItems: savedItems.toList(),
//                       ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Hero(
//             tag: widget.tag,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(widget.imagePath, fit: BoxFit.cover),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Choose Your Menu",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           buildSimpleCategory("🥗 Starters", [
//             "Paneer Tikka",
//             "Chicken Tikka",
//             "Spring Rolls",
//             "Veg Manchurian",
//           ], Colors.teal),
//           buildMainCourseDropdown(),
//           buildSimpleCategory("🍰 Desserts", [
//             "Gulab Jamun",
//             "Rasgulla",
//             "Kheer",
//             "Brownie",
//             "Ice Cream",
//             "Jalebi",
//           ], Colors.pinkAccent),
//           buildSimpleCategory("🥤 Beverages", [
//             "Cold Drink",
//             "Mocktail",
//             "Lassi",
//             "Tea",
//             "Coffee",
//             "Juice",
//           ], Colors.deepOrangeAccent),

//           // Save Button
//           if (selectedItems.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 12),
//               child: ElevatedButton.icon(
//                 onPressed: saveSelections,
//                 icon: const Icon(Icons.save),
//                 label: const Text("Save Selection"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.greenAccent.shade700,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// import 'cartPage.dart';

// class EventDetailPage extends StatefulWidget {
//   final String title;
//   final String imagePath;
//   final String tag;

//   const EventDetailPage({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     required this.tag,
//   });

//   @override
//   State<EventDetailPage> createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   final Set<String> selectedItems = {};
//   final Map<String, bool> subCategoryExpanded = {};
//   bool mainCourseExpanded = false;

//   void toggleSelection(String item) {
//     setState(() {
//       if (selectedItems.contains(item)) {
//         selectedItems.remove(item);
//       } else {
//         selectedItems.add(item);
//       }
//     });
//   }

//   Widget buildItemList(List<String> items, String category) {
//     List<String> selectedCategoryItems =
//         selectedItems
//             .where((item) => items.contains(item))
//             .toList(); // Filter selected items based on category

//     return selectedCategoryItems.isEmpty
//         ? Container() // If no items selected in category, return empty container
//         : Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 category,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Column(
//                 children:
//                     selectedCategoryItems.map((item) {
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.greenAccent.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           item,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       );
//                     }).toList(),
//               ),
//             ],
//           ),
//         );
//   }

//   Widget buildMainCourseDropdown() {
//     final Map<String, List<String>> mainCourse = {
//       "Dal": ["Dal Tadka", "Dal Makhani", "Moong Dal"],
//       "Rice": ["Jeera Rice", "Veg Pulao", "Biryani"],
//       "Veg": ["Paneer Butter Masala", "Mix Veg", "Kadhai Mushroom"],
//       "Non-Veg": ["Butter Chicken", "Egg Curry", "Mutton Rogan Josh"],
//       "Roti": ["Butter Naan", "Tandoori Roti", "Missi Roti"],
//     };

//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF3E3E3E), Color(0xFF2A2A2A)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ExpansionTile(
//           initiallyExpanded: mainCourseExpanded,
//           onExpansionChanged: (val) => setState(() => mainCourseExpanded = val),
//           iconColor: Colors.amberAccent,
//           collapsedIconColor: Colors.white54,
//           title: Text(
//             "🍛 Main Course",
//             style: TextStyle(
//               color: Colors.amberAccent.shade200,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           children:
//               mainCourse.entries.map((entry) {
//                 final isExpanded = subCategoryExpanded[entry.key] ?? false;
//                 return ExpansionTile(
//                   tilePadding: const EdgeInsets.only(left: 20, right: 10),
//                   title: Text(
//                     entry.key,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   trailing: Icon(
//                     isExpanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: Colors.white54,
//                   ),
//                   onExpansionChanged: (val) {
//                     setState(() {
//                       subCategoryExpanded[entry.key] = val;
//                     });
//                   },
//                   children: [
//                     Container(
//                       color: const Color(0xFF2A2A2A),
//                       child: Column(
//                         children:
//                             entry.value.map((item) {
//                               return ListTile(
//                                 title: Text(
//                                   item,
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                                 trailing: Icon(
//                                   selectedItems.contains(item)
//                                       ? Icons.check_circle
//                                       : Icons.radio_button_unchecked,
//                                   color:
//                                       selectedItems.contains(item)
//                                           ? Colors.greenAccent
//                                           : Colors.white54,
//                                 ),
//                                 onTap: () => toggleSelection(item),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ],
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }

//   Widget buildSimpleCategory(String title, List<String> items, Color color) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ExpansionTile(
//         iconColor: Colors.white,
//         collapsedIconColor: Colors.white70,
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         children: [
//           Container(
//             color: const Color(0xFF2A2A2A),
//             child: Column(
//               children:
//                   items.map((item) {
//                     return ListTile(
//                       title: Text(
//                         item,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       trailing: Icon(
//                         selectedItems.contains(item)
//                             ? Icons.check_circle
//                             : Icons.radio_button_unchecked,
//                         color:
//                             selectedItems.contains(item)
//                                 ? Colors.greenAccent
//                                 : Colors.white54,
//                       ),
//                       onTap: () => toggleSelection(item),
//                     );
//                   }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showSelectedItemsSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2E2E2E),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder:
//           (context) => Padding(
//             padding: const EdgeInsets.all(16),
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 const Text(
//                   "Selected Items",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Divider(color: Colors.white24),
//                 if (selectedItems.isEmpty)
//                   const Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text(
//                       "No items selected.",
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   )
//                 else
//                   ...selectedItems.map(
//                     (item) => ListTile(
//                       title: Text(item, style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E1E1E),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(color: Colors.white),
//         title: Text(
//           widget.title,
//           style: const TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart, color: Colors.white),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => CartPage(selectedItems: selectedItems.toList()),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Hero(
//             tag: widget.tag,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(widget.imagePath, fit: BoxFit.cover),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Choose Your Menu",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           buildSimpleCategory("🥗 Starters", [
//             "Paneer Tikka",
//             "Chicken Tikka",
//             "Spring Rolls",
//             "Veg Manchurian",
//           ], Colors.teal),
//           buildMainCourseDropdown(),
//           buildSimpleCategory("🍰 Desserts", [
//             "Gulab Jamun",
//             "Rasgulla",
//             "Kheer",
//             "Brownie",
//             "Ice Cream",
//             "Jalebi",
//           ], Colors.pinkAccent),
//           buildSimpleCategory("🥤 Beverages", [
//             "Cold Drink",
//             "Mocktail",
//             "Lassi",
//             "Tea",
//             "Coffee",
//             "Juice",
//           ], Colors.deepOrangeAccent),
//         ],
//       ),
//     );
//   }
// }
