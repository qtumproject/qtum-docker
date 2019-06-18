# files to be built
# fill this in as a template
HDRS = 
C_SRC = helloworld.c
OUTPUT = helloworld.elf
LIBS = 
BYTECODE = helloworld.qbit

C_OBJS = $(subst .c,.o,$(C_SRC))

#these default flags will just remove dead code and give warnings
CFLAGS += -Wall -ffunction-sections -fdata-sections
LDFLAGS += -Wl,--gc-section


default: $(BYTECODE)

$(BYTECODE): $(OUTPUT)
	qx86-codeify -elf $(OUTPUT) -hex -o $(BYTECODE)

$(OUTPUT): $(C_OBJS)
	$(CC) $(LDFLAGS) -o $(OUTPUT) $(C_OBJS) $(LIBS)

$(C_OBJS): $(HDRS) $(C_SRC)
	$(CC) $(CFLAGS) -c $*.c -o $@

clean:
	rm -f $(C_OBJS) $(OUTPUT) $(BYTECODE)