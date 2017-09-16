.PHONY: clean examples tutorials

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

examples:
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	cd plotnine_examples/examples; \
	for file in *.ipynb; do \
	   jupyter nbconvert --to notebook --execute "$${file}" --output "$${file}"; \
	done

tutorials:
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	cd plotnine_examples/tutorials; \
	for file in *.ipynb; do \
	   jupyter nbconvert --to notebook --execute "$${file}" --output "$${file}"; \
	done

changes:
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	files=$$(git status --porcelain | grep -E '\.ipynb$$' | sed s/^...//); \
	for path in $$files; do \
	   DIR=$$(dirname "$${path}"); \
	   file=$$(basename "$${path}"); \
	   pushd $$DIR; \
	   jupyter nbconvert --to notebook --execute "$${file}" --output "$${file}"; \
	   popd; \
	done

all: examples tutorials
