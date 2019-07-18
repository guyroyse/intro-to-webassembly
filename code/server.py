import http.server
from http.server import HTTPServer, BaseHTTPRequestHandler

import socketserver

PORT = 8000

Handler = http.server.SimpleHTTPRequestHandler

Handler.extensions_map['.wasm'] = 'application/wasm'

print("serving at port", PORT)

httpd = socketserver.TCPServer(("", PORT), Handler)
httpd.serve_forever()