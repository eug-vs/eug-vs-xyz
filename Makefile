TITLE=Eugene's Space
RSYNC_DESTINATION=eug-vs.xyz:/var/www/website

MARKDOWN=gfm+emoji
STYLESHEET=/style.css
HEAD=head.html
HEADER=header.html
RSS_FEED=blog/index.xml
OPENRING_FOOTER=footer.html
PANDOC_ARGS= --from=$(MARKDOWN) --to=html
PANDOC_HTML_ARGS=-s $(PANDOC_ARGS) -c $(STYLESHEET) -B $(HEADER) -H $(HEAD) -M lang="en" --shift-heading-level-by=1 --highlight-style=gruvbox.theme

LINK_SEDSTRING=s/.md)/.html)/g;
EMOJI_SEDSTRING=$(shell ./compile_emoji_sedstring.sh)
LOCALIZE_SEDSTRING=s|\"/|\"$(PWD)/|;
UNLOCALIZE_SEDSTRING=s|$(PWD)||;

OPENRING_ARGS=$(shell ./compile_openring_args.sh)


SOURCES=$(wildcard *.md blog/*.md articles/*.md)
HTML=$(patsubst %.md, %.html, $(SOURCES))
XML=$(patsubst %.md, %.xml, $(filter-out blog/preview.md, $(filter-out blog/index.md, $(wildcard blog/*.md))))


all: $(HTML) $(RSS_FEED)

%.html: %.md $(OPENRING_FOOTER)
	@echo $@
	@DESCRIPTION=$$(sed '2,/^$$/!d' $< | tr '\n' ' '); \
		PAGETITLE=$$(sed '/^#/q' $< | sed 's/:[a-z]*://; s/#* //'); \
		sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" $< \
		| pandoc $(PANDOC_HTML_ARGS) -M pagetitle="$$PAGETITLE | $(TITLE)" -A $(OPENRING_FOOTER) -M description="$$DESCRIPTION" > $@

%.xml: %.md
	@echo $@
	@echo '<item>' > $@
	@echo "  <link>https://eug-vs.xyz/$*.html</link>" >> $@
	@echo "  <pubDate>$$(date --rfc-email -d $$(basename $*))</pubDate>" >> $@
	@echo "  <title>$$(sed '/^#/q' $< | sed 's/:[a-z]*://; s/#* //')</title>" >> $@
	@echo "  <description><![CDATA[" >> $@
	@sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" $< | pandoc $(PANDOC_ARGS) $< >> $@
	@echo "  ]]></description>" >> $@
	@echo '</item>' >> $@

$(RSS_FEED): $(XML)
	@echo $@
	@echo '<rss version="2.0"><channel>' > $@
	@echo "<title>Eugene's Space</title><link>https://eug-vs.xyz</link><description>Eugene's blog</description>" >> $@
	@echo "<lastBuildDate>$$(date --rfc-email)</lastBuildDate>" >> $@
	@cat $$(echo $^ | tr " " "\n" | sort -r | tr "\n" " ") >> $@
	@echo '</channel></rss>' >> $@

index.html: index.md blog/preview.md
	@echo $@
	@DESCRIPTION=$$(sed '2,/^$$/!d' $< | tr '\n' ' '); \
		sed "/Recent blog posts/r blog/preview.md" $< \
		| sed "$(LINK_SEDSTRING) $(EMOJI_SEDSTRING)" \
		| pandoc $(PANDOC_HTML_ARGS) -M pagetitle="$(TITLE)" -M description="$$DESCRIPTION"> $@

$(OPENRING_FOOTER): openring-template.html
	@echo $@
	@openring $(OPENRING_ARGS) < $< > $@

blog/preview.md: blog/index.md
	@echo $@
	@sed -n "s/^-/ -/; s|(|(blog/| ; /^ -/p" $< | head -n 4 > $@

open: $(HTML)
	xdg-open index.html

deploy: all
	$(MAKE) unlocalize
	rsync -rtvzP --include="$(RSS_FEED)" --exclude=".git" --exclude="*.md" --exclude="*.xml" . $(RSYNC_DESTINATION)

localize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING) $(LOCALIZE_SEDSTRING)" $$file; done

unlocalize: $(HTML)
	@for file in $^; do sed -i "$(UNLOCALIZE_SEDSTRING)" $$file; done

update_openring:
	rm -rf $(OPENRING_FOOTER)
	$(MAKE) $(OPENRING_FOOTER)

clean:
	rm -f $(HTML) $(XML) $(RSS_FEED) blog/preview.md

