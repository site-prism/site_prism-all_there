# site_prism-all_there
The breakout gem from SitePrism to perform recursion checks for `#all_there?`

This gem is currently being developed by copying over the code-base from the existing
SitePrism repo and slowly refactoring it and breaking it out

As such at the moment, the gem is very much considered a Work in Progress and works "as is".

It is fully expected to have a number of bug-fix / refactor PR's in between each minor release.

In order to use this gem you simply need to do the following

```rb
# In either spec_helper.rb or env.rb

require 'site_prism/all_there

# Then in either a config or initializer location (Or env.rb / spec_helper.rb)

SitePrism.use_all_there_gem = true

or ...

SitePrism.configure do |config|
  config.use_all_there_gem = true
end
```

v1.0 is slated for release some-time in the Autumn/Winter of 2019, with a variety of small interim
releases being planned in the meantime.

Happy Testing / Developing!

The SitePrism team
