import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_btn/custom_elevated_btn.dart';
import 'package:web_responsive_flutter/src/common_widgets/paint_custom/custom_container.dart';

class KaizenForm extends StatefulWidget {
  @override
  _KaizenFormState createState() => _KaizenFormState();
}

class _KaizenFormState extends State<KaizenForm> {
  String? selectedPlant;
  String? selectedDepartment;
  String? selectedCategory;
  String? selectedBenefit;
  String? selectedUOM;
  String? selectedPillar;
  String? selectedSection;
  String? selectedLoss;
  String? selectedKaizenTheme;
  bool isOneTime = true;
  bool isMachine = true;
  bool isMPKaizen = false;

  final TextEditingController sapCodeController = TextEditingController();
  final TextEditingController machineNameController = TextEditingController();
  final TextEditingController departmentNameController = TextEditingController();
  final TextEditingController sectionNameController = TextEditingController();
  final TextEditingController cellNumberController = TextEditingController();
  final TextEditingController cellNameController = TextEditingController();
  final TextEditingController initiatorNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'KAIZEN IDEA SHEET',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'For making our processes better',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),

              // Section 1: Plant and Department
              _buildSectionTitle('Plant & Department'),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Plant Name', selectedPlant, ['Gurgaon Plant'], (value) {
                      setState(() {
                        selectedPlant = value;
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildDropdownField('Department', selectedDepartment, ['Department 1', 'Department 2'], (value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),
              // Section 2: Category and Benefit
              _buildSectionTitle('Category & Benefit'),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Category', selectedCategory, ['Category 1', 'Category 2'], (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildDropdownField('Benefit Type', selectedBenefit, ['Benefit 1', 'Benefit 2'], (value) {
                      setState(() {
                        selectedBenefit = value;
                      });
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),
              // Section 3: UOM and SAP Code
              _buildSectionTitle('UOM & Machine Details'),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Unit of Measurement', selectedUOM, ['UOM 1', 'UOM 2'], (value) {
                      setState(() {
                        selectedUOM = value;
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTextField('Machine SAP Code', sapCodeController),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),
              // Section 4: Pillar, Section, and Loss
              _buildSectionTitle('Pillar & Loss Details'),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Pillar Name', selectedPillar, ['Pillar 1', 'Pillar 2'], (value) {
                      setState(() {
                        selectedPillar = value;
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildDropdownField('Section', selectedSection, ['Section 1', 'Section 2'], (value) {
                      setState(() {
                        selectedSection = value;
                      });
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Loss No & Name', selectedLoss, ['Loss 1', 'Loss 2'], (value) {
                      setState(() {
                        selectedLoss = value;
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTextField('Machine Name', machineNameController),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),
              // Section 5: Saving Type and Machine Type
              _buildSectionTitle('Type Details'),
              Row(
                children: [
                  Expanded(
                    child: _buildRadioButtonGroup('Saving Type', ['One-Time', 'Recurring'], isOneTime, (value) {
                      setState(() {
                        isOneTime = value == 'One-Time';
                      });
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildRadioButtonGroup('Machine Type', ['Machine', 'Non-Machine'], isMachine, (value) {
                      setState(() {
                        isMachine = value == 'Machine';
                      });
                    }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(child: MyCustomButton(name: 'Hello', textColor: Colors.white, btnColor: AppColors.darkMaron, onTap: () {  },)),
                  SizedBox(width: 20,),
                  Expanded(child: MyCustomButton(icon: Image.asset(AppImages.appBarProfile),name: 'my icon', textColor: Colors.white, btnColor: AppColors.darkMaron, onTap: () {  },))

                ],
              ),
              CustomContainer(
                borderColor: Colors.grey,
                btnColor: Colors.pink,
                widthFactor: 0.5,  // 50% of screen width
                heightFactor: 0.25, // 25% of screen height
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.dark1Grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.dark1Grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButtonGroup(String label, List<String> options, bool selected, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: options.map((option) {
            return Row(
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selected ? options[0] : options[1],
                  onChanged: onChanged,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
