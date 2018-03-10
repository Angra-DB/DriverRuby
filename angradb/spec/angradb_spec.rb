require 'spec_helper'
require 'byebug'
RSpec.describe Angradb do
  it "has a version number" do
    expect(Angradb::VERSION).not_to be nil
  end

  it "should successfully open a tcp connection with Angradb" do
    ip_address = "127.0.0.1"
    ip_port = 1234
    expect{Angradb::Driver.new(ip_address, ip_port)}.not_to raise_error
  end
end
