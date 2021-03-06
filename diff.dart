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
  
  String toString() {
    return " ${this.words.length} starting at ${this.offset}";
  }
  
  DiffFragment toDiffFragment(bool second) {
    var w = this.words;
    var a1 = second ? -1 : this.offset;
    var z1 = second ? -1 : (this.offset + w.length);
    var a2 = second ? this.offset : -1;
    var z2 = second ? (this.offset + w.length) : -1;
    return new DiffFragment(w, a1, z1, a2, z2);
  }

  Fragment extractFragment(int start, int end) {
    if (end > this.words.length || start >= end) {
      return null;
    }

    var words = new List<String>();
    for (var i = start; i < end; i++) {
      words.add(this.words[i]);
    }

    return new Fragment(words, this.offset + start);
  }

  /* Adapted from:
   * https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Longest_common_substring
   */
  DiffFragment longestCommonSubstring(Fragment compareWith) {
    var first = this.words;
    var second = compareWith.words;
    List<String> sequence = new List<String>();
print("Comparing ${first.length} with ${second.length}");
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
print("i:   ${i}");
      num[i] = new List<int>(second.length);
      for (int j = 0; j < second.length; j++) {
print(" j:  ${i} - ${j}");
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
  
    aFirst += this.offset;
    zFirst += this.offset;
    aSecond += compareWith.offset;
    zSecond += compareWith.offset;
    return new DiffFragment(sequence, aFirst, zFirst, aSecond, zSecond);
  }
}

class DiffFragment {
  int firstStart;
  int firstEnd;
  int secondStart;
  int secondEnd;
  List<String> words;
  
  DiffFragment(List<String> w, int a1, int z1, int a2, int z2) {
    this.words = w;
    this.firstStart = a1;
    this.firstEnd = z1;
    this.secondStart = a2;
    this.secondEnd = z2;
  }
  
  String toString() {
    String res = "";
    if (this.firstStart > -1) {
      res += "<<<<<<<< Lines #${this.firstStart} to ${this.firstEnd}\n";
    }
    if (this.secondStart > -1) {
      res += ">>>>>>>> Lines #${this.secondStart} to ${this.secondEnd}\n";
    }
    res += "[ ";
    res += words.join(', ');
    res += " ]";
    return res;
  }
}

void main(List<String> args) async {
  var frags1 = new List<Fragment>();
  var frags2 = new List<Fragment>();
  var diffs = new List<DiffFragment>();
  if (args.length != 2) {
    print('ERROR:  Need two files.');
    return;
  }
  
  var file1 = new File(args[0]).readAsStringSync();
  var file2 = new File(args[1]).readAsStringSync();
  frags1.add(new Fragment(normalize(file1), 0));
  frags2.add(new Fragment(normalize(file2), 0));
  while (frags1.length > 0) {
    var first = frags1.removeAt(0);
    var maxlen = 0;
    var bestmatch = -1;
    DiffFragment fragment;
    for (int j = 0; j < frags2.length; j++) {
      fragment = first.longestCommonSubstring(frags2[j]);
      if (fragment.firstEnd - fragment.firstStart > maxlen) {
        maxlen = fragment.firstEnd - fragment.firstStart;
        bestmatch = j;
      }
    }
    
    if (bestmatch > -1) {
      var frag = frags2.removeAt(bestmatch);
      var firstStart = fragment.firstStart;
      var firstEnd = fragment.firstEnd;
      var secondStart = fragment.secondStart;
      var secondEnd = fragment.secondEnd;

      var f = first.extractFragment(0, firstStart - first.offset);
      if (f != null) {
        frags1.add(f);
      }

      f = first.extractFragment(firstEnd - first.offset + 1, first.words.length);
      if (f != null) {
        frags1.add(f);
      }

      f = frag.extractFragment(0, secondStart - frag.offset);
      if (f != null) {
        frags2.add(f);
      }

      f = frag.extractFragment(secondEnd - frag.offset + 1, frag.words.length);
      if (f != null) {
        frags2.add(f);
      }

      diffs.add(fragment);
    } else {
      diffs.add(first.toDiffFragment(false));
    }
    
    for (int k=0;k<frags1.length;k++) {
      print("<<-- ${frags1[k].toString()}");
    }
    for (int k=0;k<frags2.length;k++) {
      print("-->> ${frags2[k].toString()}");
    }
  }
  
  while (frags2.length > 0) {
    var f = frags2.removeAt(0);
    diffs.add(f.toDiffFragment(true));
  }
  
  diffs.sort((a,b) => a.secondStart.compareTo(b.secondStart));
  for (int a = 0; a < diffs.length; a++) {
    print(diffs[a].toString());
  }
}

String normalize(String source) {
  var chars = [ '-', '?', '!', '.', ',', '+', '#', '&', '*', '¢', '©', '°',
                '}', '{', ')', '(', ']', '[', '_', '|', ';', ':', '/', '<',
                '=', '>', '"', '·', '”', '“', '—', '…', '™',
                '\$', '\n', '\r', ' \'', '\' ' ];
  source = source.replaceAll('’', '\'');
  for (var c in chars) {
    source = source.replaceAll(c, ' ');
  }

  while (source.indexOf('  ') >= 0) {
    source = source.replaceAll(r'  ', ' ');
  }

  source = source.toLowerCase();
  return source.trim().split(' ');
}
