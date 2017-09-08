

Pod::Spec.new do |s|

  s.name         = "JS-OC."
  s.version      = "0.0.1"
  s.summary      = "A short description of JS-OC.."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "http://EXAMPLE/JS-OC."
  s.license      = "MIT (example)"
  s.author             = { "" => "" }
  s.source       = { :git => "http://EXAMPLE/JS-OC..git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
