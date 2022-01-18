TITLE=Eugene's Space
RSYNC_DESTINATION=eug-vs.xyz:/var/www/website

MARKDOWN=gfm+emoji
STYLESHEET=/style.css
HEAD=head.html
HEADER=header.html
PANDOC_ARGS=-s --from=$(MARKDOWN) --to=html -c $(STYLESHEET) -B $(HEADER) -H $(HEAD) -M lang="en" --shift-heading-level-by=1 --highlight-style=gruvbox.theme

LINK_SEDSTRING=s/.md)/.html)/g;
EMOJI_SEDSTRING=$(shell ./compile_emoji_sedstring.sh)
LOCALIZE_SEDSTRING=s|\"/|\"$(PWD)/|;
UNLOCALIZE_SEDSTRING=s|$(PWD)||;


SOURCES=$(wildcard *.md blog/*.md articles/*.md)
HTML=$(patsubst %.md, %.html, $(SOURCES))


all: $(HTML)

%.html: %.md
	@echo $@
	@DESCRIPTION=$$(sed '2,/^$$/!d' $< | tr '\n' ' '); \
		PAGETITLE=$$(sed '/^#/q' $< | sed 's/:[a-z]*://; s/#* //'); \
		sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" $< \
		| pandoc $(PANDOC_ARGS) -M pagetitle="$$PAGETITLE | $(TITLE)" -M description="$$DESCRIPTION" > $@

index.html: index.md blog/preview.md
	@echo $@
	@DESCRIPTION=$$(sed '2,/^$$/!d' $< | tr '\n' ' '); \
		sed "/Recent blog posts/r blog/preview.md" $< \
		| sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" \
		| pandoc $(PANDOC_ARGS) -M pagetitle="$(TITLE)" -M description="$$DESCRIPTION"> $@

blog/preview.md: blog/index.md
	@echo $@
	@sed -n "s/^-/ -/; s|(|(blog/| ; /^ -/p" $< | head -n 4 > $@

open: $(HTML)
	xdg-open index.html

deploy: $(HTML)
	$(MAKE) unlocalize
	rsync -rtvzP --exclude=".git" --exclude="*.md" . $(RSYNC_DESTINATION)

localize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING) $(LOCALIZE_SEDSTRING)" $$file; done

unlocalize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING)" $$file; done

clean:
	rm -f $(HTML) blog/preview.md

