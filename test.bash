#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yamada Itsuki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
        echo "${1}行目のテスト失敗"
        res=1
}

res=0

### NORMAL INPUT (ALL) ###
out=$(seq 5 | ./toukei)
[ "$?" = 0 ] || ng "$LINENO"
expected="count: 5
sum: 15
mean: 3
median: 3
min: 1
max: 5
std: 1.41421"
[ "${out}" = "${expected}" ] || ng "$LINENO"

### NORMAL INPUT (OPTIONS) ###
out=$(seq 5 | ./toukei --mean)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "3" ] || ng "$LINENO"

out=$(seq 4 | ./toukei --median)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "2.5" ] || ng "$LINENO"

out=$(printf -- "-10\n0\n10\n" | ./toukei --sum)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "0" ] || ng "$LINENO"

### SPECIAL SUM INPUT (810 / 1919) ###
out=$(printf "800\n10\n" | ./toukei --sum)
[ "$?" = 0 ] || ng "$LINENO"
expected_810="810
yarimasunesugi"
[ "${out}" = "${expected_810}" ] || ng "$LINENO"

out=$(printf "1900\n19\n" | ./toukei)
[ "$?" = 0 ] || ng "$LINENO"
expected_1919="count: 2
sum: 1919
mean: 959.5
median: 959.5
min: 19
max: 1900
std: 940.5
yarimasunesugi"
[ "${out}" = "${expected_1919}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo "あ" | ./toukei 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo "" | ./toukei 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(seq 5 | ./toukei --unknown 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "OK"
exit $res
