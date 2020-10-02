.DELETE_ON_ERROR:
export URL

OUTPUT_DIR = ${HOME}/Documents/webpages/single-html

markdown:
	$(MAKE) out/doc.md

save: dest = ${OUTPUT_DIR}/$(shell xidel --xpath '//meta[@name="filename"]/@content' $< 2>/dev/null)
save: out/doc.html
	echo '${filename}'
	cp out/doc.html ${dest}

out/source.html:
	curl ${URL} > $@

out/metadata.yml:
	# https://github.com/kevinSuttle/html-meta-tags
	echo 'source:  ${URL}'                   >> $@
	echo 'date:    $(shell date --iso-8601)' >> $@

out/doc.md: out/source.html
	curl -XPOST http://fuckyeahmarkdown.com/go/ \
		--data-urlencode html@$< \
		> $@

out/doc.html: out/doc.md
	bin/md2html $< > $@

clean:
	rm -f source.* out.*
