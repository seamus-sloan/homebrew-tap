class Ss3 < Formula
  desc "Interactive AWS S3 CLI tool"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "68910c30ea9adcc267a7057617637de12eb42409b93d9d20fd6e4869d96fc8b0"
  license "MIT"

  depends_on "ruby"

  def install
    # Install the main script
    bin.install "aws-s3-bucket-tool.rb"

    # Install helper files to libexec
    libexec.install "ui-helper.rb", "s3-helper.rb"

    # Set AWS_S3_BUCKET_TOOL_LIB environment variable in the executable script
    (bin/"aws-s3-bucket-tool").write_env_script libexec/"aws-s3-bucket-tool.rb", AWS_S3_BUCKET_TOOL_LIB: libexec
  end

  test do
    # Basic test to check if the tool is accessible
    assert_match "Usage", shell_output("#{bin}/ss3 --help")
  end
end
