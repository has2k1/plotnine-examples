.PHONY: help Makefile
.DEFAULT_GOAL := help

SHELL := /bin/bash


define PRINT_HELP_PYSCRIPT
import re
import sys

target_pattern = re.compile(r"^([a-zA-Z1-9_-]+):.*?## (.*)$$")
for line in sys.stdin:
	match = target_pattern.match(line)
	if match:
		target, help = match.groups()
		print(f"{target:<20} {help}")
endef
export PRINT_HELP_PYSCRIPT

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-pyc clean-build  ## Remove build artefacts

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

gallery-tags:  ## List of unique tags gallery worthy output
	@grep -Ehrao "# Gallery, \w+" plotnine_examples | sort | uniq

examples:  ## Run notebooks in plonine/examples/
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

tutorials:  ## Run notebooks in plonine/tutorials/
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

changes:  ## Run notebooks whose source has changed
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

all: examples tutorials  ## Run all notebooks
