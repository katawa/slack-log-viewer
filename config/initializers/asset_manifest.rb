class AssetManifest
  def self.webpack_entry_path(url)
    webpackify_url(url)
  end

  class << self
    if Rails.env.production?
      define_method :webpackify_url do |url|
        "/assets/#{url}"
      end
    else
      define_method :webpackify_url do |url|
        "http://localhost:8080/#{url}"
      end
    end
  end
end
