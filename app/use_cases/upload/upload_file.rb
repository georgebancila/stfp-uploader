# frozen_string_literal: true

require File.join(Rails.root, 'app', 'services', 'uploader')

module Upload
  class UploadFile < UseCase::Base
    def before
      @file_to_upload = context.params['upload']
    end

    def perform
      validate_file
      upload_file_on_server

      context.file_name = @file_to_upload['datafile'].original_filename
    end

    private

    def file_path
      @file_to_upload['datafile'].tempfile.path
    end

    def validate_file
      raise StandardError, 'u need to provide a file' unless @file_to_upload.present?
      raise StandardError, 'the file does not exist' unless File.exist?(file_path)
    end

    def upload_file_on_server
      uploader.upload(file_path, @file_to_upload['datafile'].original_filename)
    end

    def uploader
      @uploader ||= ::Uploader.new
    end
  end
end
