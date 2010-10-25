#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class MainGlade
  include GetText

  attr :glade

  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}

  end

  def on_btn_go_clicked(widget)
    @glade["txt_url"].text="test"
  end
  def on_win_main_destroy(widget)
    Gtk.main_quit()
  end
end

# Main program
if __FILE__ == $0
  # Set values as your own application.
  Gtk.init
  PROG_PATH = "main.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  o = MainGlade.new(PROG_PATH, nil, PROG_NAME)
  o.glade["win_main"].show_all
  Gtk.main
end

