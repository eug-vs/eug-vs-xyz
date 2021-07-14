RSYNC_DESTINATION=root@eug-vs.xyz:/var/www/website
BROWSER=brave

MARKDOWN=gfm+emoji
STYLESHEET=/style.css
HEADER=header.html
ICON=icon.html
PAGETITLE="Eugene's Space"
PANDOC_ARGS=-s --from=$(MARKDOWN) --to=html -c $(STYLESHEET) -B $(HEADER) -H $(ICON) -M pagetitle=$(PAGETITLE) --shift-heading-level-by=1 --highlight-style=gruvbox.theme

LINK_SEDSTRING=s/.md)/.html)/g;
EMOJI_SEDSTRING=$(shell ./compile_emoji_sedstring.sh)

SOURCES=$(wildcard *.md blog/*.md)
HTML=$(patsubst %.md, %.html, $(SOURCES))


all: $(HTML)

%.html: %.md
	@echo $@
	@sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" $< | pandoc $(PANDOC_ARGS) > $@

index.html: index.md blog/preview.md
	@echo $@
	@sed "/Recent blog posts/r blog/preview.md" $< | sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" | pandoc $(PANDOC_ARGS) > $@

blog/preview.md: blog/index.md
	@echo $@
	@sed -n "s/^-/ -/; /^ -/p" $< | head -n 4 > $@

open: $(HTML)
	$(BROWSER) index.html

deploy: $(HTML)
	rsync -zarv --exclude=".git" --exclude="*.md" . $(RSYNC_DESTINATION)

clean:
	rm -f $(HTML) blog/preview.md

