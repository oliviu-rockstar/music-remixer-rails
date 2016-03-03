class Remix < ActiveRecord::Base
	include PublicActivity::Common

	mount_uploader :audio, RemixAudioUploader
	store_in_background :audio, RemixAudioUploadWorker

	enum status: {processing: 0, failed: 1, published: 2, archived: 3, deleted: 4}

  default_value_for :uuid do  #important, needs to be in a block
    SecureRandom.hex(6)
  end

  belongs_to :user
  belongs_to :song
  has_many :remixes,    -> { order 'remixes.plays_count desc'}, dependent: :delete_all

  # allow comments on remixes
  acts_as_commentable
  acts_as_likeable

end
