import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../app_bar..dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: settings.currency,
              items: ['৳', '\$', '€', '₹']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) settings.setCurrency(value);
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final controller = TextEditingController(text: settings.budgetGoal.toString());
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Set Budget Limit"),
                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                      TextButton(
                        onPressed: () {
                          final val = double.tryParse(controller.text);
                          if (val != null) settings.setBudget(val);
                          Navigator.pop(context);
                        },
                        child: const Text("Set"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Set Budget Limit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 30),

            SwitchListTile(
              value: settings.isDarkMode,
              onChanged: (value) => settings.toggleTheme(value),
              title: Text(settings.isDarkMode ? "Dark Mode" : "Light Mode"),
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
//
// import '../app_bar..dart';
//
// class SettingsScreen extends StatefulWidget {
//   final String currency;
//   final double budgetLimit;
//   final bool isDarkMode;
//   final Function(String) onCurrencyChanged;
//   final Function(double) onBudgetChanged;
//   final Function(bool) onThemeChanged;
//
//   const SettingsScreen({
//     super.key,
//     required this.currency,
//     required this.budgetLimit,
//     required this.isDarkMode,
//     required this.onCurrencyChanged,
//     required this.onBudgetChanged,
//     required this.onThemeChanged,
//   });
//
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               value: widget.currency,
//               items: ['৳', '\$', '€', '₹']
//                   .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                   .toList(),
//               onChanged: (value) {
//                 if (value != null) widget.onCurrencyChanged(value);
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: () {
//                 final controller = TextEditingController(text: widget.budgetLimit.toString());
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                     title: const Text("Set Budget Limit"),
//                     content: TextField(
//                       controller: controller,
//                       keyboardType: TextInputType.number,
//                     ),
//                     actions: [
//                       TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//                       TextButton(
//                         onPressed: () {
//                           final val = double.tryParse(controller.text);
//                           if (val != null) widget.onBudgetChanged(val);
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Set"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 foregroundColor: Colors.white, // Text color on the button
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text("Set Budget Limit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//             ),
//             const SizedBox(height: 30),
//             SwitchListTile(
//               value: widget.isDarkMode,
//               onChanged: (value) {
//                 // This calls the function in the parent widget to update the theme.
//                 widget.onThemeChanged(value);
//               },
//
//               title: Text(widget.isDarkMode ? "Dark Mode" : "Light Mode"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }