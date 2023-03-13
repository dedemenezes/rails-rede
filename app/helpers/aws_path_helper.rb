module AwsPathHelper
  def aws_image(element)
    return unless element.banner.attached?

    # binding.break
    rails_blob_path(element.banner, only_path: true)
  end
end
