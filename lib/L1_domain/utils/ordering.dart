// Copyright (c) 2024. Alexandr Moroz

import 'dart:collection';
import 'dart:math';

class JSShim {
  static String repeat(String string, int count) {
    var result = '';
    for (var i = 0; i < count; i++) {
      result += string;
    }
    return result;
  }

  static bool every<E>(List<E> list, bool Function(E element, int index) test) {
    for (var index = 0; index < list.length; index++) {
      if (!test(list[index], index)) return false;
    }
    return true;
  }

  static dynamic reduceRight<T, E>(List<E> list, T? Function(T? prev, E curr, int index, List<E> list) fn, [T? initialValue]) {
    var value = initialValue;
    for (var index = list.length - 1; index > -1; index--) {
      value = fn(value, list[index], index, list);
    }
    return value;
  }
}

class Div {
  final List<int> res;
  final int rem;
  final int? den;
  final bool? carry;

  Div({required this.res, required this.rem, this.den, this.carry});
}

bool _isPrefixCodeLogLinear(List<String>? stringsIn) {
  final strings = [...stringsIn!]..sort(); // set->array or array->copy
  for (var i = 0; i < strings.length; i++) {
    final curr = strings[i];
    final prev = i > 0 ? strings[i - 1] : null; // undefined for first iteration
    if (prev == curr) {
      // Skip repeated entries, match quadratic API
      continue;
    }
    if (prev != null && curr.startsWith(prev)) {
      // str.startsWith(undefined) always false
      return false;
    }
  }
  return true;
}

bool Function(List<String>?) isPrefixCode = _isPrefixCodeLogLinear;

bool isValidString(dynamic string) {
  return string is List<String>
      ? string.isNotEmpty
      : string is String
          ? string.trim().isNotEmpty
          : false;
}

dynamic notEmptyString(dynamic string) {
  return isValidString(string)
      ? string is String
          ? string.trim()
          : string
      : null;
}

List<String> iter(String char, int len) => List.generate(
      len,
      (i) => String.fromCharCode(char.codeUnitAt(0) + i),
    );

List<int> range(int len) {
  return List.generate(len, (i) => i);
}

List<int> leftPad(List<int> digits, int finalLength, [int? val]) {
  final padLen = max(0, finalLength - digits.length);
  return List.filled(padLen, val ?? 0, growable: true)..addAll(digits);
}

List<int> rightPad(List<int> digits, int finalLength, [int? val]) {
  final padLen = max(0, finalLength - digits.length);
  return digits.toList()..addAll(List.filled(padLen, val ?? 0));
}

bool allLessThan(List<String> arr) {
  for (var i = 1; i < arr.length; i++) {
    if (arr[i - 1].compareTo(arr[i]) > 0) {
      return false;
    }
  }
  return true;
}

bool allGreaterThan(List<String> arr) {
  return allLessThan(arr.toList().reversed.toList());
}

Div longDiv(List<int> numeratorArr, int den, int base) {
  return numeratorArr.fold(Div(res: [], rem: 0, den: den), (prev, curr) {
    var newNum = curr + prev.rem * base;
    return Div(
      res: prev.res..add((newNum / den).floor()),
      rem: newNum % den,
      den: den,
    );
  });
}

const defaultList = <int>[];

Div longSubSameLen(
  List<int> start,
  List<int> end,
  int base, [
  List<int> rem = defaultList,
  int den = 0,
]) {
  if (start.length != end.length) {
    throw Exception('same length arrays needed');
  }
  if (rem.isNotEmpty && rem.length != 2) {
    throw Exception('zero or two remainders expected');
  }
  start = [...start]; // pre-emptively copy
  if (rem.isNotEmpty) {
    start = start..add(rem[0]);
    end = [...end, rem[1]];
  }
  final ret = List.filled(start.length, 0);

  // this is a LOOP LABEL! https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label
  OUTER:
  for (var i = start.length - 1; i >= 0; --i) {
    if (start[i] >= end[i]) {
      ret[i] = start[i] - end[i];
      continue;
    }

    if (i == 0) {
      throw Exception('cannot go negative');
    }

    for (var j = i - 1; j >= 0; --j) {
      if (start[j] > 0) {
        // found a non-zero digit. Decrement it
        start[j]--;
        // increment digits to its right by `base-1`
        for (var k = j + 1; k < i; ++k) {
          start[k] += base - 1;
        }
        ret[i] = start[i] + (rem.isNotEmpty && i == start.length - 1 ? den : base) - end[i];
        continue OUTER;
      }
    }
    // should have `continue`d `OUTER` loop
    throw Exception('failed to find digit to borrow from');
  }

  if (rem.isNotEmpty) {
    return Div(
      res: ret.sublist(0, ret.length - 1),
      rem: ret[ret.length - 1],
      den: den,
    );
  }
  return Div(res: ret, rem: 0, den: den);
}

Div longAddSameLen(List<int> start, List<int> end, int base, int rem, int den) {
  if (start.length != end.length) {
    throw Exception('same length arrays needed');
  }
  var carry = rem >= den;
  var res = end.toList();
  if (carry) {
    rem -= den;
  }

  JSShim.reduceRight<dynamic, int>(start, (_, ai, index, list) {
    final result = ai + end[index] + (carry ? 1 : 0);
    carry = result >= base;
    res[index] = carry ? result - base : result;
    return null;
  }, null);

  return Div(res: res, rem: rem, den: den, carry: carry);
}

List<Div> longLinspace(List<int> start, List<int> end, int base, int N, int M) {
  if (start.length < end.length) {
    start = rightPad(start, end.length);
  } else if (end.length < start.length) {
    end = rightPad(end, start.length);
  }
  if (start.length == end.length && JSShim.every(start, (dynamic prevElem, index) => prevElem == end[index])) {
    throw Exception('Start and end strings lexicographically inseparable');
  }
  final prevDiv = longDiv(start, M, base);
  final nextDiv = longDiv(end, M, base);
  var prevPrev = longSubSameLen(start, prevDiv.res, base, [0, prevDiv.rem], M);
  var nextPrev = nextDiv;
  final ret = <Div>[];

  for (var n = 1; n <= N; ++n) {
    final x = longAddSameLen(prevPrev.res, nextPrev.res, base, prevPrev.rem + nextPrev.rem, M);
    ret.add(x);
    prevPrev = longSubSameLen(prevPrev.res, prevDiv.res, base, [prevPrev.rem, prevDiv.rem], M);
    nextPrev = longAddSameLen(nextPrev.res, nextDiv.res, base, nextPrev.rem + nextDiv.rem, M);
  }

  return ret;
}

List<int> chopDigits(List<int>? rock, List<int> water) {
  for (var idx = 0; idx < water.length; idx++) {
    final waterValue = idx < water.length ? water[idx] : null;
    final rockValue = idx < rock!.length ? rock[idx] : null;
    if (waterValue != null && waterValue != 0 && rockValue != waterValue) {
      return water.sublist(0, idx + 1);
    }
  }
  return water;
}

bool lexicographicLessThanArray(List<int> start, List<int> end) {
  final n = min(start.length, end.length);
  for (var i = 0; i < n; i++) {
    if (start[i] == end[i]) {
      continue;
    }
    return start[i] < end[i];
  }
  return start.length < end.length;
}

List<List<int>>? chopSuccessiveDigits(List<List<int>> digits) {
  final reversed = !lexicographicLessThanArray(digits[0], digits[1]);
  if (reversed) {
    digits = digits.reversed.toList();
  }
  final sliced = digits.sublist(1);
  var result = sliced.fold<List<List<int>>>([digits[0]], (accum, curr) {
    final arrayToConcat = [chopDigits(accum[accum.length - 1], curr)];
    return accum..addAll(arrayToConcat);
  });
  if (reversed) {
    result = result.reversed.toList();
  }
  return result;
}

List<dynamic> truncateLexHigher(dynamic lo, dynamic hi) {
  var loStr = lo is List<String>
      ? lo.join("")
      : lo is String
          ? lo
          : throw Exception("Value is not a List<String> nor a String");
  var hiStr = hi is List<String>
      ? hi.join("")
      : hi is String
          ? hi
          : throw Exception("Value is not a List<String> nor a String");

  final swapped = loStr.compareTo(hiStr) > 0;
  if (swapped) {
    final temp = lo;
    lo = hi;
    hi = temp;
  }
  if (swapped) {
    return [hi, lo];
  }
  return [lo, hi];
}

class SymbolTable {
  late List<String> num2sym;
  late Map<String, int> sym2num;
  late int maxBase;

  bool? _isPrefixCode;

  SymbolTable({
    String? symbolsString,
    List<String>? symbolsArray,
    Map<String, int>? symbolsMap,
  }) {
    // Condition the input `symbolsArr`
    if (symbolsArray != null) {
      num2sym = symbolsArray;
    } else {
      if (symbolsString != null && symbolsString.isNotEmpty) {
        num2sym = symbolsString.split('');
      } else {
        throw Exception('symbolsArr and symbolsStr must not be null or empty');
      }
    }

    // Condition the second input, `symbolsMap`. If no symbolsMap passed in,
    // make it by inverting symbolsArr. If it's an object (and not a Map),
    // convert its own-properties to a Map.
    if (symbolsMap != null) {
      sym2num = symbolsMap;
    } else {
      sym2num = HashMap.fromIterable(num2sym, key: (element) => element as String, value: (element) => num2sym.indexOf(element as String));
    }

    // `symbolsMap`
    var symbolsValuesSet = Set.of(sym2num.values);
    for (var i = 0; i < num2sym.length; i++) {
      if (!symbolsValuesSet.contains(i)) {
        throw Exception('${num2sym.length} symbols given but $i not found in symbol table');
      }
    }

    maxBase = num2sym.length;
    _isPrefixCode = isPrefixCode(num2sym);
  }

  List<String> mudder({
    dynamic start,
    dynamic end,
    int? numStrings,
    int? base,
    int? numDivisions,
  }) {
    if (start != null && start is! String && start is! List<String>) {
      throw Exception('start param must be of type String or List<String>');
    }

    if (end != null && end is! String && end is! List<String>) {
      throw Exception('end param must be of type String or List<String>');
    }

    start = notEmptyString(start) ?? num2sym[0];

    int? length;
    if (start is String) {
      length = start.length;
    } else if (start is List) {
      length = start.length;
    } else {
      throw Exception('Illegal state. Length must not be null');
    }

    end = notEmptyString(end) ?? JSShim.repeat(num2sym[num2sym.length - 1], length + 6);
    numStrings ??= 1;
    base ??= maxBase;
    numDivisions ??= numStrings + 1;

    final truncated = truncateLexHigher(start, end);
    start = truncated[0];
    end = truncated[1];
    final prevDigits = stringToDigits(start);
    final nextDigits = stringToDigits(end);
    final intermediateDigits = longLinspace(prevDigits, nextDigits, base, numStrings, numDivisions);
    final finalDigits = intermediateDigits.map((v) => v.res..addAll(roundFraction(v.rem, v.den!, base))).toList();
    finalDigits.insert(0, prevDigits);
    finalDigits.add(nextDigits);
    return chopSuccessiveDigits(finalDigits)!.sublist(1, finalDigits.length - 1).map(digitsToString).toList();
  }

  List<int> roundFraction(int numerator, int denominator, int? base) {
    base = base ?? maxBase;
    var places = (log(denominator) / log(base)).ceil();
    var scale = pow(base, places);
    var scaled = (numerator / denominator * scale).round();
    var digits = numberToDigits(scaled, base);
    return leftPad(digits, places, 0);
  }

  List<int> numberToDigits(int num, [int? base]) {
    base ??= maxBase;
    var digits = <int>[];
    while (num >= 1) {
      digits.add(num % base);
      num = (num / base).floor();
    }
    return digits.isNotEmpty ? digits.reversed.toList() : [0];
  }

  String digitsToString(List<int> digits) {
    return digits.map((n) => num2sym[n]).join('');
  }

  List<int> stringToDigits(dynamic string) {
    if (string is String) {
      if (_isPrefixCode == null || !_isPrefixCode!) {
        throw Exception('parsing string without prefix code is unsupported. Pass in array '
            'of stringy symbols?');
      }
      final re = RegExp('(${List.from(sym2num.keys).join('|')})');
      return re.allMatches(string).map<String>((e) => e.input.substring(e.start, e.end)).map<int>((symbol) {
        final num = sym2num[symbol];
        if (num != null) return num;
        throw Exception('Undefined value for sym2num with key $symbol');
      }).toList();
    }

    if (string is List<String>) {
      return string.map((e) {
        final num = sym2num[e];
        if (num != null) return num;
        throw Exception('Undefined value for sym2num with key $e');
      }).toList();
    }

    throw Exception("param must be of type String or List<String>");
  }

  int? digitsToNumber(List<int> digits, [int? base]) {
    base ??= maxBase;
    var currBase = 1;
    return JSShim.reduceRight<dynamic, int>(digits, (prev, curr, index, list) {
      var ret = prev + curr * currBase;
      currBase *= base!;
      return ret;
    }, 0) as int?;
  }

  String numberToString(int num, [int? base]) {
    return digitsToString(numberToDigits(num, base));
  }

  int? stringToNumber(String num, [int? base]) {
    return digitsToNumber(stringToDigits(num), base);
  }
}

final stBase62 = SymbolTable(
  symbolsArray: iter('0', 10)
    ..addAll(iter('A', 26))
    ..addAll(iter('a', 26)),
);
