# site_prism-all_there

- [History](#history)
- [Usage](#usage)
  - [In-line parameter](#in-line-parameter)
  - [Global setting](#global-setting)

## History

This is the breakout gem from SitePrism to perform recursion checks in the `#all_there?` method

This gem is a breakout from `SitePrism::Page#all_there?` and `SitePrism::Section#all_there?` methods from site_prism v2

The gem is version stable. It is default enabled in `site_prism` v4 and above, no configuration is required!

## Usage

You can perform recursion either using an in-line keyword arg `recursion` or using a global setting

When using both it will always look **first** for an in-line parameter

### In-line parameter

```rb
your_page = YourPage.new

your_page.all_there?(recursion: :none)     # This will do the standard `#all_there?` check on the current page
your_page.all_there?(recursion: :one)      # This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections` objects and then doing the standard `#all_there?` check on those `Section` instances
your_page.all_there?(recursion: :invalid)  # This will not perform any checks and just log an error
```

### Global setting

```rb
SitePrism.recursion_setting = :one
your_page = YourPage.new
your_page.all_there? # This will do the standard `#all_there?` check on the current page as well recursive checks on all `:section` or `:sections` objects -> doing the standard `#all_there?` check on those `SitePrism::Section` instances

# or...

SitePrism.configure do |config|
  config.recursion_setting = :one
end

your_page = YourPage.new
your_page.all_there? # This will do the standard `#all_there?` check on the current page as well recursive checks on all `:section` or `:sections` objects -> doing the standard `#all_there?` check on those `SitePrism::Section` instances
```
