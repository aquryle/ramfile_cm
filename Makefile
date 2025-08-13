# 成果物
TARGET = a
COPY_BIN = firmware.bin

# ツールチェイン指定
CC  := arm-none-eabi-gcc
LD  := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy

# オプション
INCLUDES := $(shell find src -type d -print)
CPU  := -mcpu=cortex-m33 -mthumb
CFLAGS := $(CPU) -O0 -g -ffreestanding -nostdlib $(addprefix -I, $(INCLUDES))
LDFLAGS := -T link_ram.ld -nostdlib

# ディレクトリ指定
SRCDIR := src
BUILDDIR := build
SRCS := $(shell find $(SRCDIR) -type f \( -name '*.c' -o -name '*.s' \))
OBJS := $(SRCS:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)
OBJS := $(OBJS:$(SRCDIR)/%.s=$(BUILDDIR)/%.o)

# 出力ファイル
ELF := $(BUILDDIR)/$(TARGET).elf
BIN := $(BUILDDIR)/$(TARGET).bin
SREC := $(BUILDDIR)/$(TARGET).srec


all: $(ELF) $(BIN) $(SREC) copy_bin

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(SREC): $(ELF)
	$(OBJCOPY) -O srec $< $@

# コピーしたbin（Makefile階層）
copy_bin: $(BIN)
	cp $< $(COPY_BIN)

# クリーン（build内だけ）
clean:
	rm -rf $(BUILDDIR)
