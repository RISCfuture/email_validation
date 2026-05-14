# Changelog

All notable changes to this project are documented here. This project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-05-14

### Breaking

- Minimum Ruby version is now **3.1**.
- Minimum `activemodel` version is now **6.1**.
- Depends on `localized_each_validator >= 2.0`.

### Fixed

- The `"Name <addr@host>"` form previously accepted whitespace-only names
  (e.g. `"   <foo@bar.com>"` would validate). The regex now requires at least
  one non-whitespace character before the angle-bracketed address.
- The full RFC 5322 regex (`:format => :rfc5322`) had a corrupted byte range
  in its IP-literal/quoted-pair clause: `[\x21-\x5a\x53-\x7f]` has been
  corrected to `[\x21-\x5a\x5c-\x7f]` to match the canonical Cal Henderson
  source. The original typo caused the character class to over-accept bytes
  in the `0x53..0x5b` range that should have been excluded.

### Changed

- Packaging rewritten by hand; the jeweler/juwelier-generated gemspec is gone.
- Version constant now lives in `lib/email_validation/version.rb`.
- `README.md` rewritten: removed Rails 3 framing, dropped the stale version
  banner, documented every option (including the previously-undocumented
  `:allow_blank`), and updated the i18n example to the activemodel-friendly
  `errors.messages.invalid_email` key.
- CI moved from Travis to GitHub Actions, matrixing Ruby 3.1-3.4 against
  activemodel 7.0-8.0.

## [1.2.1] and earlier

See the git history.
