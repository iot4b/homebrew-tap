class Iot4b < Formula
  desc "IOT4B Device"
  homepage "https://github.com/iot4b/device-go"
  url "https://github.com/iot4b/device-go/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "3a786247cfed09e22f11fac8b2f03da70e29efa09d84a2d193fb725f365559b8"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X device-go/packages/buildinfo.Version=3.0.0
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
    assert_match "iot4b version 3.0.0", shell_output("#{bin}/iot4b --version")
  end
end
