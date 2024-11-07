class Ss3 < Formula
  desc "Interactive AWS S3 CLI tool"
  homepage "https://github.com/seamus-sloan/aws-s3-bucket-tool"
  url "https://github.com/seamus-sloan/aws-s3-bucket-tool/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "1f29bfd69d383ce7287c657368f937dc9a19e7d5af5ee80befbeb4fe1e97e747"
  license "MIT"

  depends_on "ruby"

  def install
    # Set up Bundler to install gems into libexec/vendor/bundle
    ENV["GEM_HOME"] = libexec/"vendor/bundle"
    ENV["BUNDLE_PATH"] = libexec/"vendor/bundle"
    ENV["BUNDLE_GEMFILE"] = buildpath/"Gemfile"

    # Install Bundler and all dependencies specified in the Gemfile
    system "gem", "install", "bundler"
    system "bundle", "install", "--path", libexec/"vendor/bundle"

    # Install main script and helper files to libexec
    libexec.install "aws-s3-bucket-tool.rb", "ui-helper.rb", "s3-helper.rb", "Gemfile", "Gemfile.lock"

    # Create a wrapper script in bin that uses Homebrew's Ruby directly
    ruby_path = Formula["ruby"].opt_bin/"ruby"
    (bin/"ss3").write <<~EOS
      #!/bin/bash
      export GEM_HOME="#{libexec}/vendor/bundle"
      export BUNDLE_GEMFILE="#{libexec}/Gemfile"
      export BUNDLE_PATH="#{libexec}/vendor/bundle"
      export PATH="#{Formula["ruby"].opt_bin}:$PATH" # Override PATH to prioritize Homebrew's Ruby
      exec "#{ruby_path}" "#{libexec}/aws-s3-bucket-tool.rb" "$@"
    EOS
    chmod "+x", bin/"ss3"
  end

  test do
    # Test if the tool runs and shows a usage message or similar output
    assert_match "Usage", shell_output("#{bin}/ss3 --help")
  end
end
