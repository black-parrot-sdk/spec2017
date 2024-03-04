include Makefile.frag

RUNS = $(patsubst %,%.riscv,$(BENCHMARKS))
INPUTS = $(foreach BENCH,$(BENCHMARKS),inputs/$(BENCH))

all:
	$(MAKE) $(RUNS)

inputs:
	$(MAKE) $(INPUTS)

spec2017:
	-git clone git@github.com:black-parrot-sdk/spec2017-private spec2017

%.riscv: spec2017
	$(MAKE) -f Makefile.$* $@
	$(MAKE) -f Makefile.$* clean

inputs/%: spec2017
	$(MAKE) -f Makefile.$* $@
	$(MAKE) -f Makefile.$* clean

clean:
	for benchmark in $(BENCHMARKS) ; do \
	rm -rf $$benchmark.riscv; \
	$(MAKE) -f Makefile.$$benchmark clean; \
	done;
