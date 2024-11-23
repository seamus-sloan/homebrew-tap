class Ss3 < Formula
  desc "Command-line S3 bucket explorer"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "8a54bffbe1da5b68c49c9b32f95f7b17c964a65d4f079d825fcc32cef3151154"
  license "MIT"

  depends_on "ruby"

  def install
    # Use Homebrew's Ruby
    ruby_bin = Formula["ruby"].opt_bin/"ruby"
  
    # Set PATH to prioritize Homebrew's Ruby
    ENV.prepend_path "PATH", Formula["ruby"].opt_bin
  
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
      # Use Homebrew's Ruby for Bundler commands
      system ruby_bin, "-S", "bundle", "config", "set", "--local", "deployment", "true"
      system ruby_bin, "-S", "bundle", "config", "set", "--local", "without", "development test"
  
      # Install gem dependencies into vendor/bundle
      system ruby_bin, "-S", "bundle", "install"
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
