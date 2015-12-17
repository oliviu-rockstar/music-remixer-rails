# encoding: utf-8

class SongZipfileUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # Override the directory where uploaded files will be stored.
  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.uuid}"
  end

  def fog_directory
    'private_audio'
  end

  def fog_public
    false
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(zip)
  end

  def filename
    "#{secure_token(32)}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

end
