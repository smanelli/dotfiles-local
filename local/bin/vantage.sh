#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

modprobe acpi_call

if [[ "$?" -ne 0 ]]; then
	exit
fi

opt=$( tr '[:upper:]' '[:lower:]' <<<"$1" )
case "$opt" in 
	intelligent)
		echo "Setting Intelligent Cooling mode"
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' > /proc/acpi/call
		;;
	battery)
		echo "Setting Battery Saving mode"
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' > /proc/acpi/call
		;;
	performance)
		echo "Setting Extreme Performance mode"
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' > /proc/acpi/call	
		;;
	*)
		echo "usage: vantage followed by one of intelligent, battery or performance"	
esac


