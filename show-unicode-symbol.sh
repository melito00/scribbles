fast_chr() {
    local __octal
    local __char
    printf -v __octal '%03o' $1
    printf -v __char \\$__octal
    REPLY=$__char
}

function unichr {
    local c=$1    # Ordinal of char
    local l=0    # Byte ctr
    local o=63    # Ceiling
    local p=128    # Accum. bits
    local s=''    # Output string

    (( c < 0x80 )) && { fast_chr "$c"; echo -n "$REPLY"; return; }

    while (( c > o )); do
        fast_chr $(( t = 0x80 | c & 0x3f ))
        s="$REPLY$s"
        (( c >>= 6, l++, p += o+1, o>>=1 ))
    done

    fast_chr $(( t = p | c ))
    echo -n "$REPLY$s"
}

## test harness
#for (( i=0x2500; i<0x2600; i++ )); do
for (( i=0x2580; i<0x2600; i++ )); do
    unichr $i
done

echo "\n"

for (( i=0xe0a0; i<0xe0d5; i++ )); do
    unichr $i
done

echo "\n"
echo 'Font Awesome Extension'
echo

for (( i=0xe200; i<0xe2aa; i++ )); do
    unichr $i
done

echo '\n'
echo 'Seti-UI + Custom'
echo

for (( i=0xe5fa; i<0xe62c; i++ )); do
    unichr $i
done

echo '\n'
echo Devicons
echo

for (( i=0xe700; i<0xe7c6; i++ )); do
    unichr $i
done

echo '\n'
echo Font Awesome
echo

for (( i=0xf000; i<0xf2e1; i++ )); do
    unichr $i
done

echo "\n"
echo -n '\\u2581 : '; echo -ne '\u2581'; echo -n " | "; echo ▁
echo -n '\\u2582 : '; echo -ne '\u2582'; echo -n " | "; echo ▂
echo -n '\\u2583 : '; echo -ne '\u2583'; echo -n " | "; echo ▃
echo -n '\\u2584 : '; echo -ne '\u2584'; echo -n " | "; echo ▄
echo -n '\\u2585 : '; echo -ne '\u2585'; echo -n " | "; echo ▅
echo -n '\\u2586 : '; echo -ne '\u2586'; echo -n " | "; echo ▆
echo -n '\\u2587 : '; echo -ne '\u2587'; echo -n " | "; echo ▇
echo -n '\\u2588 : '; echo -ne '\u2588'; echo -n " | "; echo █
