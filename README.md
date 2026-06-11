# site_prism-all_there

- [History](#history)
- [Usage](#usage)
  - [In-line parameter](#in-line-parameter)
  - [Global setting](#global-setting)

## History

This is the breakout gem from SitePrism to perform recursion checks in the `#all_there?` method.

This gem was originally broken out from `SitePrism::Page#all_there?` and `SitePrism::Section#all_there?` which were
methods present in the v2 revision of `site_prism` proper.

The gem is version stable. It is configured by default from `site_prism` v4 onwards, no configuration is required!

## Usage

You can perform recursion either using an in-line keyword argument (`recursion`), or using a global setting.

When using both it will always look **initially** at the in-line supplied keyword argument.

### In-line parameter

```rb
your_page = YourPage.new

# This will do the standard `#all_there?` check on the current page **ONLY**. It will not recurse into
# any `:section` or `:sections` objects that were defined on the page. It will only perform the `#all_there?` check on
# the supplied `SitePrism::Section` or `SitePrism::Page`.
your_page.all_there?(recursion: :none)

# This will do the standard `#all_there?` check on the current page as well recursing into all `:section` or `:sections`
# objects that were defined on the page. It will then perform the `#all_there?` check on all `SitePrism::Section` instances
your_page.all_there?(recursion: :one)

# This will not perform any checks and just log an error
your_page.all_there?(recursion: :invalid)  
```

### Global setting

Both of these options will do the standard `#all_there?` check on the current page as well recursing into all
`:section` or `:sections` objects that were defined on the page. It will then perform the `#all_there?` check on all
`SitePrism::Section` instances found.

```rb
SitePrism.recursion_setting = :one
your_page = YourPage.new
your_page.all_there?

# or...

SitePrism.configure do |config|
  config.recursion_setting = :one
end

your_page = YourPage.new
your_page.all_there?
```
