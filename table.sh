#!/bin/sh
curl "$1" 2>/dev/null | grep -e '</\?table\|</\?td\|</\?tr\|</\?th' | sed 's/^[\ \t]*//g' | tr -d '\n' | sed 's/<\/tr[^>]*>/\n/g'  | sed 's/<\/\?\(table\|tr\)[^>]*>//g' | sed 's/^<t[dh][^>]*>\|<\/\?t[dh][^>]*>$//g' | sed 's/<\/t[dh][^>]*><t[dh][^>]*>/,/g'

