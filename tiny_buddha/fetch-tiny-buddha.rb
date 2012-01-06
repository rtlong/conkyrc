require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'logger'

# this script simply scrapes the quotes from TinyBuddha.com into a file with a format compatible
# with the `strfile` program that comes with Fortune

$stderr.print 'Calling to the great Buddha for guidance.'

File.open('tiny_buddha','w') do |f|
  begin
    for i in 1..42 do

      doc = Nokogiri::HTML(open("http://tinybuddha.com/category/quotes/page/#{i}"))
      quotes = doc.css('.post-content > blockquote').collect(&:inner_text)

      f.puts quotes.join("\n%\n")
      f.puts '%'
      $stderr.print '.'
    end
  rescue OpenURI::HTTPError => e
  ensure
    $stderr.print "\n\n"
  end
end

$stderr.puts `strfile ./tiny_buddha`

$stderr.puts "\nTinyBuddha has spoken! Somehow, everything he's said has been recorded in " <<
             './tiny_buddha! You can now see your fortune by running `fortune tiny_buddha`'
