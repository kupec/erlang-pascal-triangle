APP=app
START=start

all: app.beam align.beam pascal.beam

%.beam: %.erl
	erlc $^

clean:
	rm -rf *.beam *.dump

run: all
	erl -noshell -s ${APP} ${START} -s init stop

