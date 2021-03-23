## [Unreleased]
### Removed

### Added

### Changed
- Massively bumped internal dev requirements
  ([luke-hill])

- **Required Ruby Version is now 2.5+** ([#20])
  ([luke-hill])

### Fixed
- Fixed up some tests which weren't running against the correct code-path ([#20])

## [0.3.2] - 2019-12-16
### Added
- Full `yard` documentation coverage of entire gem
([luke-hill])

### Changed
- Altered rspec tests to only make 1 assertion per test
([luke-hill])

- DRYed up the `ExpectedItems` class to only have the public `array` method call the other defined methods
([luke-hill])

## [0.3.1] - 2019-12-09
### Changed
- Bumped internal rubocop dev requirement from `0.73` to `0.75`
([luke-hill])

### Fixed
- Fixed an issue where `ExpectedItems` wasn't added to the gems load path ([#12])
([luke-hill])

## [0.3] - 2019-09-05
### Added
- Added `rubocop-performance` and `rubocop-rspec` gems to development dependencies
  - Upped existing `rubocop` requirement and fixed up all new offenses
([luke-hill])

- Add all DSL items as callable methods on `ExpectedItems`
  - Removes some magic numbers from areas of the codebase where specific elements "worked"
([luke-hill])

## [0.2.1] - 2019-08-01
### Changed
- Refactored the code into another secondary class: `ExpectedItems`
  - This further splits the code up for easier triaging / extension
([luke-hill])

## [0.2] - 2019-07-11
### Added
- Global / runtime config option for `all_there?` can now be passed in
  - At runtime pass in either `:none` or `:one` to recurse or not recurse
  - A global config of `SitePrism.recursion_setting` can also be used (Same values)
  - By default this will be set to `:one`

### Fixed
- The file locations / names of all files / test files to avoid namespace conflicts
  - This in theory shouldn't have affected anyone as the code was unconsumed
([luke-hill])

## [0.1.1] - 2019-07-03
### Removed
- HACKING.md is now nice and concise, removed almost all the crud!
([luke-hill])

### Added
- Configuration settings are now located in the `SitePrism` namespace to sit alongside the main gem
([luke-hill])

- Added mocked specs to test about 80% of the codebase
([luke-hill])

- Added base usage docs in README
([luke-hill])

### Changed
- Altered the build pipeline for travis to run in under half the time (Removing unnecessary items)
([luke-hill])

- Use latest rubocop settings and fix up all cop offenses in suite
([luke-hill])

- Refactored the code into a secondary class: `MappedItems` to try make error triaging easier
([luke-hill])

### Fixed
- Travis build now passes (ruby-head ignore issue)
([luke-hill])

## [0.1] - 2019-07-01
### Added
- Base code from site_prism repo
([luke-hill])

<!-- Releases -->
[Unreleased]: https://github.com/site-prism/site_prism-all_there/compare/v0.3.2...master
[0.3.2]:      https://github.com/site-prism/site_prism-all_there/compare/v0.3.1...v0.3.2
[0.3.1]:      https://github.com/site-prism/site_prism-all_there/compare/v0.3...v0.3.1
[0.3]:        https://github.com/site-prism/site_prism-all_there/compare/v0.2.1...v0.3
[0.2.1]:      https://github.com/site-prism/site_prism-all_there/compare/v0.2...v0.2.1
[0.2]:        https://github.com/site-prism/site_prism-all_there/compare/v0.1.1...v0.2
[0.1.1]:      https://github.com/site-prism/site_prism-all_there/compare/v0.1...v0.1.1
[0.1]:        https://github.com/site-prism/site_prism-all_there/compare/a778bb...v0.1

<!-- Contributors in chronological order -->
[luke-hill]:  https://github.com/luke-hill

<!-- Issue/PR References to the repo -->
[#20]:        https://github.com/site-prism/site_prism-all_there/pull/20
[#12]:        https://github.com/site-prism/site_prism-all_there/issues/12