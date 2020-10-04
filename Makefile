SHELL = /bin/bash
.DELETE_ON_ERROR:
export URL

OUTPUT_DIR = ${HOME}/Documents/webpages/single-html
USER_AGENT = Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1
OPEN_CMD = open

markdown:
	$(MAKE) out/doc.md

save: dest = ${OUTPUT_DIR}/$(shell xidel --xpath '//meta[@name="filename"]/@content' $< 2>/dev/null)
save: out/doc.html
	cp out/doc.html ${dest}

edit: out/doc.md out/metadata.yml
	${EDITOR} $<

preview: out/doc.html
	${OPEN_CMD} $<

out/source.html:
	curl -A '${USER_AGENT}' ${URL} > $@
	[[ -s $@ ]]

out/metadata.yml:
	# https://github.com/kevinSuttle/html-meta-tags
	echo 'source:  ${URL}'                   >> $@
	echo 'date:    $(shell date --iso-8601)' >> $@

out/doc.md: out/source.html
	curl -XPOST http://fuckyeahmarkdown.com/go/ \
		--data-urlencode html@$< \
		> $@

out/doc.html: out/doc.md out/metadata.yml style.css
	bin/md2html $< > $@

clean:
	rm -f out/*
