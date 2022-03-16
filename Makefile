DATA_DIR := data
TEST_DIR := tests
SOURCE_DIR := itk_transformer_nlp

SQUAD_SAMPLE = $(DATA_DIR)/squad_sample.jsonl
$(SQUAD_SAMPLE):
	@if ! [ -d $(DATA_DIR) ]; then mkdir $(DATA_DIR); fi
	python3 itk_transformer_nlp/download_dataset.py squad $(SQUAD_SAMPLE) --split validation \
	--shuffle --sample-size 10

qa_on_squad: $(SQUAD_SAMPLE)
	python3 $(TEST_DIR)/test_transformer_qa.py; \
	if [ $$? -eq 0 ]; then python3 $(SOURCE_DIR)/transformer_qa.py $(SQUAD_SAMPLE); fi
.PHONY: qa_on_squad