[![Build Status](https://travis-ci.com/hgwr/finalizable.svg?branch=master)](https://travis-ci.com/hgwr/finalizable) 
[![Gem Version](https://badge.fury.io/rb/finalizable.svg)](https://badge.fury.io/rb/finalizable)

# Finalizable

This gem makes the specified method non-overridable in Ruby.

- I found [the awesome question in stack overflow](https://stackoverflow.com/questions/708642/how-to-make-a-base-class-method-non-overridable-in-ruby).
- In the answer section, [Original page](http://www.thesorensens.org/2006/10/06/final-methods-in-ruby-prevent-method-override/) is intrudoced.
- [Original page](http://www.thesorensens.org/2006/10/06/final-methods-in-ruby-prevent-method-override/) is not accessible now (2020-02-23).
- I refered [the page in WayBack Machine](https://web.archive.org/web/20080226085648/http://www.thesorensens.org/2006/10/06/final-methods-in-ruby-prevent-method-override/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finalizable'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install finalizable

## Usage

see `lib/finalizable/example/`

Example of parent class which is using `final` and `somewhat_final`.

```ruby
class ParentClass
  include ::Finalizable
  final :final_method_defined_in_parent_class
  somewhat_final :somewhat_final_method_defined_in_parent_class

  def final_method_defined_in_parent_class
    :return_value_from_parent_class
  end

  def somewhat_final_method_defined_in_parent_class
    :return_value_from_parent_class
  end

  def overridable_method_defined_in_parent_class
    :return_value_from_parent_class
  end
end
```

- If subclass overrides the method `final_method_defined_in_parent_class`, you will get `Finalizable::OverrideError` on loading time not runtime.
- If subclass overrides the method `somewhat_final_method_defined_in_parent_class`, you will get a `Kernel#.warn` message. 

```
WARNING: Child class 'Finalizable::Example::AClassSomeMethodsAreNotAllowedOverriding' should not override parent class method 'Finalizable::Example::ParentClass.somewhat_final_method_defined_in_parent_class'.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/finalizable.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
