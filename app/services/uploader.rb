# frozen_string_literal: true

require 'net/sftp'
require 'pry'
require 'active_support'
require 'active_support/core_ext'

module Services
  class Uploader
    def initialize
      @host = 'george2.files.com'
      @user = 'sftpuser_george'
      @password = 'George123_'
      @port = 22
    end

    def upload(local_file)
      raise StandardError, 'u need to provide a file' unless local_file.present?
      raise StandardError, 'the file does not exist' unless File.exist?(local_file)

      server_upload(local_file, "/uploaded_#{File.basename(local_file)}")
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
end
