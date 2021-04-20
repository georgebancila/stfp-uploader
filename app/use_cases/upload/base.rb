# frozen_string_literal: true

module Upload
  class Base < UseCase::Base
    depends UploadFile
  end
end
