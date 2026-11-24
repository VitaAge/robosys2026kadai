#!/bin/bash
# SPDX-FileCopyrightText: 2026 <あなたの名前（ローマ字）>
# SPDX-License-Identifier: BSD-3-Clause

ng () {
        echo "${1}行目のテスト失敗"
        res=1
}

res=0

### NORMAL INPUT ###
out=$(seq 5 | ./toukei)
[ "$?" = 0 ] || ng "$LINENO"
expected="count: 5
sum: 15
mean: 3
min: 1
max: 5"
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo "あ" | ./toukei 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo "" | ./toukei 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "OK"
exit $res
