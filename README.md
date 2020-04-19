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
