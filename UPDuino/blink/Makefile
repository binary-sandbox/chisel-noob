PROJECT=blink
PCF=blink.pcf
DEVICE=up5k
FREQ=48 #MHz

SRC= blink.v

all: bit

build/project.src: $(SRC)
	@[ -d build ] || mkdir build
	@[ -d simulation ] || mkdir simulation
	@rm -f $@
	for i in $(SRC); do echo verilog work ../$$i >> $@; done

build/$(PROJECT).ys: build/project.src
	echo "read_verilog $(SRC)" > $@
	echo "synth_ice40 -top $(PROJECT)" >> $@
	echo "write_json build/$(PROJECT).json" >> $@

syn: build/$(PROJECT).ys
	yosys build/$(PROJECT).ys

build/$(PROJECT).asc : syn build/$(PROJECT).json
	nextpnr-ice40 --pcf $(PCF) --json build/$(PROJECT).json --asc build/$(PROJECT).asc --$(DEVICE) --freq $(FREQ)

$(PROJECT).bin: build/$(PROJECT).asc  
	icepack build/$(PROJECT).asc $(PROJECT).bin

bit: $(PROJECT).bin

clean:
	rm -rf build/
	rm $(PROJECT).bin

cleanall:
	rm -rf build/
	rm $(PROJECT).bin
	rm -rf simulation/

upload: 
	sudo iceprog $(PROJECT).bin