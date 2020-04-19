
TARGET			=main
BUILD_DIR		=build
STMLIB_DIR		=lib
CMSIS_DIR		=CMSIS
STARTUP_DIR		=startup
SRC_DIR			=src
BIN_DIR			=bin
INFO_DIR		=info
FLASH_TOOL		=/home/user/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI
CONFIG_FILE		=stm32f4discovery
#				Tools
###################################################

CC	=arm-none-eabi-gcc
LD	=arm-none-eabi-gcc
AR	=arm-none-eabi-ar
AS	=arm-none-eabi-as
CP	=arm-none-eabi-objcopy
OD	=arm-none-eabi-objdump
SE	=arm-none-eabi-size
RM 	=rm

#				Include dirs
###################################################

INC_DIRS += $(STMLIB_DIR)/
INC_DIRS += $(CMSIS_DIR)/
INC_DIRS += $(STARTUP_DIR)/
INC_DIRS += $(SRC_DIR)/

INC_DIRS += .

INCLUDE = $(addprefix -I,$(INC_DIRS))



#					Compiler flags
###################################################
CFLAGS  += -O0 
CFLAGS  += -g 
CFLAGS  += -Wall 
CFLAGS  += -mcpu=cortex-m4 -mthumb 
CFLAGS  += -mfpu=fpv4-sp-d16 -mfloat-abi=hard 
CFLAGS  += -std=c99
CFLAGS  += -I. $(INCLUDE) -DUSE_STDPERIPH_DRIVER


#CFLAGS  +=  -specs=nosys.specs -specs=nano.specs

#					Linker flags
###################################################
LDFLAGS += -T$(LDSCRIPT) -mthumb -mcpu=cortex-m4 -nostdlib

#					Source files
###################################################
SRCS += main.c
SRCS += $(SRC_DIR)/test.c

SRCS += $(STMLIB_DIR)/stm32f4xx_gpio.c
SRCS += $(STMLIB_DIR)/stm32f4xx_rcc.c

SRCS += $(STMLIB_DIR)/stm32f4xx_usart.c
SRCS += $(STMLIB_DIR)/stm32f4xx_flash.c

#					Startup files
##################################################
SRCS += $(STARTUP_DIR)/stm32f407vg.S 
SRCS += $(STMLIB_DIR)/system_stm32f4xx.c

#					Link files
##################################################
LDSCRIPT = $(STARTUP_DIR)/stm32f407vg.ld


#					Output
###################################################
OBJECTS = $(addprefix $(BUILD_DIR)/, $(addsuffix .o, $(basename $(SRCS))))

#					Output
###################################################
FLASH_PARAMS = -c port=SWD -w


#					Logic
###################################################



$(BIN_DIR)/$(TARGET).elf: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS) $(LDLIBS)

$(BUILD_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.o: %.s
	mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) $< -o $@

rebuild:
	rm -rf ./$(BUILD_DIR)
	make

flash:
	$(FLASH_TOOL) $(FLASH_PARAMS) $(BIN_DIR)/$(TARGET).elf

clean:
	rm -rf ./$(BIN_DIR)

start-server:
	gnome-terminal
	openocd -f $(shell pwd)/$(CONFIG_FILE).cfg

help:
	cat $(INFO_DIR)/README.info

debug-info:
	cat $(INFO_DIR)/README.debug