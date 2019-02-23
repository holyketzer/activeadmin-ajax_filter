[![Gem Version](https://badge.fury.io/rb/activeadmin-ajax_filter.svg)](https://badge.fury.io/rb/activeadmin-ajax_filter)
[![Build Status](https://travis-ci.org/holyketzer/activeadmin-ajax_filter.svg?branch=master)](https://travis-ci.org/holyketzer/activeadmin-ajax_filter)
[![Code Climate](https://codeclimate.com/github/holyketzer/activeadmin-ajax_filter/badges/gpa.svg)](https://codeclimate.com/github/holyketzer/activeadmin-ajax_filter)
[![Test Coverage](https://codeclimate.com/github/holyketzer/activeadmin-ajax_filter/badges/coverage.svg)](https://codeclimate.com/github/holyketzer/activeadmin-ajax_filter/coverage)

# Activeadmin::AjaxFilter

This gem extends ActiveAdmin so that your can use filters with AJAX-powered input.

Form input

<img src="https://s31.postimg.org/gvb9y7u9n/ajax_input.gif" width="360" alt="ActiveAdmin AJAX Form input"/>

Filter

<img src="https://s31.postimg.org/qmkboivpn/ajax_filter.gif" width="360" alt="ActiveAdmin AJAX Filter input"/>

## Prerequisites

Minimum Ruby version `2.3`

This extension assumes that you're using [Active Admin](https://github.com/activeadmin/activeadmin) with [Ransack](https://github.com/activerecord-hackery/ransack). And for AJAX input it uses [selectize-rails](https://github.com/manuelvanrijn/selectize-rails)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin-ajax_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeadmin-ajax_filter

## Usage

Include this line in your JavaScript code (active_admin.js.coffee)

```coffeescript
#= require selectize
#= require activeadmin-ajax_filter
```

Include this line in your CSS code (active_admin.scss)

```scss
@import "selectize";
@import "selectize.default";
@import "activeadmin-ajax_filter";
```

Include `ActiveAdmin::AjaxFilter` module to the ActiveAdmin relation resource for which you want to support filtering and add `ajax_select` filter to main resource. For example:

```ruby
# Relation-resource
ActiveAdmin.register User do
  include ActiveAdmin::AjaxFilter
  # ...
end

# Main resource
# As a filter
ActiveAdmin.register Invoice do
  filter :user, as: :ajax_select, data: { 
    url: :filter_admin_users_path, 
    search_fields: [:email, :customer_uid], 
    limit: 7,
  }
  # ...
end

# As a form input
ActiveAdmin.register Invoice do
  form do |f|
    f.input :language # used by ajax_search_fields
    f.input :user, as: :ajax_select, data: { 
      url: filter_admin_users_path,
      search_fields: [:name], 
      static_ransack: { active_eq: true }, 
      ajax_search_fields: [:language_id],
    }
    # ...
  end
end
```

You can use next parameters in `data` hash:

* `search_fields` - fields by which AJAX search will be performed, **required**
* `display_fields` - fields which will be displayed in drop down list during search, first field will be displayed for selected option
* `limit` - count of the items which will be requested by AJAX, by default `5`
* `value_field` - value field for html select element, by default `id`
* `ordering` - sort string like `email ASC, customer_uid DESC`, by default it uses first value of `search_fields` with `ASC` direction
* `ransack` - ransack query which will be applied, by default it's builded from `search_fields` with `or` and `contains` clauses, e.g.: `email_or_customer_uid_cont`
* `url` - url for AJAX query by default is builded from field name. For inputs you can use url helpers, but on filters level url helpers isn't available, so if you need them you can pass symbols and it will be evaluated as url path (e.g. `:filter_admin_users_path`). `String` with relative path (like `/admin/users/filter`) can be used for both inputs and filters.
* `ajax_search_fields` - array of field names. `ajax_select` input depends on `ajax_search_fields` values: e.g. you can scope user by languages.
* `static_ransack` - hash of ransack predicates which will be applied statically and independently from current input field value
* `min_chars_count_to_request` - minimal count of chars in the input field to make an AJAX request

## Caveats 

### Ransack _cont on Integer column

Due to issue with Ransack and Postgres it's not possbile to make searches like `id_cont` because `id` is a `Integer` type (more here https://github.com/activerecord-hackery/ransack/issues/85)

The way to handle it find with another predicate like:

```
filter :user_id, as: :ajax_select, collection: [], data: {
    url: '/admin/users/filter',
    display_fields: [:full_name, :phone],
    ransack: 'id_eq', # !!! predicate is ovewritten to `eq` by default it's `cont`
    search_fields: ['id'],
  }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/holyketzer/activeadmin-ajax_filter. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

