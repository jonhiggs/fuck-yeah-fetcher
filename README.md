# Fuck Yeah Fetcher

Generate a clean, fully resolved HTML document from a URL.

The outputted file has no external dependences. All images and CSS are embedded directly into the HTML file.


## Usage

This is not a fully automated tool. The web is unpredictable and trying to capture every edge-case is futile. Instead, a markdown document is generated from the HTML which you can massage until it generates the desired output.

1. `make preview URL="http://whatever.com"`: Start by checking the initial result.

2. `make edit`: Modify the markdown and run `make preview`. Continue until the final document meets your expectations.

3. `make save`: Save the final document as a single-page HTML file `OUTPUT_DIR`.


## How it works

1. Fetch the source HTML
1. Extract the content from the HTML using [Fuck Yeah Markdown][fuckyeah]
1. Create a HTML document from the Markdown which includes the CSS stylesheet and all images.



[fuckyeah]: http://fuckyeahmarkdown.com/
