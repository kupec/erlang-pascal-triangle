#!/bin/bash

APP=pascal
SOURCE=${APP}.erl

erlc $SOURCE && erl -noshell -s $APP start -s init stop;

