#!/usr/bin/env ruby
# encoding: utf-8
#
# This script is meant to take input from the *NetBSD fortune* program, and output it to Conky.
# Specifically, it's expecting a 'fortune' string like the following:
#
#     "Be yourself; everyone else is already taken." -Oscar Wilde
#
# It is going to chop off any odd quote marks wrapping the quotation part, re-wrap it with standard
# double quotes (this is because the fortune string file I'm using contains some oddly punctuated
# quotations), then stylize the name part as a handwritten signature. It's going to output conky-
# style ${font} instructions, so it's output will need to be interpreted by Conky -- it must be
# called using ${execp} or ${execpi}.
#
# For the signature, it will select a font from the list provided, based on a checksum of the
# author's name. This keeps the signatures looking a little bit fresher and less like they were
# generated by a computer. Also, each name will stick with the same font, as long as you don't
# change the list of fonts, here.
#

require 'etc'

# this hash holds the list of fonts to select from, along with a relative size change to make (some
# of these fonts are oddly sized). All of these fonts are available in the fonts/ directory.
FONTS = {
  'Luna Bar' => -4,
  'Beautiful Every Time' => -5,
  'Christopherhand' => 0,
  'Daniel' => -5,
  'Desyrel' => 0,
  'Haiku\'s Script ver.04' => 0,
  'Jellyka \- Estrya\'s Handwriting' => 30,
  'Jellyka \- Nathaniel a Mystery' => 0,
  'Jenna Sue' => 0,
  'La Belle Aurore' => 0,
  'MTF Lexi' => 0,
  'Mia\'s Scribblings \~' => -5,
  'Never Let Go' => 0,
  'Simply\*Glamorous' => 0,
  'Stars From Our Eyes' => -10,
  'Sweetly Broken' => 0,
  'The Only Exception' => -10
}

def wrap(text, width=90)
  text.split("\n").collect do |line|
    line.length > width ? line.gsub(/(.{1,#{width}})(\s+|$)/, "\\1\n      ").strip : line
  end * "\n"
end

def select_font(string)
  @selected_font ||= FONTS.keys[string.sum % FONTS.size]
  #$stderr.puts "using #{@selected_font}"
  return "${font #{@selected_font}:size=#{35 + FONTS[@selected_font]}}"
end

fortune = /^[“"'](.+)["”']\s*(?:[-–~]?(.+))?$/.match($stdin.gets.strip)

out = %Q["#{ wrap(fortune[1]) }"]

# Add the signature, if there was one
if fortune[2] #and fortune[2] != "Unknown" # uncomment this to see no signature instead of "Unknown"
  out << "\n\n" << ' ' * 50 # indent the signature 50 spaces
  out << [select_font(fortune[2]), fortune[2], '${font}'].join
end

# Write the fortune to a text file, in the event I wish to Google the quote or for the odd signature
# that is hard to read
File.open(File.join(Etc.getpwuid.dir, '.conky_fortune'), 'w') { |f|
  f.puts fortune[1]
  f.puts "   ~ #{fortune[2]}"
  f.puts "\nSignature font used was #@selected_font"
}

# Write the output for conky, now
puts out