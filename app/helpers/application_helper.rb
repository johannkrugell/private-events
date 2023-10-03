module ApplicationHelper
  def random_image_path
    image_files = Dir.glob('app/assets/images/*.{jpg,png,gif}')
    image_files.sample
    File.basename(image_files.sample)
  end
end
