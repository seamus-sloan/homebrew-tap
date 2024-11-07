class Ss3 < Formula
  desc "Interactive AWS S3 CLI tool"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool" # Link to the main repo or homepage for ss3
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v1.0.1.tar.gz" # Link to a tagged release
  sha256 "61cc719eb0340febcf769907e8b5274497c554c964c07bcc76b9f276f6a7f656" # SHA256 of the release archive
  license "MIT"

  depends_on "ruby" # Specify Ruby as a dependency


  def install
    # Install all files to libexec
    libexec.install Dir["*"]

    # Create an executable in bin that points to the main script in libexec
    (bin/"ss3").write_env_script libexec/"aws-s3-bucket-tool.rb", RUBYLIB: libexec
  end

  test do
    # Basic test to check if the tool is accessible
    assert_match "Usage", shell_output("#{bin}/ss3 --help")
  end
end
