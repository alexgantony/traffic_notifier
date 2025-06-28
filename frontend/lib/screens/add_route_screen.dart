import 'package:flutter/material.dart';
import 'package:frontend/models/route_info.dart';
import 'package:frontend/theme/app_color_scheme.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({super.key});

  @override
  State<AddRouteScreen> createState() => _AddRouteScreen();
}

class _AddRouteScreen extends State<AddRouteScreen> {
  late TextEditingController labelController;
  late TextEditingController sourceController;
  late TextEditingController destinationController;
  late TextEditingController delayController;
  TimeOfDay? selectedTime;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController();
    sourceController = TextEditingController();
    destinationController = TextEditingController();
    delayController = TextEditingController();
    selectedTime = null;
  }

  @override
  void dispose() {
    labelController.dispose();
    sourceController.dispose();
    destinationController.dispose();
    delayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.heading),
        title: Text(
          'Add New Route',
          style: TextStyle(color: AppColors.heading),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Route Label
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: labelController,
                    decoration: const InputDecoration(
                      labelText: 'Route Label',
                      labelStyle: TextStyle(color: AppColors.heading),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter route label';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Source Address
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Source Address',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter source address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Destination Address
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: destinationController,
                    decoration: const InputDecoration(
                      labelText: 'Destination Address',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter destination address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Delay Threshold
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: delayController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Notify if delay exceeds (mins)',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter delay threshold';
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null || parsed < 1) {
                        return 'Enter a valid number greater than 0';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Alert Time picker
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: AppColors.heading,
                            onPrimary: Colors.white,
                            surface: AppColors.card,
                            onSurface: AppColors.heading,
                          ),
                          dialogTheme: DialogThemeData(
                            backgroundColor: AppColors.card,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.heading,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Check at',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.access_time),
                        ),
                        controller: TextEditingController(
                          text: selectedTime != null
                              ? selectedTime!.format(context)
                              : '',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Add Route'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.heading,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newRoute = RouteDetailInfo(
                        id: 0,
                        routeLabel: labelController.text.trim(),
                        sourceAddress: sourceController.text.trim(),
                        destinationAddress: destinationController.text.trim(),
                        delayThreshold: int.parse(delayController.text.trim()),
                        alertTime: selectedTime,
                      );
                      Navigator.pop(context, newRoute);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Route updated successfully'),
                      //     ),
                      //   );
                      // }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
