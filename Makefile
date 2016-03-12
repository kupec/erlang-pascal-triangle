APP=app
START=start

all: app.beam align.beam

%.beam: %.erl
	erlc $^

clean:
	rm -rf *.beam

run: all
	erl -noshell -s ${APP} ${START} -s init stop

