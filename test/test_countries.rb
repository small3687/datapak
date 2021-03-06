# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_countries.rb


require 'helper'

class TestCountries < MiniTest::Test

  def test_country_list
    pak = Datapak::Pak.new( './pak/country-list/datapackage.json' )

    puts "name: #{pak.name}"
    puts "title: #{pak.title}"
    puts "license: #{pak.license}"

    pp pak.tables
    ## pp pak.table[0]['Symbol']
    ## pp pak.table[495]['Symbol']

    ## pak.table.each do |row|
    ##  pp row
    ## end

    puts pak.table.dump_schema

    # database setup 'n' config
    ActiveRecord::Base.establish_connection( adapter:  'sqlite3', database: ':memory:' )
    ActiveRecord::Base.logger = Logger.new( STDOUT )

    pak.table.up!
    pak.table.import!

    pp pak.table.ar_clazz

=begin
    company = pak.table.ar_clazz

    puts "Company.count: #{company.count}"
    pp company.first
    pp company.find_by!( symbol: 'ABT' )
    pp company.find_by!( name: '3M Co' )
    pp company.where( sector: 'Industrials' ).count
    pp company.where( sector: 'Industrials' ).all
=end

    assert true  # if we get here - test success
  end

end # class TestCountries

