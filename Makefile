.PHONY: help test test-report

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


test: ## Run all tests with coverage
	@flutter test --no-pub --coverage --test-randomize-ordering-seed=random

test-report: test ## Run all tests with html coverage report
	@echo "Generating html report..."
	@genhtml coverage/lcov.info -o coverage/html
	@open coverage/html/index.html