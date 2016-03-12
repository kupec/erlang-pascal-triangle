APP=app
START=start

all: src/app.beam src/align.beam src/pascal.beam

%.beam: %.erl
	erlc $^

clean:
	rm -rf *.beam *.dump

run: all
	erl -noshell -s ${APP} ${START} -s init stop

