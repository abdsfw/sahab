extension DateTimeExtensions on DateTime {
  DateTime truncateToDay() {
    return DateTime(this.year, this.month, this.day);
  }

  bool isEquals(DateTime date) {
    return this.truncateToDay() == date.truncateToDay();
  }

  bool isLessThatOrEqual(DateTime date) {
    DateTime date1 = this.truncateToDay();
    DateTime date2 = date.truncateToDay();

    if (date1.year <= date2.year) {
      if (date1.month <= date2.month) {
        if (date1.day <= date2.day) {
          return true;
        }
      }
    }

    return false;
  }

  String timeOfDate() {
    String time = "";
    int hour = this.hour;
    int minute = this.minute;
    String label = "AM";
    if (hour > 12) {
      label = "PM";
      hour -= 12;
    }
    if (hour < 10) {
      time += "0" + hour.toString() + ":";
    } else {
      time += hour.toString() + ":";
    }
    if (minute < 10) {
      time += "0" + minute.toString();
    } else {
      time += minute.toString();
    }

    return time + label;
  }

  String hourMinuteSecond() {
    String data = "";
    if (this.hour < 10) {
      data += "0" + this.hour.toString() + ":";
    } else {
      data += this.hour.toString() + ":";
    }
    if (this.minute < 10) {
      data += "0" + this.minute.toString() + ":";
    } else {
      data += this.minute.toString() + ":";
    }
    if (this.second < 10) {
      data += "0" + this.second.toString();
    } else {
      data += this.second.toString();
    }
    return data;
  }
}
