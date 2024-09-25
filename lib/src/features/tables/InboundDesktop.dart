import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';

class InboundDesktop extends StatefulWidget {
  const InboundDesktop({super.key});

  @override
  State<InboundDesktop> createState() => _InboundDesktopState();
}

class _InboundDesktopState extends State<InboundDesktop> {
  // Dropdown values
  String? _section;

  String? _modeOfTransportation;

  // Text field controllers
  final _pickupAddressController = TextEditingController();

  final _pickupPincodeController = TextEditingController();

  final _destinationAddressController = TextEditingController();

  final _destinationPincodeController = TextEditingController();

  final _approxWeightController = TextEditingController();

  final _contactPersonNameController = TextEditingController();

  final _contactPersonMobileController = TextEditingController();

  final _supplierNameController = TextEditingController();

  final _numberOfPackagesController = TextEditingController();

  final _packageDimensionsController = TextEditingController();

  final _documentPoNumberController = TextEditingController();

  final _specialInstructionsController = TextEditingController();

  final _invoiceValueController = TextEditingController();

  // Date picker
  DateTime? _pickupDate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Inbound Request
        const Row(
          children: [
            Text("Dashboard"),
            Icon(Icons.arrow_forward_ios, weight: 10, size: 10),
            Text(
              "Edit Request",
              style: TextStyle(color: Color(0xFF7D8286), fontSize: 16),
            )
          ],
        ),
        const Text(
          'Edit Inbound Request',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.dark2Grey,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transport Details

              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transport Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Section',
                                  style: TextStyle(fontSize: 12),
                                ),
                                DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Select Section',
                                  ),
                                  value: _section,
                                  onChanged: (value) {
                                    setState(() {
                                      _section = value;
                                    });
                                  },
                                  items: [
                                    'Section 1',
                                    'Section 2',
                                    'Section 3',
                                  ].map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pickup Address',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _pickupAddressController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pickup Pincode',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _pickupPincodeController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Destination Address',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _destinationAddressController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Destination Pincode',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _destinationPincodeController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Approx Weight',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '0 kgft',
                                  ),
                                  controller: _approxWeightController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Invoice Value',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _invoiceValueController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mode of Transportation',
                                  style: TextStyle(fontSize: 12),
                                ),
                                DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Select mode',
                                  ),
                                  value: _modeOfTransportation,
                                  onChanged: (value) {
                                    setState(() {
                                      _modeOfTransportation = value;
                                    });
                                  },
                                  items: [
                                    'Mode 1',
                                    'Mode 2',
                                    'Mode 3',
                                  ].map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pickup Date',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_today),
                                    hintText: 'dd-mm-yyyy',
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                    );
                                    if (date != null) {
                                      setState(() {
                                        _pickupDate = date;
                                      });
                                    }
                                  },
                                  controller: TextEditingController(
                                      text: _pickupDate?.toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pickup Details
              const Text(
                'Pickup Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Person Name',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: _contactPersonNameController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Person Mobile Number',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: _contactPersonMobileController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Supplier Name',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: _supplierNameController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Package Details
              const Text(
                'Package Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Number of Packages',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _numberOfPackagesController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Package Dimensions',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _packageDimensionsController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Special Instructions',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _specialInstructionsController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Document/PO Number',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _documentPoNumberController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Attachment',
                                  style: TextStyle(fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Add your file upload logic here
                                    // For example, you can use the `file_picker` package to pick a file
                                    // FilePickerResult? result = await FilePicker.platform.pickFile();
                                  },
                                  child: Container(
                                    height: 40,
                                    // Adjust the height to match the other boxes
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      // Changed the border color to a light grey
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Upload File',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Icon(Icons.upload_file),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Comments',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your comment',
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Cancel button logic
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Set the button color to red
                    ),
                    onPressed: () {
                      // Add your submit logic here
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white), // Set the text color to white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
