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
	GoogleCSE::CX = 'a-cse-identifier'
	GoogleCSE::KEY = 'a-googleapis-app-key'

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

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request