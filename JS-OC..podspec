

Pod::Spec.new do |s|

  s.name         = "JS-OC."
  s.version      = "1.1.1"
  s.summary      = "新手测试用户git进github"
  s.description  = "新手测试用户git进github描述"
  s.homepage     = "http://EXAMPLE/JS-OC."
  s.license      = "MIT (example)"
  s.author             = { "" => "" }
s.source       = {:git => 'https://github.com/peisonglin/newText.git', : tag => s.version}
  s.source_files  = "source_filesname"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
