
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

  def files_exist(*paths)
    resp = conn.request({
                   :method => :post,
                   :path => 'sikuli/file/exists',
                   :headers => {'Content-Type' => 'application/json'},
                   :body => paths.to_json})
    resp.status == 200
  end

  def delete(path)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/file/delete',
                   :headers => {'Content-Type' => 'application/json'},
                   :query => {:path => path}})
    nil
  end

  def create_folder(path)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/file/createFolder',
                   :headers => {'Content-Type' => 'application/json'},
                   :query => {:path => path}})
    nil
  end

  def clean_folder(path)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/file/cleanFolder',
                   :headers => {'Content-Type' => 'application/json'},
                   :query => {:path => path}})
    nil
  end

  def copy_folder(source, dest)
    conn.request({
                   :expects => [200],
                   :method => :post,
                   :path => 'sikuli/file/copyFolder',
                   :headers => {'Content-Type' => 'application/json'},
                   :query => {:fromPath => source, :toPath => dest}})
    nil
  end

  def upload_files(files, saveTo)
    raise 'Not Implemented'
  end

  def download_file(source, dest)
    raise 'Not Implemented'
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
