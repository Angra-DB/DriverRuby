require "angradb/version"
require "socket"

module Angradb
  class Driver

    @ip_address = nil
    @ip_port = nil
    @session = nil

    def initialize(ip_address, ip_port)
      @ip_address = ip_address
      @ip_port = ip_port
      open_tcp_connection
    end

    private

    def open_tcp_connection
      begin
        @session = TCPSocket.new @ip_address, @ip_port
      rescue
        raise "Couldnt connect with the socket-server"
      end
    end
  end
end
