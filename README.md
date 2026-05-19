# email_validation

[![CI](https://github.com/RISCfuture/email_validation/actions/workflows/ci.yml/badge.svg)](https://github.com/RISCfuture/email_validation/actions/workflows/ci.yml)
[![Gem Version](https://img.shields.io/gem/v/email_validation.svg)](https://rubygems.org/gems/email_validation)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A simple, localizable email-address validator for any ActiveModel-based class.

|              |                                  |
|:-------------|:---------------------------------|
| **Author**   | Tim Morgan                       |
| **License**  | Released under the MIT license.  |

## About

`email_validation` adds an `EachValidator` for email addresses. It works with
any class that includes `ActiveModel::Validations` (ActiveRecord models, plain
Ruby objects with `include ActiveModel::Model`, etc.) and supports localized
error messages out of the box.

## Installation

Add to your `Gemfile`:

```ruby
gem "email_validation"
```

Then `bundle install`.

## Usage

```ruby
class User
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email_address

  validates :email_address,
            presence: true,
            email:    true
end
```

### Options

| Option         | Description                                                                                                                                                                                                                                                              |
|:---------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `:format`      | Which regex to validate against. Defaults to a loose regex that accepts most real-world addresses. Pass `:rfc5322` for the full RFC 5322 regex, or `:rfc5322_simple` for a simplified variant that rejects common typos (quoted local parts, IP-literal domains, etc.). |
| `:message`     | A custom error message to use when validation fails.                                                                                                                                                                                                                     |
| `:allow_nil`   | If `true`, `nil` values pass validation (inherited from `LocalizedEachValidator`).                                                                                                                                                                                       |
| `:allow_blank` | If `true`, blank values pass validation (inherited from `LocalizedEachValidator`).                                                                                                                                                                                       |

Examples:

```ruby
validates :email_address, email: true
validates :email_address, email: {format: :rfc5322}
validates :email_address, email: {allow_blank: true}
validates :email_address, email: {message: "doesn't look like an email"}
```

The validator also accepts the `Name <addr@host>` form, so values like
`"Foo Bar <foo@bar.com>"` validate correctly.

## Localization

The error message key is `invalid_email`. Add a translation to your locale
files under `errors.messages`:

```yaml
en:
  errors:
    messages:
      invalid_email: "Email address is invalid."
```

You can also nest it under `activerecord.errors.messages` (or any of the other
ActiveModel error-message lookup paths) if you prefer per-model granularity.

## Development

```bash
bin/setup
bundle exec rspec
```

## License

MIT. See [LICENSE](LICENSE).
