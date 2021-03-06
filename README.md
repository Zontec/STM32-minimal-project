# This is a minimal project for stm32f407vgt6

## Introduction
The project has been created to help programmers getting started with STM MCU based on Cortex-M core. The project has all basic configuaration files and setups to realize how to start with this kind of mcu. It's easy to configure for any other MCU from STM family. Project demonstrates basic UART usage and pins handling. 

## Start
```Makefile``` has all needed options to build, debug and burn project.<br/>
Use ```git clone https://github.com/Zontec/STM32-minimal-project.git``` to clone the project to local repo. 

## Building
Use ```make``` command to build project and ```make-info``` to get all supported make-options
## Structure 
**Bin** - has *hex*, *bin*, *elf* file after building <br/>
**Build** - consists of compiled project files <br/>
**CMSIS** - has cmsis files <br/>
**src** - user's source files <br/>
**lib** - basic stm libs <br/>
**startup** - consists of stm startup files <br/>
**target** - debug files <br/>
**info** - has info files <br/>

## Debugging
Project use ```JTAG``` to debug MCU.<br/>
Here are supported 2 options: with VSCode and using terminal.<br/>
**Using terminal**<br/>
First use ```make start-server``` to start [openocd](http://openocd.org/) server. Then use make ```make debug-info``` and follow recommendations.<br/>
**Using VSCode**<br/>
The project is configured for VSCode debugging and should work without any pre-setup. Open project in VSCode and press ```F5``` to start debug. All debug configuration is in ```launch.json``` file. 
 
 ## Another MCU usage
 The project has been build to work with stm32f407vgt MCU. To use another stone you should change all ```startup``` files that fit your MCU. Next change target files and ```.cfg``` file. In ```Makefile``` change compile configuration to your Cortex-M core.


## Basics
All ```STM``` mcu's has a liner memory of 4GB. In most cases RAM starts from the adress: 0x2000 0000. Program counter(PC) starts at 0x0800 0000. Heap groth up and stack down. It means, to find stack adress you need to add RAM size to start adress.<br/>
Example: if we have 20kb of ram, stack starts at 0x2000 0000 + 0x5000(20480) = 0x2000 5000.<br/>
<br/>
STM requers to init core before. Also there is a need to setup all memory blocks like .bss, .data etc. To solve this, ```startup``` assembler file is used.
<br/>
```openocd``` uses ```svd``` and ```cfg``` files for debug setup. If you don't use, f.e. st-link, you need to configure ```cfg``` file. 
<br/>```svd``` contains information about board and mcu.
