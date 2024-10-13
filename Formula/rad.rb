class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.39.0/rad_darwin_amd64"
      sha256 "9975b0f4e6dacf3477809061a507a5c7b8ee8a6ef352e9b2423ff77c4d7775bc"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.39.0/rad_darwin_arm64"
      sha256 "a06fafa7e76dbf76a5411889abc0d4994937be932c4c20bc02314099ad651ca1"
    end
  
    version "0.39.0"
    
    license "Apache 2.0"
  
    def install
      if Hardware::CPU.intel?
        bin.install "rad_darwin_amd64" => "rad"
      elsif Hardware::CPU.arm?
        bin.install "rad_darwin_arm64" => "rad"
      end
  
      (bin/".installed-by.txt").write "brew"
    end

    def caveats
      caveat = <<~EOS
        This is an unofficial tap for the Radius CLI and not an official part of the Radius project. 
      
        Execute the following command to complete the installation of the Radius CLI:
        rad bicep download
      EOS
      caveat
    end
  
    test do
      version_output = shell_output "#{bin}/rad version"
      assert_equal 0, $CHILD_STATUS.exitstatus
      assert_match "rad version", version_output
    end
  end
  
