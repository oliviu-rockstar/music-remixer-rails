class Remix < ActiveRecord::Base
	mount_uploader :audio, RemixAudioUploader
	store_in_background :audio, RemixAudioUploadWorker

	enum status: {processing: 0, failed: 1, published: 2}

  default_value_for :uuid do
    SecureRandom.uuid
  end

  belongs_to :user, counter_cache: true
	belongs_to :song
end
