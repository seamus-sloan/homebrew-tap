class Ss3 < Formula
  desc "Command-line S3 bucket explorer"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "b124fa62c9ae33d9b42dfd5c21dc903475e7b54f0c65bb1b1a67835e6c461819"
  license "MIT"

  depends_on "ruby"

  def install
    # Install all project files into libexec
    libexec.install Dir["*"]

    # Set up environment variables for Bundler
    ENV["GEM_HOME"] = libexec/"vendor/bundle"
    ENV["GEM_PATH"] = ENV["GEM_HOME"]
    ENV["BUNDLE_GEMFILE"] = libexec/"Gemfile"
    ENV["BUNDLE_PATH"] = ENV["GEM_HOME"]
    ENV["BUNDLE_APP_CONFIG"] = libexec/".bundle"

    # Change directory to libexec for Bundler installation
    cd libexec do
      # Configure Bundler settings
      system "bundle", "config", "set", "--local", "deployment", "true"
      system "bundle", "config", "set", "--local", "without", "development test"

      # Install gem dependencies into vendor/bundle
      system "bundle", "install"
    end

    # Create a wrapper script in bin
    (bin/"ss3").write_env_script libexec/"ss3", {
      GEM_HOME:        ENV["GEM_HOME"],
      GEM_PATH:        ENV["GEM_PATH"],
      BUNDLE_GEMFILE:  ENV["BUNDLE_GEMFILE"],
      BUNDLE_PATH:     ENV["BUNDLE_PATH"],
      BUNDLE_APP_CONFIG: ENV["BUNDLE_APP_CONFIG"],
      RUBYLIB:         libexec.to_s
    }
  end

  test do
    system "#{bin}/ss3", "--help"
  end
end
