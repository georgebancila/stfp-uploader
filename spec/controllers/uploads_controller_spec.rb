# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  describe 'index' do
    subject { get :index }

    its(:status) { is_expected.to eq 200 }
  end

  describe 'upload' do
    subject { post :upload, params: params, as: :json }

    let(:params) { {} }

    context 'when an incorrect upload is requested' do
      its(:status) { is_expected.to eq 302 }

      it 'adds correct message to flash to show on the web page' do
        subject

        expect(flash[:error_message]).to eq 'File upload failed: u need to provide a file'
      end
    end

    context 'when a correct upload is requested' do
      let(:path_to_file) { Rails.root.join 'spec/test.txt' }
      let(:file) { Rack::Test::UploadedFile.new path_to_file, 'text/plain' }
      let(:params) do
        { upload: { datafile: file } }
      end

      before do
        allow(Net::SFTP).to receive(:start)
      end

      its(:status) { is_expected.to eq 302 }

      it 'calls sftp server start' do
        expect(Net::SFTP).to receive(:start)
        subject
      end
    end
  end
end
