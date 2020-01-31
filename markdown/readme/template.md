# Minitest Lucid

Note:  The gem is not yet released.

[![Gem](https://img.shields.io/gem/v/minitest-lucid.svg?style=flat)](http://rubygems.org/gems/minitest-lucid "View this project in Rubygems")

When you test using gem ```minitest```, a failed assertion for a large or complex object can be difficult to understand.

Using method ```make_my_diffs_pretty!``` (it's part of ```minitest```) can sometimes help, but sometimes not enough.

Use gem ```minitest-lucid``` to get detailed elucidations for certain failures.

## Is This Overkill?

Yes!  (Until it isn't.)

Because when you have a failed assertion:

* How much information is enough?
* More is better.
* Too much is just about right.

## Usage

To use ```minitest-lucid```:
 
1. Install the gem:  ```gem install minitest-lucid```.
2. In your tests, change ```require 'minitest/autorun'``` to ```require 'minitest/lucid'```.

That's it.  No other code change is required.

See example elucidations below.

## Supported Classes

For supported classes, method ```assert_equal``` gets elucidated handling.

For other classes and assertion methods, the original assertion behaviors are unchanged.

The supported classes:

- [Set](#set)

Each example below shows:

- The message from a normal failed assertion.
- The message as modified by the use of ```make_my_diffs_pretty!``` (which is part of ```minitest``` itself).
- The detailed elucidation from ```minitest-lucid```.

@[:markdown](set/template.md)



