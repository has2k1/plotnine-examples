SHELL := /bin/bash

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
	export PYDEVD_DISABLE_FILE_VALIDATION=1; \
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	clean_notebook=$$(git rev-parse --show-toplevel)/tools/clean-notebook; \
	cd plotnine_examples/examples; \
	for file in *.ipynb; do \
	   python -Xfrozen_modules=off -m jupyter nbconvert --to notebook --inplace --execute "$${file}"; \
	   if [[ "$$?" != "0" ]]; then \
	       echo "$$(tput setaf 1)$${file}$$(tput sgr0)"; \
	   fi; \
	   $$clean_notebook "$${file}" > "$${file}.$$$$" && mv "$${file}.$$$$" "$${file}"; \
	done

tutorials:
	export PYDEVD_DISABLE_FILE_VALIDATION=1; \
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	clean_notebook=$$(git rev-parse --show-toplevel)/tools/clean-notebook; \
	cd plotnine_examples/tutorials; \
	for file in *.ipynb; do \
	   [[ "$${file}" =~ pyqt ]] && continue; \
	   python -Xfrozen_modules=off -m jupyter nbconvert --to notebook --inplace --execute "$${file}"; \
	   if [[ "$$?" != "0" ]]; then \
	       echo "$$(tput setaf 1)$${file}$$(tput sgr0)"; \
	   fi; \
	   $$clean_notebook "$${file}" > "$${file}.$$$$" && mv "$${file}.$$$$" "$${file}"; \
	done

changes:
	export PYDEVD_DISABLE_FILE_VALIDATION=1; \
	export PYTHONWARNINGS="ignore::FutureWarning::,ignore::DeprecationWarning::"; \
	clean_notebook=$$(git rev-parse --show-toplevel)/tools/clean-notebook; \
	files=$$(git status --porcelain | grep -E '\.ipynb$$' | sed s/^...//); \
	for path in $$files; do \
	   DIR=$$(dirname "$${path}"); \
	   file=$$(basename "$${path}"); \
	   pushd $$DIR; \
	   python -Xfrozen_modules=off -m jupyter nbconvert --to notebook --inplace --execute "$${file}"; \
	   if [[ "$$?" != "0" ]]; then \
	       echo "$$(tput setaf 1)$${file}$$(tput sgr0)"; \
	   fi; \
	   $$clean_notebook "$${file}" > "$${file}.$$$$" && mv "$${file}.$$$$" "$${file}"; \
	   popd; \
	done

all: examples tutorials
