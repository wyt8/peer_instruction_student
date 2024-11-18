enum FormatterType {
  accordingNow,
  dateAndTime,
}

class DatetimeFormatter {
  static String format(DateTime dateTime, FormatterType type) {
    switch (type) {
      case FormatterType.accordingNow:
        Duration difference = DateTime.now().difference(dateTime);
        if (difference.inDays >= 1) {
          return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
        } else if (difference.inHours >= 1) {
          return '${difference.inHours}小时前';
        } else if (difference.inMinutes >= 1) {
          return '${difference.inMinutes}分钟前';
        } else {
          return '刚刚';
        }
      case FormatterType.dateAndTime:
        return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
    }
  }
}
