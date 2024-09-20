import 'package:flutter/material.dart';

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
      Step(
        title: const Text('Request Placed'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Amit Kumar'),
            SizedBox(height: 5),
            Text('Comment: Lorem ipsum dolor sit amet consectetur.'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Regional Manager'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Kartik Sinha'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('COC'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Aarav Gupta'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Logistics'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Abhinav Saxena'),
          ],
        ),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: const Text('Pending Approval'),
        content: const Text('Pending...'),
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
                  style: TextStyle(fontSize: 16, color: Color(0xFF7D8286)),
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
                                color: const Color(
                                  0xFFD5D5D5,
                                ),
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
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Pickup Address',
                                      'Gurugram NIT',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Pickup Pincode',
                                      '122012',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Destination Address',
                                      'CIT Jaipur',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Destination Pincode',
                                      '302023',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Approx Weight',
                                      '2 Kg/L',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Invoice Value',
                                      '1',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Mode Of Transportation',
                                      'Land - Part Truck Load',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
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
                                color: const Color(0xFFD5D5D5),
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
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Contact Person Name',
                                      'Surendar Singh',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Contact Person Mobile No.',
                                      '9081234521',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow('Attachment', 'xls.file',
                                      Colors.red, const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Number Of Packages',
                                      '120',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Package Dimensions',
                                      '4X4',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Document/PO Number',
                                      'PO10120',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
                                  _buildRequestInfoRow(
                                      'Special Instructions',
                                      'TEST',
                                      const Color(0xFF272E35),
                                      const Color(0xFF525252)),
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
