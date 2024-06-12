import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/task_utils.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/button_widget.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/text_field_widget.dart';
class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    super.key,
    required this.onSave,
  });
  final VoidCallback onSave;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController(text: "None");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
      top: 15.h, left: 20.w, right: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15.h,),
            TextFieldWidget(
              controller: _titleController,
              hintText: 'Task Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            TextFieldWidget(
              controller: _descriptionController,
              hintText: 'Description',
              maxLines: 5,
              minLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              hint: const Text('Select an item'),
              value: _priorityController.text,
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.boardHeader,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.boardHeader,
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.boardHeader,
                    width: 0.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.boardHeader,
                    width: 0.5,
                  ),
                ),
              ),

              onChanged: (newValue) {
                if(newValue != null){
                  _priorityController.text = newValue;
                }
              },
              items: TaskUtils.taskPriorities.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.ant_circle_fill, color: TaskUtils.getColorFromPriorityName(item), size: 22,),
                      SizedBox(width: 10.w),
                      Text(item, style: Theme.of(context).textTheme.bodyLarge!,),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30.h),

            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                text: 'Save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<TasksBloc>().add(
                      AddTaskEvent(
                        param: AddTaskParams(
                            content: _titleController.text,
                            description: _descriptionController.text,
                            priority: TaskUtils.getPriorityNumberFromPriorityName(_priorityController.text),
                            sectionId: todoSectionID
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}