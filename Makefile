FILENAME = example
MD = markdown -x toc
PARTS = header body

md.body:
	@rm $(FILENAME).md 2> /dev/null &
	@sleep 1
	@for part in $(PARTS); do \
	   cat $$part.md >> $(FILENAME).md ; \
	done;

compile.html: md.body
	@rm $(FILENAME).html 2> /dev/null &
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
	@rm $(FILENAME).md 2> /dev/null &
	@rm $(FILENAME).html 2> /dev/null &
	@rm $(FILENAME).pdf 2> /dev/null &

doc:
	@$(MAKE) compile.pdf
	@$(MAKE) compile.html
