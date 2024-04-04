"\Program Files\qemu\qemu-system-x86_64.exe" ^
   -accel whpx ^
   -nic user,model=virtio-net-pci ^
   -smp 2 ^
   -m 4096 ^
   -machine q35 ^
   -no-reboot ^
   -device intel-iommu ^
   -device VGA,edid=on,xres=1680,yres=1200 ^
   -device AC97,audiodev=snd0 ^
   -audiodev dsound,id=snd0 ^
   -device nec-usb-xhci,id=usb,bus=pci.0,addr=0x4 ^
   -device usb-tablet ^
   -device virtio-blk,drive=myhd ^
   -drive if=none,file=guix-system-vm-image-1.4.0.x86_64-linux.qcow2,id=myhd

REM -device AC97,audiodev=snd0 -audiodev dsound,id=snd0

