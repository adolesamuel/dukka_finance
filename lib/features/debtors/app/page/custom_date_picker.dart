import 'package:dukka_finance/features/common/custom_sign_up_date_picker.dart';
import 'package:flutter/material.dart';
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
      width: 300,
      press: () async {
        final currentDate = DateTime.now();
        final chosenDay = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(currentDate.year + 20),
        ).then((selectedDate) {
          setState(
            () {
              if (selectedDate != null) {
                final formattedDate = DateFormat('dd | MM | yyyy hh:mm');

                dateString = formattedDate.format(selectedDate);
              }
            },
          );
          return selectedDate;
        });
        final chosenTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (chosenDay != null || chosenTime != null) {
          selectDate = DateTime(
            chosenDay?.year ?? DateTime.now().year,
            selectDate?.month ?? DateTime.now().month,
            selectDate?.day ?? DateTime.now().day,
            chosenTime?.hour ?? DateTime.now().hour,
            chosenTime?.minute ?? DateTime.now().minute,
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
