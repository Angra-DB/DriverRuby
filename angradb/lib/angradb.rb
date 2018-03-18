require "angradb/version"
require "socket"
require 'json'

module Angradb
  class Driver
    BUFFER_SIZE = 1024
    @ip_address = nil
    @ip_port = nil
    @session = nil

    def initialize(ip_address, ip_port)
      @ip_address = ip_address
      @ip_port = ip_port
      open_tcp_connection
    end

    # Connects to a specific database on Angradb
    # Params:
    # +db_name+:: name of the database
    # Returns:
    # +response+:: response of the server
    def connect(db_name)
      request = "connect " + db_name
      response = send_to_server request
      raise response if response.include? 'does not exist'
      response
    end

    private

    def open_tcp_connection
      begin
        @session = TCPSocket.new @ip_address, @ip_port
      rescue
        raise "Couldnt connect with the socket-server"
      end
    end

    def send_to_server(request)
      @session.write(request)
      treat_response @session.gets
    end

    def treat_response(string)
      string.chomp # removes \n
      # JSON.parse(string)
    end
  end
end
