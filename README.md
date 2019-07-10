# site_prism-all_there
The breakout gem from SitePrism to perform recursion checks for `#all_there?`

This gem is currently being developed by copying over the code-base from the existing
SitePrism repo and slowly refactoring it and breaking it out

As such at the moment, the gem is very much considered a Work in Progress and works "as is".

It is fully expected to have a number of bug-fix / refactor PR's in between each minor release.

Add the following code to either `spec_helper.rb` or `env.rb`

```rb
require 'site_prism/all_there

SitePrism.use_all_there_gem = true

# or...

SitePrism.configure do |config|
  config.use_all_there_gem = true
end
```

This gem is currently in the `0.x` phase, meaning it is API unstable and likely to change
structure going forwards, to conform to the pairing of both gems.

Happy Testing / Developing!

The SitePrism team
