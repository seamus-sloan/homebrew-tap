class Ss3 < Formula
  desc "Command-line S3 bucket explorer"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "993f3cfc3399ae5b19ddae61d86d5b7f7a344e4e0c6b9ac828581549b9b9bdc7"
  license "MIT"

  depends_on "ruby"
  # depends_on "bundler" => :build

  # def install
  #   # Install gem dependencies using Bundler in standalone mode
  #   system "bundle", "install", "--standalone", "--path", libexec

  #   # Install the 'bundle' directory
  #   # This is generated from `bundle install --standalone` in the script's repository.
  #   libexec.install "bundle"

  #   # Install Ruby class files
  #   lib.install "s3-navigator.rb", "ui-navigator.rb"

  #   # Install the main executable into libexec
  #   libexec.install "ss3.rb"

  #   # Adjust the ss3.rb script
  #   inreplace libexec/"ss3.rb" do |s|
  #     # Adjust the load path to include the lib directory
  #     s.gsub!("$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))", "$LOAD_PATH.unshift('#{lib}')")
  #   end

  #   # Create a wrapper script in bin to point to libexec/ss3.rb
  #   (bin/"ss3").write_env_script libexec/"ss3.rb", PATH: "#{Formula["ruby"].opt_bin}:$PATH"

  #   # Ensure the ss3.rb script in libexec is executable
  #   chmod "+x", libexec/"ss3.rb"
  # end



  def install
    # Use Homebrew's Ruby
    ENV["PATH"] = "#{Formula["ruby"].opt_bin}:#{ENV["PATH"]}"

    # Install gem dependencies globally (not recommended)
    system "bundle", "install"

    # Install files into bin
    bin.install "ss3.rb"
    bin.install "s3-navigator.rb", "ui-navigator.rb"

    # Rename and make executable
    mv bin/"ss3.rb", bin/"ss3"
    chmod "+x", bin/"ss3"
  end

  test do
    system "#{bin}/ss3", "--help"
  end
end
