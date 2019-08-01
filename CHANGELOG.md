<!-- #8 - Jul 11th - Last update to this document -->
## [Unreleased]
### Removed

### Added
  
### Changed

### Fixed

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
[Unreleased]: https://github.com/site-prism/site_prism-all_there/compare/v0.2.1...master
[0.2.1]:      https://github.com/site-prism/site_prism-all_there/compare/v0.2...v0.2.1
[0.2]:        https://github.com/site-prism/site_prism-all_there/compare/v0.1.1...v0.2
[0.1.1]:      https://github.com/site-prism/site_prism-all_there/compare/v0.1...v0.1.1
[0.1]:        https://github.com/site-prism/site_prism-all_there/compare/a778bb...v0.1

<!-- Contributors in chronological order -->
[luke-hill]:      https://github.com/luke-hill
