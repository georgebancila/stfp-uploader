# frozen_string_literal: true

require 'net/sftp'
require 'pry'
require 'active_support'
require 'active_support/core_ext'

class Uploader
  def initialize
    @host = 'george2.files.com'
    @user = 'sftpuser_george'
    @password = 'George123_'
    @port = 22
  end

  def upload(local_file, file_name)
    server_upload(local_file, "/uploaded_#{file_name}")
  end

  def server_upload(local_file, remote_file)
    Net::SFTP.start(@host, @user, password: @password, port: @port) do |sftp|
      sftp.upload!(local_file, remote_file) do |event, _uploader, *_args|
        case event
        when :open
          puts 'Starting upload...'
        when :finish
          puts 'Finishing upload...'
        end
      end
    end
  end
end
