require 'sinatra'
require 'faye/websocket'
require 'json'

Faye::WebSocket.load_adapter('thin')

CLIENTS = []

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :open do |e|
      puts "Websocket connection open"
      CLIENTS << ws
    end

    ws.on :close do |event|
      puts "Websocket connection closed"
      CLIENTS.delete(ws)
      ws = nil
    end

    ws.rack_response

  else # A normal HTTP request

    if env["REQUEST_PATH"] == "/"
      [200, {}, File.read('./index.html')]
    elsif env["REQUEST_PATH"] =~ /\/send\// # If it starts with /send/
      message = /\/send\/(.*)/.match(env["REQUEST_PATH"])[1]
      puts "Received message: " + message

      CLIENTS.each {|client| client.send(message) }

      [200, {}, '']
    else
      [404, {}, '']
    end

  end
end
