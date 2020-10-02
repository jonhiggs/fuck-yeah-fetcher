.DELETE_ON_ERROR:
export URL

markdown:
	$(MAKE) out/doc.md

out/source.html:
	curl ${URL} > $@

out/metadata.yml:
	# https://github.com/kevinSuttle/html-meta-tags
	echo 'original-source:  ${URL}'                   >> $@
	echo 'date:             $(shell date --iso-8601)' >> $@

out/doc.md: out/source.html
	curl -XPOST http://fuckyeahmarkdown.com/go/ \
		--data-urlencode html@$< \
		> $@

out/doc.html: out/doc.md
	bin/md2html $< > $@

clean:
	rm -f source.* out.*
