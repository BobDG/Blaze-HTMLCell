Pod::Spec.new do |s|
  s.name           = 'BlazeHTMLCell'
  s.version        = '0.0.7'
  s.summary        = 'HTML-cell addition to Blaze'
  s.license 	   = 'MIT'
  s.description    = 'Useful HTML-cell addition to Blaze, using DTCoreText and TTTAttributedLabel for performance and link checking'
  s.homepage       = 'https://github.com/BobDG/Blaze-HTMLCell'
  s.authors        = {'Bob de Graaf' => 'graafict@gmail.com'}
  s.source         = { :git => 'https://github.com/BobDG/Blaze-HTMLCell.git', :tag => s.version.to_s }
  s.source_files   = 'BlazeHTMLCell/*.{h,m}'
  s.platform       	= :ios, '8.0'
  s.requires_arc   	= true
  s.dependency     'Blaze'
  s.dependency     'DTCoreText'
  s.dependency     'TTTAttributedLabel'
end
