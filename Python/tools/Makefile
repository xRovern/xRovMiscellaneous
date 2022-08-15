ENV=venv

clean:
	rm -rf $(ENV)
	find . -type f -name ‘*.pyc’ -delete

init:
	python -m venv $(ENV)
	$(ENV)/bin/pip install -U pip

install: init
	$(ENV)/bin/pip install -q -r requiremnts.txt

install-dev: init
	$(ENV)/bin/pip install -q -r requiremnts_dev.txt

format: install-dev
	$(ENV)/bin/black ./

# test: install-dev
#	 $(ENV)/bin/python -m pytest ../tests
