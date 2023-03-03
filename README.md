# site_prism-all_there

The breakout gem from SitePrism to perform recursion checks for `#all_there?`

This gem is a breakout of the current `SitePrism::Page#all_there?` and `SitePrism::Section#all_there?`
methods which have already existed in the gem proper since version 2.

The gem is **now finally** version stable. It will be added as default
functionality in `site_prism` version 4. Which is slated for release early 2023!

## Enabling gem methods

- Add the following code to either `spec_helper.rb` or `env.rb` (Pre version 4)

```rb
require 'site_prism/all_there'

SitePrism.use_all_there_gem = true

# or...

require 'site_prism/all_there'

SitePrism.configure do |config|
  config.use_all_there_gem = true
end
```

> From version 4 onwards this is done by default and isn't required

## Usage

### In-line recursions

```rb
your_page = YourPage.new

your_page.all_there?(recursion: :none)     # This will do the standard `#all_there?` check on the current page
your_page.all_there?(recursion: :one)      # This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections` objects and then doing the standard `#all_there?` check on those `Section` instances
your_page.all_there?(recursion: :invalid)  # This will not perform any checks and just throw an error message
```

### Global configuration

```rb
SitePrism.recursion_setting = :one
your_page = YourPage.new
your_page.all_there?(recursion: :ignore) # This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections` objects and then doing the standard `#all_there?` check on those sections
# or...

SitePrism.configure do |config|
  config.recursion_setting = :one
end

your_page = YourPage.new
your_page.all_there?(recursion: :ignore) # This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections` objects and then doing the standard `#all_there?` check on those `Section` instances
```

Then you can perform the above checks using the global config.

> NB: Mixing and matching the global config won't work - To come in v3!

Happy Testing / Developing!

The SitePrism team
