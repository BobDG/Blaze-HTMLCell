Pod::Spec.new do |s|
  s.name           = 'BlazeHTMLCell'
  s.version        = '0.0.3'
  s.summary        = 'HTML-cell addition to Blaze'
  s.license 	   = 'MIT'
  s.description    = 'Useful HTML-cell addition to Blaze, using DTCoreText and TTTAttributedLabel for performance and link checking'
  s.homepage       = 'https://github.com/BobDG/Blaze-HTMLCell'
  s.authors        = {'Bob de Graaf' => 'graafict@gmail.com'}
  s.source         = { :git => 'https://github.com/BobDG/Blaze-HTMLCell.git', :tag => '0.0.3' }
  s.source_files   = 'BlazeHTMLCell/*.{h,m}'
  s.platform       = :ios
  s.requires_arc   = 'true'
  s.dependency     'Blaze'
  s.dependency     'DTCoreText'
  s.dependency     'TTTAttributedLabel'
end
