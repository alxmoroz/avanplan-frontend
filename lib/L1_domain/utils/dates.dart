// Copyright (c) 2023. Alexandr Moroz

DateTime get now => DateTime.now();
DateTime get yesterday => DateTime(now.year, now.month, now.day - 1);
DateTime get today => DateTime(now.year, now.month, now.day);
DateTime get tomorrow => DateTime(now.year, now.month, now.day + 1);
DateTime get nextWeek => DateTime(now.year, now.month, now.day + 7);
