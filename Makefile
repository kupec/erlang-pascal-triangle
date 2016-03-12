APP=pascal
START=start

all: pascal.beam align.beam

%.beam: %.erl
	erlc $^

clean:
	rm -rf *.beam

run: all
	erl -noshell -s ${APP} ${START} -s init stop

