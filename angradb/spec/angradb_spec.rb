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
    before(:all) do
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
    before(:all) do
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
    before(:all) do
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
    before(:all) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db'
      @cursor.connect('test_db')
    end
    before(:each) do
      @key = @cursor.save('new document')
    end
    after(:each) do
      @cursor.delete(@key)
    end
    it 'should successfully update a document of the db' do
      expect { @cursor.update(@key, 'document updated') }.not_to raise_error
    end
  end

  describe 'LookUp' do
    before(:all) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db'
      @cursor.connect('test_db')
    end
    before(:each) do
      @key = @cursor.save('new document lookup_test')
    end
    after(:each) do
      @cursor.delete(@key)
    end
    it 'should successfully lookup a document of the db' do
      expect { @cursor.look_up(@key) }.not_to raise_error
    end
    it 'should return the right document' do
      response = @cursor.look_up(@key)
      expect(response).to eql '"new document lookup_test"'
    end
  end

  describe 'Delete' do
    before(:all) do
      ip_address = '127.0.0.1'
      ip_port = 1234
      @cursor = Angradb::Driver.new(ip_address, ip_port)
      @cursor.create_db 'test_db'
      @cursor.connect('test_db')
    end
    before(:each) do
      @key = @cursor.save('new document delete_test')
    end
    it 'should successfully delete a document of the db' do
      response = @cursor.delete(@key)
      expect(response).to eq 'ok'
    end
    it 'should not return a deleted document' do
      @cursor.delete(@key)
      expect { @cursor.look_up(@key) }.to raise_error(RuntimeError)
    end
  end
end
