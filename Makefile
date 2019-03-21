# Generic
PYTHON=${VENV_PATH}/python
TIMESTAMP=$(shell date +"%Y%m%d%H%M%S")

# Name of the virtual env
VENV_NAME=python/.venv


# Path to the virtual env
VENV_PATH=$(VENV_NAME)/bin


PHONY: help


help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# Internals
venv: ${VENV_PATH}/activate

${VENV_PATH}/activate: requirements.txt
	test -d ${VENV_NAME} || virtualenv -p python3.6 ${VENV_NAME}
	${VENV_PATH}/pip install -Ur requirements.txt
	touch ${VENV_PATH}/activate
	@echo Requirements install done

# Commands
console: venv  ## Start python3 console in the vitrual environment
	@${PYTHON}

jupyter: venv
	. ${VENV_PATH}/activate; jupyter notebook

clean:
	@find -name *.pyc -delete
	@find -name __pycache__ -delete
	@echo Python cache files deleted


run: venv  ## Sample call 
	@${PYTHON} python/main.py 
