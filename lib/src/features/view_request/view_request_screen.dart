import 'package:flutter/material.dart';

import '../../app_configs/app_colors.dart';

class ViewRequestPage extends StatefulWidget {
  const ViewRequestPage({super.key});

  @override
  State<ViewRequestPage> createState() => _ViewRequestPageState();
}

class _ViewRequestPageState extends State<ViewRequestPage> {
  final List<Step> _steps = [];

  @override
  void initState() {
    super.initState();
    _buildSteps();
  }

  void _buildSteps() {
    _steps.addAll([
      const Step(
        title: Text('Request Placed'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amit Kumar'),
            SizedBox(height: 5),
            Text('Comment: Lorem ipsum dolor sit amet consectetur.'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      const Step(
        title: Text('Regional Manager'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kartik Sinha'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      const Step(
        title: Text('COC'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aarav Gupta'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      const Step(
        title: Text('Logistics'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Abhinav Saxena'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      const Step(
        title: Text('Pending Approval'),
        content: Text('Pending...'),
        isActive: true,
        state: StepState.indexed, // Default step state for pending
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [
                Text(
                  "My Requests",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.chevron_right),
                Text(
                  "View Request",
                  style: TextStyle(fontSize: 16, color: AppColors.dark1Grey),
                ),
              ]),
              const Text(
                'View Request',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Request Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 326,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: AppColors.dark2Grey
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  _buildRequestInfoRow(
                                      'Section',
                                      'Dgt.Eng&Test. Dev - Rahul Bharadwaj',
                                      AppColors.lightGrey,
                                      AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Pickup Address',
                                      'Gurugram NIT',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Pickup Pincode',
                                      '122012',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Destination Address',
                                      'CIT Jaipur',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,),
                                  _buildRequestInfoRow(
                                      'Destination Pincode',
                                      '302023',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Approx Weight',
                                      '2 Kg/L',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Invoice Value',
                                      '1',
                                      AppColors.lightGrey,
                                      AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Mode Of Transportation',
                                      'Land - Part Truck Load',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pick Up & Package Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 326,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: AppColors.dark2Grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 16.0, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRequestInfoRow(
                                      'Pickup Date',
                                      '18 July 2024',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Contact Person Name',
                                      'Surendar Singh',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Contact Person Mobile No.',
                                      '9081234521',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow('Attachment', 'xls.file',
                                      Colors.red,
                                      AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Number Of Packages',
                                      '120',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Package Dimensions',
                                      '4X4',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Document/PO Number',
                                      'PO10120',
                                       AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                  _buildRequestInfoRow(
                                      'Special Instructions',
                                      'TEST',
                                      AppColors.lightGrey,
                                    AppColors.darkGrey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Request Tracking',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400, // Limit the height of the Stepper
                child: Stepper(
                  steps: _steps,
                  currentStep: 4,
                  onStepTapped: (step) {
                    setState(() {
                      _steps[step] = Step(
                        title: _steps[step].title,
                        content: _steps[step].content,
                        isActive: _steps[step].isActive,
                        state: StepState.complete,
                      );
                    });
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestInfoRow(
      String label, String value, Color? color, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            label,
            style: TextStyle(color: textColor),
          )),
          const Text(":"),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            value,
            style: TextStyle(color: color),
          )),
        ],
      ),
    );
  }
}
