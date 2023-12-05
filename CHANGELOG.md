## [main] - Unreleased
### Removed

### Added

### Changed

### Fixed
- Handle situation where `instance.section` calls fail when using recursion with `#all_there?` ([luke-hill] - [#72])

## [3.0.2] - 2023-11-13
### Changed
- Updated dev dependencies including permitting the v5 series of `site_prism` ([luke-hill] - [#69])

### Fixed
- Correctly log interim `#all_there?` methods at correct level (debug only) ([luke-hill] - [#70])

## [3.0.1] - 2023-08-24
### Changed
- Update rubocop and associated sub-gems in dev dependencies ([luke-hill] - [#58] / [#59] / [#60])

### Fixed
- Correctly hashify all args being passed into `#all_there?` ([luke-hill] - [#61])

## [3.0] - 2023-08-23
### Added
- Allow runtime options into `#all_there?` calls ([luke-hill] - [#56])

### Changed
**Breaking Change**:
- The gem now will implicitly use no recursion if no parameter is provided
  - Providing no value will then look at the config parameter
    ([luke-hill] - [#56])

- **Required Ruby Version is now 2.7+** ([luke-hill] - [#56])

### Fixed
- Erroneous log messages when using `sections` (plural) check in `#all_there?` ([luke-hill] - [#56])

## [2.0.2] - 2023-07-13
### Changed
- Optimisation: Used array intersection instead of selection for Item Mapper ([luke-hill] - [#52])

- Optimisation: Store `hash` view in `MappedItems` class immediately ([luke-hill] - [#53])

- Reordered all specs so that the contexts now switch context instead of sub-method ([luke-hill] - [#54])

## [2.0.1] - 2023-06-01
### Removed
- A lot of redundant rubocop config has been removed ([luke-hill] - [#51])

### Fixed
- A few erroneous bits of documentation ([luke-hill] - [#51])

- Some redundant bits of code now SitePrism v4 is released ([luke-hill] - [#51])

## [2.0] - 2023-03-06
### Removed
- A huge amount of testing scaffolding is now removed ([luke-hill] - [#30])

### Added
- Updated the documentation for using the gem and recursing through objects ([luke-hill] - [#33])

- CI now tests against Ruby 3.2 ([luke-hill] - [#34])

- Dependabot updates brought into CI flow ([luke-hill] - [#34])

### Changed
**Breaking Change**:
- The gem now treats the config setting as the source of truth
  - Not setting this value **then** looks at the input parameter
  - The input parameter is now mandatory
    ([luke-hill] - [#33])

### Fixed
- CI build issue where duplicate builds would occur ([luke-hill] - [#39])

## [1.1] - 2022-12-07
### Changed
- GHA now just uses regular `rubocop` / `rspec` instead of `rake` wrapper ([luke-hill] - [#27])

- Bumped internal dev requirements for all rubocop packages to latest versions ([luke-hill] - [#27] / [#29])

- **Required Ruby Version is now 2.6+** ([luke-hill] - [#29])

## [1.0.1] - 2021-09-01
### Changed
- Bumped internal dev requirements for all rubocop packages to latest versions
([luke-hill] - [#22] / [#23])

- Switched CI from defunct travis to Github Actions ([luke-hill] - [#25])

### Fixed
- Guarded against the internal checklist throwing a NME if trying to fetch a DSL type that wasn't
  in existence (In theory shouldn't be possible) ([luke-hill] - [#24])

## [1.0] - 2021-03-29
### Added
- Basic debugging for each type of `#all_there?` check ([luke-hill] - [#21])
([luke-hill])

### Changed
- Massively bumped internal dev requirements ([luke-hill])

- **Required Ruby Version is now 2.5+** ([luke-hill] - [#20])

### Fixed
- Fixed up some tests which weren't running against the correct code-path ([luke-hill] - [#20])

## [0.3.2] - 2019-12-16
### Added
- Full `yard` documentation coverage of entire gem ([luke-hill])

### Changed
- Altered rspec tests to only make 1 assertion per test ([luke-hill])

- DRYed up the `ExpectedItems` class to only have the public `array` method call the other defined methods
([luke-hill])

## [0.3.1] - 2019-12-09
### Changed
- Bumped internal rubocop dev requirement from `0.73` to `0.75` ([luke-hill])

### Fixed
- Fixed an issue where `ExpectedItems` wasn't added to the gems load path ([luke-hill] - [#13])

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
([luke-hill])

### Fixed
- The file locations / names of all files / test files to avoid namespace conflicts
  - This in theory shouldn't have affected anyone as the code was unconsumed
([luke-hill])

## [0.1.1] - 2019-07-03
### Removed
- HACKING.md is now nice and concise, removed almost all the crud! ([luke-hill])

### Added
- Configuration settings are now located in the `SitePrism` namespace to sit alongside the main gem
([luke-hill])

- Added mocked specs to test about 80% of the codebase ([luke-hill])

- Added base usage docs in README.md ([luke-hill])

### Changed
- Altered the build pipeline for travis to run in under half the time (Removing unnecessary items) ([luke-hill])

- Use latest rubocop settings and fix up all cop offenses in suite ([luke-hill])

- Refactored the code into a secondary class: `MappedItems` to try make error triaging easier ([luke-hill])

### Fixed
- Travis build now passes (ruby-head ignore issue) ([luke-hill])

## [0.1] - 2019-07-01
### Added
- Base code from site_prism repo ([luke-hill])

<!-- Releases -->
[main]:       https://github.com/site-prism/site_prism-all_there/compare/v3.0.2...HEAD
[3.0.2]:      https://github.com/site-prism/site_prism-all_there/compare/v3.0.1...v3.0.2
[3.0.1]:      https://github.com/site-prism/site_prism-all_there/compare/v3.0...v3.0.1
[3.0]:        https://github.com/site-prism/site_prism-all_there/compare/v2.0.2...v3.0
[2.0.2]:      https://github.com/site-prism/site_prism-all_there/compare/v2.0.1...v2.0.2
[2.0.1]:      https://github.com/site-prism/site_prism-all_there/compare/v2.0...v2.0.1
[2.0]:        https://github.com/site-prism/site_prism-all_there/compare/v1.1...v2.0
[1.1]:        https://github.com/site-prism/site_prism-all_there/compare/v1.0.1...v1.1
[1.0.1]:      https://github.com/site-prism/site_prism-all_there/compare/v1.0...v1.0.1
[1.0]:        https://github.com/site-prism/site_prism-all_there/compare/v0.3.2...v1.0
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
[#72]:        https://github.com/site-prism/site_prism-all_there/pull/72
[#70]:        https://github.com/site-prism/site_prism-all_there/pull/70
[#69]:        https://github.com/site-prism/site_prism-all_there/pull/69
[#61]:        https://github.com/site-prism/site_prism-all_there/pull/61
[#60]:        https://github.com/site-prism/site_prism-all_there/pull/60
[#59]:        https://github.com/site-prism/site_prism-all_there/pull/59
[#58]:        https://github.com/site-prism/site_prism-all_there/pull/58
[#56]:        https://github.com/site-prism/site_prism-all_there/pull/56
[#54]:        https://github.com/site-prism/site_prism-all_there/pull/54
[#53]:        https://github.com/site-prism/site_prism-all_there/pull/53
[#52]:        https://github.com/site-prism/site_prism-all_there/pull/52
[#51]:        https://github.com/site-prism/site_prism-all_there/pull/51
[#39]:        https://github.com/site-prism/site_prism-all_there/pull/39
[#34]:        https://github.com/site-prism/site_prism-all_there/pull/34
[#33]:        https://github.com/site-prism/site_prism-all_there/pull/33
[#30]:        https://github.com/site-prism/site_prism-all_there/pull/30
[#29]:        https://github.com/site-prism/site_prism-all_there/pull/29
[#27]:        https://github.com/site-prism/site_prism-all_there/pull/27
[#25]:        https://github.com/site-prism/site_prism-all_there/pull/25
[#24]:        https://github.com/site-prism/site_prism-all_there/pull/24
[#23]:        https://github.com/site-prism/site_prism-all_there/pull/23
[#22]:        https://github.com/site-prism/site_prism-all_there/pull/22
[#21]:        https://github.com/site-prism/site_prism-all_there/pull/21
[#20]:        https://github.com/site-prism/site_prism-all_there/pull/20
[#13]:        https://github.com/site-prism/site_prism-all_there/pull/13
