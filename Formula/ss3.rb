class Ss3 < Formula
  desc "Interactive AWS S3 CLI tool"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool" # Link to the main repo or homepage for ss3
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v1.0.0.tar.gz" # Link to a tagged release
  sha256 "e21fe5ccf6c586ce8e6b4a0fb9f8c41c5375caef509d16e74d79d45835d39cbd" # SHA256 of the release archive
  license "MIT"

  depends_on "ruby" # Specify Ruby as a dependency


  def install
    # Install the main executable script
    bin.install "aws-s3-bucket-tool.rb" => "ss3"
  end

  test do
    # Basic test to check if the tool is accessible
    assert_match "Usage", shell_output("#{bin}/ss3 --help")
  end
end
