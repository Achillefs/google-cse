# google-cse [![Build Status](https://travis-ci.org/Achillefs/google-cse.png?branch=master)](https://travis-ci.org/Achillefs/google-cse)

A wee Google CSE client. Use it to easily query your custom search engine. Supports image search.

## Installation

Add this line to your application's Gemfile:

    gem 'google-cse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-cse

## Usage

Set it up:

	require 'google_cse'
	GoogleCSE::CX = '004660295420853704579:8tths02yqhc'
	GoogleCSE::KEY = 'AIzaSyD_yJk60g--MHz5yQ39k6tIrG0S7zpKLLk'

If you are on a rails app, you should stick the constants in an initializer

Run a search and visit the first result, 'feeling lucky' style (on a mac):

    g = GoogleCSE.search('Ian Kilminster')
    `open -a Safari #{g.fetch.results.first.link}`

Do the same for an image:

	g = GoogleCSE.image_search('Ian Kilminster')
	img = g.fetch.results.first.link
	file = img.split('/').last
	File.open(file,'w') {|f| f.write(open(img).read)} 
    `open -a Preview #{file}`

Paginated access:

	g = GoogleCSE.image_search('Ian Kilminster')
	g.fetch.results.first.link # fetches first page, first result
	#=> http://en.wikipedia.org/wiki/Lemmy
	g.next.results.first.link # fetches next page, first result
	#=> http://www.discogs.com/artist/Ian+Fraser+Kilmister
	g.previous.results.first.link # ...and back to first page
	#=> http://en.wikipedia.org/wiki/Lemmy

You can specify any extra parameters the API allows. View a complete list [here](https://developers.google.com/custom-search/v1/cse/list)

Example:

	# Only return large jpegs, I can't enjoy such high art otherwise
	g = GoogleCSE.image_search('Flight of Icarus Cover', :fileType => :jpg, :imgSize => :large)
	#=> http://musictrajectory.com/wp-content/uploads/2011/08/iron-maiden-flight-of-icarus-single-cover.jpg

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request