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
      request = 'connect ' + db_name
      response = send_to_server request
      raise response if response.include? 'does not exist'
      response
    end

    # Creates a specific database on Angradb
    # Params:
    # +db_name+:: name of the database
    # Returns:
    # +response+:: response of the server
    def create_db(db_name)
      request = 'create_db ' + db_name
      send_to_server request
    end

    # Creates a document on the connected database of Angradb
    # Params:
    # +doc+:: document to be saved
    # Returns:
    # +key+:: returns the key for the saved document
    def save(doc)
      request = 'save ' + doc
      response = send_to_server request
      # check if the response is the 25 char key
      raise 'Error on saving the document' unless response.is_a? String and response.size == 25
      # returns the key without the quotes
      response.delete '"'
    end

    # Updates a document on the connected database of Angradb
    # Params:
    # +key+:: the key for the document
    # +doc+:: document to be saved
    # # Returns:
    # +response+:: response of the server
    def update(key, doc)
      request = 'update ' + key + ' ' + doc
      response = send_to_server request
      raise 'Error on updating the document: ' + response unless response == "ok"
      # returns the key without the quotes
      response
    end

    # Looks up a document on the connected database on Angradb
    # Params:
    # +key+:: the key for the document
    # # Returns:
    # +response+:: the requested document
    def look_up(key)
      request = 'lookup ' + key
      response = send_to_server request
      raise 'Error on updating the document' unless response == "ok"
    # Deletes a document on the connected database on Angradb
    # Params:
    # +key+:: the key for the document
    # # Returns:
    # +response+:: the server response
    def delete(key)
      raise 'A key should be provided' unless key
      request = 'delete ' + key
      response = send_to_server request
      raise 'Error deleting the document: ' + response unless response == "ok"
      # returns the key without the quotes
      response
    end

    private

    def open_tcp_connection
      begin
        @session = TCPSocket.new @ip_address, @ip_port
      rescue
        raise 'Couldnt connect with the socket-server'
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
