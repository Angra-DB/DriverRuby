require 'spec_helper'
require 'byebug'
RSpec.describe Angradb do
  it 'should have a version number' do
    expect(Angradb::VERSION).not_to be nil
  end

  it 'should successfully open a tcp connection with Angradb' do
    ip_address = '127.0.0.1'
    ip_port = 1234
    expect{Angradb::Driver.new(ip_address, ip_port)}.not_to raise_error
  end

  describe 'Create' do
    before(:each) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
    end
    it 'should successfully create a db when required' do
      @cursor.create_db('test_db_creation')
      expect { @cursor.connect('test_db_creation') }.not_to raise_error
    end
  end

  describe 'Connect' do
    before(:each) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db'
    end
    it 'should successfully connect to a db when required' do
      expect { @cursor.connect('test_db') }.not_to raise_error
    end
  end

  describe 'Save' do
    before(:each) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db'
      @cursor.connect('test_db')
    end
    it 'should successfully save a document to a db' do
      expect { @cursor.save('document') }.not_to raise_error
    end
  end

  describe 'Update' do
    before(:each) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db_update'
      @cursor.connect('test_db_update')
    end
    it 'should successfully update a document of the db' do
      key = @cursor.save('new document')
      expect { @cursor.update(key, 'document updated') }.not_to raise_error
    end
  end
end
