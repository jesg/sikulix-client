
require 'excon'
require 'json'
require 'sikulix-client/image'

class SikulixClient

  attr_reader :conn
  private :conn

  DEFAULT_OPTIONS = {
    :host => '127.0.0.1',
    :port => '4041',
    :debug => false}

  def initialize(opts = {})
    opts = DEFAULT_OPTIONS.dup.merge(opts)
    @conn = Excon.new("http://#{opts[:host]}:#{opts[:port]}/", :debug => opts[:debug])
  end

  def execute_cmd(cmd, args, timeout)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/cmd/execute',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => {
                     :process => cmd,
                     :args => args,
                     :timeout => timeout}.to_json})
    nil
  end

  def click(image, timeout)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/image/click',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => image.to_json,
                   :query => {:timeout => timeout}})
    nil
  end

  def image_exits(image, timeout)
    resp = conn.request({
                   :method => :post,
                   :path => 'sikuli/image/exists',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => image.to_json,
                   :query => {:timeout => timeout}})
    resp.status == 200
  end

  def set_text(text, image, timeout)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/image/setText',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => image.to_json,
                   :query => {:timeout => timeout, :text => text}})
    nil
  end

  def drag_and_drop(images, timeout)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/image/dragAndDrop',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => images.to_json,
                   :query => {:timeout => timeout}})
    nil
  end
end # SikulixClient
