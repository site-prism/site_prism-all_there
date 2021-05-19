# site_prism-all_there

The breakout gem from SitePrism to perform recursion checks for `#all_there?`

This gem is a breakout of the current `SitePrism::Page#all_there?` and `SitePrism::Section#all_there?`
methods which already exist.

The gem is currently released as `1.0` meaning it is version stable. A full `site_prism` release that permits
the usage of this will be coming shortly!

## Usage

Add the following code to either `spec_helper.rb` or `env.rb`

```rb
require 'site_prism/all_there'

SitePrism.use_all_there_gem = true

# or...

SitePrism.configure do |config|
  config.use_all_there_gem = true
end
```

This gem is likely to change structure going forwards, to conform to the pairing of both gems, expected in 2020.

Happy Testing / Developing!

The SitePrism team
