require '/.app'
run Sinatra::Application

require_relative "./models/post"
require_relative "./models/user"
