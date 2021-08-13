RSYNC_DESTINATION=root@eug-vs.xyz:/var/www/website
BROWSER=brave

MARKDOWN=gfm+emoji
STYLESHEET=/style.css
HEAD=head.html
HEADER=header.html
TITLE=Eugene's Space
PANDOC_ARGS=-s --from=$(MARKDOWN) --to=html -c $(STYLESHEET) -B $(HEADER) -H $(HEAD) --shift-heading-level-by=1 --highlight-style=gruvbox.theme

LINK_SEDSTRING=s/.md)/.html)/g;
EMOJI_SEDSTRING=$(shell ./compile_emoji_sedstring.sh)
LOCALIZE_SEDSTRING=s|\"/|\"$(PWD)/|;
UNLOCALIZE_SEDSTRING=s|$(PWD)||;


SOURCES=$(wildcard *.md blog/*.md)
HTML=$(patsubst %.md, %.html, $(SOURCES))


all: $(HTML)

%.html: %.md
	@echo $@
	@PAGETITLE=$$(sed '/^#/q' $< | sed 's/:[a-z]*://; s/#* //'); \
		sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" $< \
		| pandoc $(PANDOC_ARGS) -M pagetitle="$$PAGETITLE | $(TITLE)" > $@

index.html: index.md blog/preview.md
	@echo $@
	@sed "/Recent blog posts/r blog/preview.md" $< \
		| sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" \
		| pandoc $(PANDOC_ARGS) -M pagetitle="$(TITLE)" > $@

blog/preview.md: blog/index.md
	@echo $@
	@sed -n "s/^-/ -/; s|(|(blog/| ; /^ -/p" $< | head -n 4 > $@

open: $(HTML)
	$(BROWSER) index.html

deploy: $(HTML)
	$(MAKE) unlocalize
	rsync -zarv --exclude=".git" --exclude="*.md" . $(RSYNC_DESTINATION)

localize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING) $(LOCALIZE_SEDSTRING)" $$file; done

unlocalize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING)" $$file; done

clean:
	rm -f $(HTML) blog/preview.md

