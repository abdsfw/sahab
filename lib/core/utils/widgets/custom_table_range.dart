import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/extension/date_time_extension.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableRange extends StatefulWidget {
  final void Function(DateTime?, DateTime?) onRangeSelected;
  final List<DateTime> ignoreDays;
  final DateTime startRange;
  final DateTime endRange;
  const CustomTableRange(
      {super.key,
      required this.onRangeSelected,
      this.ignoreDays = const [],
      required this.startRange,
      required this.endRange});

  @override
  _CustomTableRangeState createState() => _CustomTableRangeState();
}

class _CustomTableRangeState extends State<CustomTableRange> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TableCalendar(
        firstDay:
            widget.startRange, //DateTime.now().subtract(Duration(days: 1)),
        lastDay: widget.endRange, // DateTime.now().add(Duration(days: 30)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: CalendarFormat.month, //_calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        rowHeight: 35,
        enabledDayPredicate: (DateTime day) {
          if (widget.ignoreDays.contains(day.truncateToDay())) {
            return false;
          }
          return true; // Return true to enable selection for other days
        },
        headerStyle: HeaderStyle(
          leftChevronIcon: SvgPicture.asset(
            BlocProvider.of<LangCubit>(context).lang == "en"
                ? AppIcons.backArrowCalenderIcon
                : AppIcons.forArrowCalenderIcon,
          ),
          rightChevronIcon: SvgPicture.asset(
            BlocProvider.of<LangCubit>(context).lang == "en"
                ? AppIcons.forArrowCalenderIcon
                : AppIcons.backArrowCalenderIcon,
          ),
          titleCentered: true,
          formatButtonVisible: false,
        ),

        // sixWeekMonthsEnforced: false,
        // weekNumbersVisible: false,
        // headerStyle: ,
        // calendarStyle: CalendarStyle(
        //     defaultDecoration: BoxDecoration(color: Colors.amber)),
        // daysOfWeekStyle: DaysOfWeekStyle(),

        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null; // Important to clean those
              _rangeEnd = null;
              // _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        calendarStyle: CalendarStyle(
            rangeHighlightColor: AppColor.blueColor,
            withinRangeDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.blueColor,
            ),
            // selectedDecoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   color:
            //       Colors.green, // Change the color of the selected day circle
            // ),
            // todayDecoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   color: AppColor.pageBackGround,
            // ),
            // todayTextStyle: TextStyle(
            //   color: Colors.black,
            // ),
            rangeEndDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.blueColor,
            ),
            rangeStartDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.blueColor,
            ),
            withinRangeTextStyle: TextStyle(
              color: Colors.white,
            )
            // todayDecoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   color: Colors.white,
            // ),
            ),

        onRangeSelected: (start, end, focusedDay) {
          bool check = false;
          if (end != null && start != null) {
            for (int i = 0; i < end.day - start.day; i++) {
              if (widget.ignoreDays
                  .contains(start.add(Duration(days: i)).truncateToDay())) {
                setState(() {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                  _rangeStart = start;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
                widget.onRangeSelected(start, start);
                check = true;
                break;
              }
            }
          }
          if (!check) {
            widget.onRangeSelected(start, end);
            setState(() {
              _selectedDay = null;
              _focusedDay = focusedDay;
              _rangeStart = start;
              _rangeEnd = end;
              _rangeSelectionMode = RangeSelectionMode.toggledOn;
            });
          }
        },

        // onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
