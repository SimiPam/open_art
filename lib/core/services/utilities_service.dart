import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/dims.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:intl/intl.dart' as intl;

class UtilitiesService {
  bool isValidEmail(String email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isPreviousDay(DateTime d1, DateTime d2) {
    final DateTime prevDay = d2.subtract(const Duration(days: 1));
    return isSameDay(d1, prevDay);
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static String timeAgo(DateTime date, {bool numericDates = true}) {
    if (date == null) {
      return 'Invalid date';
    }

    final DateTime date2 = DateTime.now();
    final Duration difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return numericDates ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return numericDates ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return numericDates ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return numericDates ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String formatDate(DateTime date, [String fmt, bool custom = false]) {
    if (custom) {
      final DateTime today = DateTime.now();
      final DateTime yesterday =
          DateTime(today.year, today.month, today.day - 1);
      final DateTime tomorrow =
          DateTime(today.year, today.month, today.day + 1);

      if (isSameDay(date, today)) {
        return 'Today';
      } else if (isSameDay(date, yesterday)) {
        return 'Yesterday';
      } else if (isSameDay(date, tomorrow)) {
        return 'Tomorrow';
      } else {
        return intl.DateFormat(fmt ?? 'dd-MMM-yyyy').format(date);
      }
    } else {
      return intl.DateFormat(fmt ?? 'dd-MMM-yyyy').format(date);
    }
  }

  int getAge(DateTime date) {
    final DateTime now = DateTime.now();

    return now.year - date.year;
  }

  List<List<T>> chunks<T>(List<T> arr, int size) {
    final List<List<T>> chunks = <List<T>>[];

    for (int i = 0; i < arr.length; i += size) {
      chunks.add(arr.sublist(i, i + size > arr.length ? arr.length : i + size));
    }
    return chunks;
  }

  static Widget progress(
      {String text, Color color, double size, double parentHeight}) {
    return Container(
      height: parentHeight,
      child: Center(
        child: text == null
            ? Container(
                width: Dims.dx(size ?? 100),
                height: Dims.dx(size ?? 100),
                child: const CircularProgressIndicator(),
              )
            : Styles.bold(text, color: color),
      ),
    );
  }

  static Widget progressImg({double s}) {
    return Center(
      child: Image.asset(
        'assets/images/progress.gif',
        width: s,
      ),
    );
  }

  static void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static DateTime toDateTime(dynamic data) {
    try {
      if (data == null) {
        return null;
      } else if (data is String) {
        return DateTime.parse(data);
      } else if (data is DateTime) {
        return data;
      } else if (data is int) {
        return DateTime.fromMillisecondsSinceEpoch(data);
      } else {
        print(data);
        return null;
      }
    } catch (e) {
      print(e);

      return null;
    }
  }

  String capitaliseFirstLetters(String value) {
    return value.toLowerCase().split(' ').map((String word) {
      final String leftText =
          (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
