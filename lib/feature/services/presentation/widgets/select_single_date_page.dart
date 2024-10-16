import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_table_single.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_booking_date_cubit/service_booking_date_cubit.dart';
import 'package:sahab_project/generated/l10n.dart';

class SelectSingleDatePage extends StatelessWidget {
  const SelectSingleDatePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    DateTime? dateTimeSelected;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(dateTimeSelected);

        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomSimpleAppBarWidget(
              appBarTitle: S.of(context).choose_date,
              onIconTap: () {
                Navigator.of(context).pop(dateTimeSelected);
              },
            ),
            CustomTableSingle(
              startRange: DateTime.now(),
              endRange: DateTime.now().add(
                Duration(
                  days: 30,
                ),
              ),
              onSingleSelected: (selectedDate) {
                dateTimeSelected = selectedDate;
                // print(selectedDate);
              },
            ),
          ],
        ),
      ),
    );
  }
}
