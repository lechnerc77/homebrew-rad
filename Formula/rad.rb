class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.32.0/rad_darwin_amd64"
      sha256 "3180398e23e52898c5c35b2a29fea8be33a6956a79a757d7f5b90c586903d75d"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.32.0/rad_darwin_arm64"
      sha256 "5971c70bf2309bf5efce365362f020428598edf036bba3da0aa6580a72b0436de"
    end
  
    version "0.32.0"
    
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
  