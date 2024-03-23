"\Program Files\qemu\qemu-system-x86_64.exe" ^
   -accel whpx ^
   -nic user,model=virtio-net-pci ^
   -m 4096 ^
   -vga virtio ^
   -device nec-usb-xhci,id=usb,bus=pci.0,addr=0x4 ^
   -device usb-tablet ^
   -device virtio-blk,drive=myhd ^
   -drive if=none,file=guix-system-vm-image-1.4.0.x86_64-linux.qcow2,id=myhd