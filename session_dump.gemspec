Gem::Specification.new do |s|
  s.name     = "session_dump"
  s.version  = "0.0.1"
  s.date     = "2009-02-10"
  s.summary  = "A simple plugin to dump client's session data at each request"
  s.email    = "valentin.mihov@gmail.com"
  s.description = "A simple plugin to dump client's session data at each request"
  s.has_rdoc = true
  s.authors  = ["Valentin Mihov"]
  s.files    = ['README'] + Dir['lib/**/*.rb'] + Dir['rails/*']

end
