class ImageUploader < CarrierWave::Uploader::Base
   include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [1920, 1080], :if => :image?
  
  version :thumb, :if => :image? do
    process resize_to_fit: [300, 300]
  end


  def image?(new_file)
    self.file.content_type.include? 'image'
  end

   def extension_allowlist
     %w(jpg jpeg png webp avi m4v mp4 mpeg mpg ico)
   end
end
