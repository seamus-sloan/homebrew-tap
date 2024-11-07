class Ss3 < Formula
  desc "Interactive AWS S3 CLI tool"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2e38968f136afdecb362cfdc884ebce965ebdea27d618499a66a589fcd2851b6"
  license "MIT"

  depends_on "ruby"

  def install
    # Install helper files and main script to libexec
    libexec.install "aws-s3-bucket-tool.rb", "ui-helper.rb", "s3-helper.rb"

    # Create a wrapper script in bin
    (bin/"ss3").write_env_script libexec/"aws-s3-bucket-tool.rb", PATH: "#{libexec}:$PATH"
  end

  test do
    # Test if the tool runs and shows a usage message or similar output
    assert_match "Usage", shell_output("#{bin}/ss3 --help")
  end
end
