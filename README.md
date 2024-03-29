email_validation
================

**Simple email validator for Rails 3+**

|             |                                 |
|:------------|:--------------------------------|
| **Author**  | Tim Morgan                      |
| **Version** | 1.1.1 (Jul 19, 2011)            |
| **License** | Released under the MIT license. |

About
-----

This gem adds a very simple email address format validator to be used with
ActiveRecord models in Rails 3.0+. It supports localized error messages.

Installation
------------

Add the gem to your project's `Gemfile`:

```` ruby
gem "email_validation"
````

Usage
-----

This gem is an `EachValidator`, and thus is used with the `validates` method:

```` ruby
class User < ActiveRecord::Base
  validates :email_address,
            presence: true,
            email:    true
end
````

The localization key is `invalid_email`, and can be specified in the localized
YAML file like so:

```` yaml
en:
  activerecord:
	errors:
	  messages:
	    invalid_email: Email address is invalid.
````
