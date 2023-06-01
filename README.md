# site_prism-all_there
- [History](#history)
- [Enabling gem methods](#enabling-gem-methods)
- [Usage](#usage)
  - [In-line configuration](#in-line-configuration)
  - [Global configuration](#global-configuration)
- [Troubleshooting](#troubleshooting)

## History

This in the breakout gem from SitePrism to perform recursion checks for `#all_there?`

This gem is a breakout of the current `SitePrism::Page#all_there?` and `SitePrism::Section#all_there?`
methods which have already existed in the gem since version 2

The gem is **now finally** version stable. It is now default functionality in `site_prism` version 4

## Enabling gem methods

The gem methods are now (by default), enabled with `site_prism` version 4 and above

## Usage

### In-line configuration

```rb
your_page = YourPage.new

your_page.all_there?(recursion: :none)     # This will do the standard `#all_there?` check on the current page
your_page.all_there?(recursion: :one)      # This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections` objects and then doing the standard `#all_there?` check on those `Section` instances
your_page.all_there?(recursion: :invalid)  # This will not perform any checks and just log an error
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

## Troubleshooting

**Mixing and matching the global config won't work - To come in v3!**

Happy Testing / Developing!

The SitePrism team
