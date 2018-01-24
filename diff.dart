import 'dart:io';
import 'dart:async';
import 'dart:convert';

class TreeNode {
  string data;
  List<TreeNode> left;
}

void main(List<String> args) async {
  if (args.length != 2) {
    print('ERROR:  Need two files.');
    return;
  }
  
  var file1 = new File(args[0]).readAsStringSync();
  var file2 = new File(args[1]).readAsStringSync();
  var words1 = normalize(file1);
  var words2 = normalize(file2);
  print(words1.length);
  print(words2.length);
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

String longestCommonSubstring(List<String> first, List<String> second) {
  sequence = '';
  if (first.length == 0 || second.length == 0) {
    return sequence;
  }
}
