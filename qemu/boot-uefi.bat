"\Program Files\qemu\qemu-system-x86_64.exe" ^
  -drive if=pflash,format=raw,readonly=on,file=./OVMF.fd ^
  -boot menu=on