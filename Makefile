FILENAME = example
MD = markdown -x toc
PARTS = header body

.PHONY: md.body compile.html compile.pdf clean doc

md.body:
	@rm $(FILENAME).md > /dev/null &
	@sleep 1
	@for part in $(PARTS); do \
	   cat $$part.md >> $(FILENAME).md ; \
	done;

compile.html: md.body
	@rm $(FILENAME).html > /dev/null &
	@sleep 1
	@cat static/header.html > $(FILENAME).html
	@$(MD) $(FILENAME).md >> $(FILENAME).html
	@cat static/footer.html >> $(FILENAME).html

compile.pdf: md.body
	@rm $(FILENAME).html &
	@rm $(FILENAME).pdf &
	@sleep 1
	@cat static/header-pdf.html > $(FILENAME).html
	@$(MD) $(FILENAME).md >> $(FILENAME).html 
	@cat static/footer.html >> $(FILENAME).html
	@wkhtmltopdf $(FILENAME).html $(FILENAME).pdf

clean:
	@rm $(FILENAME).md > /dev/null &
	@rm $(FILENAME).html > /dev/null &
	@rm $(FILENAME).pdf > /dev/null &

doc: compile.pdf compile.html
