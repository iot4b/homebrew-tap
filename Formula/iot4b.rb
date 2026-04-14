class Iot4b < Formula
  desc "IOT4B Device"
  homepage "https://github.com/iot4b/device-go"
  url "https://github.com/iot4b/device-go/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "1c69c8e1189f01b562f6a071dce8d4799b45eb8a054b146ff092a944c336c3a8"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X device-go/packages/buildinfo.Version=2.0.1
    ]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"iot4b")

    (etc/"iot4b").install "config/iot4b.yml"
  end

  service do
    run [opt_bin/"iot4b"]
    keep_alive true
    working_dir var
    log_path var/"log/iot4b.log"
    error_log_path var/"log/iot4b.log"
  end

  test do
    assert_match "iot4b version 2.0.1", shell_output("#{bin}/iot4b --version")
  end
end
