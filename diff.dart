import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Fragment {
  List<String> words = new List<String>();
  int offset = 0;
  
  Fragment(List<String> w, int o) {
    this.words = w;
    this.offset = o;
  }
}

class DiffFragment {
  int firstStart;
  int firstEnd;
  int secondStart;
  int secondEnd;
  List<String> words;
}

void main(List<String> args) async {
  var frags1 = new List<List<String>>();
  var frags2 = new List<List<String>>();
  if (args.length != 2) {
    print('ERROR:  Need two files.');
    return;
  }
  
  var file1 = new File(args[0]).readAsStringSync();
  var file2 = new File(args[1]).readAsStringSync();
  frags1.add(normalize(file1));
  frags2.add(normalize(file2));
  for (int i = 0; i < frags1.length; i++) {
    for (int j = 0; j < frags2.length; j++) {
      var fragment = longestCommonSubstring(frags1[i], frags2[j]);
      print(fragment.words);
      print("From ${fragment.firstStart} to ${fragment.firstEnd} in ${args[0]}");
      print("From ${fragment.secondStart} to ${fragment.secondEnd} in ${args[1]}");
    }
  }
}

String normalize(String source) {
  var x = source;
  x = x.replaceAll('-', ' ');
  x = x.replaceAll('?', ' ');
  x = x.replaceAll('!', ' ');
  x = x.replaceAll('.', ' ');
  x = x.replaceAll(',', ' ');
  x = x.replaceAll('+', ' ');
  x = x.replaceAll('#', ' ');
  x = x.replaceAll('&', ' ');
  x = x.replaceAll('*', ' ');
  x = x.replaceAll('¢', ' ');
  x = x.replaceAll('©', ' ');
  x = x.replaceAll('°', ' ');
  x = x.replaceAll('}', ' ');
  x = x.replaceAll('{', ' ');
  x = x.replaceAll(')', ' ');
  x = x.replaceAll('(', ' ');
  x = x.replaceAll(']', ' ');
  x = x.replaceAll('[', ' ');
  x = x.replaceAll('_', ' ');
  x = x.replaceAll('|', ' ');
  x = x.replaceAll(';', ' ');
  x = x.replaceAll(':', ' ');
  x = x.replaceAll('/', ' ');
  x = x.replaceAll('<', ' ');
  x = x.replaceAll('=', ' ');
  x = x.replaceAll('>', ' ');
  x = x.replaceAll('"', ' ');
  x = x.replaceAll('·', ' ');
  x = x.replaceAll('\$', ' ');
  x = x.replaceAll('\n', ' ');
  x = x.replaceAll('\r', ' ');
  x = x.replaceAll(' \'', ' ');
  x = x.replaceAll('\' ', ' ');
  for (int i = 0; i < 100; i++) {
    x = x.replaceAll(r'  ', ' ');
  }
  x = x.toLowerCase();
  return x.split(' ');
}

/* Adapted from:
 * https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Longest_common_substring
 */
DiffFragment longestCommonSubstring(List<String> first, List<String> second) {
  List<String> sequence = new List<String>();
  if (first.length == 0 || second.length == 0) {
    return sequence;
  }
  
  List<List<int>> num = new List<List<int>>(first.length);
  int maxlen = 0;
  int lastSubsBegin = 0;
  int aFirst = -1;
  int zFirst = -1;
  int aSecond = -1;
  int zSecond = -1;
  
  for (int i = 0; i < first.length; i++) {
    num[i] = new List<int>(second.length);
    for (int j = 0; j < second.length; j++) {
      if (first[i] != second[j]) {
        num[i][j] = 0;
      } else {
        if (i == 0 || j == 0) {
          num[i][j] = 1;
        } else {
          num[i][j] = 1 + num[i-1][j-1];
        }
        
        if (num[i][j] > maxlen) {
          maxlen = num[i][j];
          int thisSubsBegin = i - num[i][j] + 1;
          if (lastSubsBegin == thisSubsBegin) {
            if (aFirst < 0) {
              aFirst = i;
              aSecond = j;
            }
            zFirst = i;
            zSecond = j;
            sequence.add(first[i]);
          } else {
            lastSubsBegin = thisSubsBegin;
            int nWords = i + 1 - lastSubsBegin;
            sequence = new List<String>();
            aFirst = i;
            aSecond = j;
            zFirst = i + nWords;
            zSecond = j + nWords;
            for (int k = 0; k < nWords; k++) {
              sequence.add(first[lastSubsBegin + k]);
            }
          }
        }
      }
    }
  }
  
  var result = new DiffFragment();
  result.words = sequence;
  result.firstStart = aFirst;
  result.firstEnd = zFirst;
  result.secondStart = aSecond;
  result.secondEnd = zSecond;
  return result;
}
