/// 时间处理
/// 比较转换
class TimeAnalysis {
  DateTime time;
  String format;

  TimeAnalysis({
    this.time,
    this.format,
  });

  _TimeTypeCount _year() {
    int length = _findKeysNum(format, 'Y');
    String year = this.time.year.toString();
    return _TimeTypeCount(
      count: length,
      value: year.substring(length == 2 ? 2 : 0),
      key: 'Y',
    );
  }

  _TimeTypeCount _unifiedProcessing({int times, String key}) {
    int length = _findKeysNum(format, key);
    String val;
    if (length == 2) {
      val = '${times < 10 ? '0' : ''}$times';
    } else {
      val = times.toString();
    }
    return _TimeTypeCount(
      count: length,
      value: val,
      key: key,
    );
  }

  /// 组装 YYY/MM/DD/hh/mm/ss
  String _assembly() {
    List<_TimeTypeCount> data = [
      this._year(),
      _unifiedProcessing(times: this.time.month, key: 'M'),
      _unifiedProcessing(times: this.time.day, key: 'D'),
      _unifiedProcessing(times: this.time.hour, key: 'h'),
      _unifiedProcessing(times: this.time.minute, key: 'm'),
      _unifiedProcessing(times: this.time.second, key: 's'),
    ];
    String date = this.format;
    data.forEach((it) {
      if (it.count > 0) {
        date = date.replaceAllMapped(it.key * it.count, (match) => it.value);
      }
    });
    return date;
  }

  int _findKeysNum(String str, String key) {
    int count = 0;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == key) {
        count++;
      } else {
        if (count != 0) break;
      }
    }
    return count;
  }

  String compare(String tt) {
    DateTime day = DateTime.now();
    var difference = day.difference(this.time);
    int inDays = difference.inDays;
    int inHours = difference.inHours;
    int inMinutes = difference.inMinutes;
    String date;
    if (inDays != 0) {
      if (inDays > 3) {
        date = TimeAnalysis.to(tt);
      } else {
        date = '$inDays天前';
      }
    } else {
      if (inHours == 0) {
        if (inMinutes == 0) {
          date = '刚刚';
        } else {
          date = '$inMinutes分钟前';
        }
      } else {
        date = '$inHours小时前';
      }
    }
    return date;
  }

  /// 时间转换
  static String to(String time, {String format = 'YYYY-MM-DD hh:mm:ss'}) {
    TimeAnalysis instance = TimeAnalysis(
      time: DateTime.parse(time).add(new Duration(hours: 8)),
      format: format,
    );
    return instance._assembly();
  }

  /// 时间对比
  static String vs(String time) {
    TimeAnalysis instance = TimeAnalysis(
      time: DateTime.parse(time).add(new Duration(hours: 8)),
    );
    return instance.compare(time);
  }
}

class _TimeTypeCount {
  int count;
  String value;
  String key;
  _TimeTypeCount({this.count, this.value, this.key});
}
