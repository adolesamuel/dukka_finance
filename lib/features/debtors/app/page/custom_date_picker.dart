import 'package:dukka_finance/features/common/custom_sign_up_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BuildDatePicker extends StatefulWidget {
  final Function(DateTime)? onSelectDate;
  const BuildDatePicker({Key? key, this.onSelectDate}) : super(key: key);

  @override
  State<BuildDatePicker> createState() => _BuildDatePickerState();
}

class _BuildDatePickerState extends State<BuildDatePicker> {
  String dateString = 'Due Date';
  DateTime? selectDate;

  @override
  Widget build(BuildContext context) {
    return CustomSignUpDatePicker(
      width: 320.0.w,
      press: () async {
        final currentDate = DateTime.now();
        final chosenDay = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(currentDate.year + 20),
        );
        final chosenTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (chosenDay != null && chosenTime != null) {
          selectDate = DateTime(
            chosenDay.year,
            chosenDay.month,
            chosenDay.day,
            chosenTime.hour,
            chosenTime.minute,
          );
        }
        setState(() {
          if (selectDate != null) {
            final formattedDate = DateFormat('dd | MM | yyyy hh:mma');

            dateString = formattedDate.format(selectDate!);
          }
        });

        if (selectDate != null) {
          widget.onSelectDate!(selectDate!);
        }
      },
      buttonText: dateString,
    );
  }
}
