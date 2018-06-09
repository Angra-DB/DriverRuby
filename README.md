# Angradb - DriverRuby

A ruby gem to interface with AngraDB allowing CRUD operations in a encapsulated way.

Gem link: `https://rubygems.org/gems/angradb`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'angradb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install angradb

## Usage

The first thing to be done is to instantiate a object of `Angradb::Driver`. It receives two params for 
initialization, the `ip_address` and `ip_port` of the AngraDB server, an instantiation example would be 
`test_driver = Angradb::Driver("127.0.0.1", 1234)`. The methods implemented for the object are the following:

##### create_db
`test_driver.create_db(db_name)`

Creates a database with name `db_name`
##### connect
`test_driver.connect(db_name)`

Connects to a database with name `db_name`
##### save
`test_driver.save(document)`

Saves a document `document` and returns its key
##### lookup
`test_driver.lookup(document_identification)`

Gets the document of key `document_identification`

##### update
`test_driver.update(document_identification, new_document)`

Gets the document key `document_identification`, finds the corresponding document and updates it with the 
new document `new_document`

##### delete
`test_driver.delete(document_identification)`

Gets the document key `document_identification`, finds the corresponding document and deletes it

## Development

After checking out the repo, enter the `angradb` folder, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Angra-DB/DriverRuby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
