module Booking
  def lang_mapping(input)
    input = {
      "en" => "en",
      "zh" => "zh-cn",
      "zh_tw" => "zh-tw",
      "jp" => "ja",
      "ja" => "ja",
    }[input] || input
  end
  def lang_family(lang)
    {
      'zh' => ['zh', 'zh_cn', 'zh_tw', 'zh-cn', 'zh-tw'],
      'zh_tw' => ['zh', 'zh_cn', 'zh_tw', 'zh-cn', 'zh-tw'],
      'zh_cn' => ['zh', 'zh_cn', 'zh_tw', 'zh-cn', 'zh-tw'],
      'zh-tw' => ['zh', 'zh_cn', 'zh_tw', 'zh-cn', 'zh-tw'],
      'zh-cn' => ['zh', 'zh_cn', 'zh_tw', 'zh-cn', 'zh-tw'],
      'en' => ['en']
    }[lang]
  end
  module_function :lang_mapping, :lang_family
  module API
  end
end

dirs = [
  File.dirname(File.expand_path("../booking/api/hotel.rb", __FILE__)),
  File.dirname(File.expand_path("../booking/bp/hotel.rb", __FILE__))
]
#puts dirs.inspect
tobe_loaded = []
dirs.each do |dir|
  Dir.open(dir).entries.each do |en|
    next if en.start_with?(".")
    next if !en.end_with?(".rb")
    tobe_loaded << File.join(dir, en)
  end
end
tobe_loaded << File.expand_path("../booking/client.rb", __FILE__)

#tobe_loaded.each {|f| puts f}

if ENV['env'] == "development"
  tobe_loaded.each {|f| load f}
else
  tobe_loaded.each {|f| require f}
end

