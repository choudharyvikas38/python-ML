install:
	pip install --upgrade pip &&\
		pip install -r dependencies.txt

test:
	python -m pytest -v tests

format:
	black src/*.py

lint:
	pylint --disable=R,C src/HelloWorld.py

all: install lint test format