.PHONY: clean notebooks

clean: clean-pyc clean-build

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

notebooks:
	cd plotnine_examples/notebooks; \
	for file in *.ipynb; do \
	   jupyter nbconvert --to notebook --execute "$${file}" --output "$${file}"; \
	done

release: clean
	python setup.py sdist bdist_wheel
	twine upload dist/*
