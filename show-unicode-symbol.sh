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
#for (( i=0x2570; i<0x2600; i++ )); do
for (( i=0x2580; i<0x2600; i++ )); do
    unichr $i
done

echo
echo -ne '\u2581'; echo -n " | "; echo ▁
echo -ne '\u2582'; echo -n " | "; echo ▂
echo -ne '\u2583'; echo -n " | "; echo ▃
echo -ne '\u2584'; echo -n " | "; echo ▄
echo -ne '\u2585'; echo -n " | "; echo ▅
echo -ne '\u2586'; echo -n " | "; echo ▆
echo -ne '\u2587'; echo -n " | "; echo ▇
echo -ne '\u2588'; echo -n " | "; echo █
