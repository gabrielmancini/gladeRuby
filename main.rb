#!/usr/bin/env ruby
#
require 'libglade2'
require 'net/http'
require 'gtk2'

class MainGlade
  include GetText

  attr :glade

  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)

    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}

  end



  def on_btn_go_clicked(widget)

    buff = @glade["txt_view"].buffer

    url = URI.parse( @glade["txt_url"].text )
    req = Net::HTTP::Get.new(url.path)

    proxy_addr = 'proxy01.prodesp.sp.gov.br'
    proxy_port = 80

    res =Net::HTTP::Proxy(proxy_addr, proxy_port).start(url.host, url.port) do |http|

       http.request(req) do |res|
          res.read_body do |segment|
            segment.each_line do |line|
              buff.insert_at_cursor line.gsub(/<\/?[^>]*>/, "")
            end
          end
      end

    end

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

