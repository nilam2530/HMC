import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/features/admin/kaizen_theme/provider/kaizen_theme_provider.dart';
import '../../../common_widgets/animated_customwidgets/animatedCustomDropDown.dart';
import '../../../common_widgets/custom_fields/text/custom_text_field.dart';
import '../../../models/pillar_model.dart';

class AddLoss extends StatefulWidget {
  const AddLoss({super.key});

  @override
  State<AddLoss> createState() => _AddLossState();
}

class _AddLossState extends State<AddLoss> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<KaizenThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Loss',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darBlack),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'DashBoard | Kaizen Theme | Add Loss',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darBlack),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go('/kaizenLoss');
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                border: Border.all(
                                    width: 0.5,
                                    color: AppColors.outlineBorderColor),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (_validateFields(controller)) {
                              controller.addNewTheme(
                                name: controller.nameController.text,
                                sortOrder: controller.sortOrderController.text,
                                status: "Pending",
                              );
                              GoRouter.of(context).go('/kaizenLoss');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  "Please fill all fields",
                                )),
                              );
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColors.sucessful,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            _buildFormFields(controller),
          ],
        ),
      ),
    );
  }

  bool _validateFields(KaizenThemeProvider controller) {
    return controller.nameController.text.trim().isNotEmpty &&
        controller.selectetThemeStatus.trim().isNotEmpty &&
        controller.sortOrderController.text.trim().isNotEmpty;
  }

  Widget _buildFormFields(KaizenThemeProvider controller) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 150,
              child: Text(
                "Loss No: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darBlack,
                ),
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: controller.nameController,
                labelText: 'Loss No',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Add loss no';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            const SizedBox(
              width: 150,
              child: Text(
                "Loss Name: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darBlack,
                ),
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: controller.nameController,
                labelText: 'Loss name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Add loss no';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            const SizedBox(
              width: 150,
              child: Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darBlack,
                ),
              ),
            ),
            Expanded(
              child: CustomAnimatedDropdown<PillarModel>(
                items: controller.pillarModel,
                itemAsString: (pillar) => pillar.title,
                onChanged: (value) {
                  controller.setSelectedPillarHead(value?.title ?? '');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const SizedBox(
              width: 150,
              child: Text(
                "Sort Order: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darBlack,
                ),
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: controller.sortOrderController,
                labelText: 'Sort Order',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Add Sort Order';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onSaved: (String? value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
