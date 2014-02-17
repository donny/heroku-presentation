require './app'

# Flush the stdout immediately
$stdout.sync = true

Faye::WebSocket.load_adapter('thin')

run App
