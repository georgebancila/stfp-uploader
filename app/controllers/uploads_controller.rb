# frozen_string_literal: true

require File.join(Rails.root, 'app', 'use_cases', 'upload', 'base')

class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index; end

  def upload
    result = ::Upload::Base.perform(params: params)
    flash[:message] = "File #{result.file_name} uploaded successfully"
    redirect_to action: "index"
  rescue StandardError => e
    flash[:error_message] = "File upload failed: #{e.message}"
    redirect_to action: "index"
  end
end
