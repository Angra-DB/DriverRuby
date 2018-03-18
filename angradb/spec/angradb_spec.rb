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
end
