class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.37.0/rad_darwin_amd64"
      sha256 "809b25cbcc5df9deb35222fd581639679fa65cd803b4d92267e9321c18930838"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.37.0/rad_darwin_arm64"
      sha256 "730fd5f03b05168a26ed0d4f9cea68517715d3510d1ee2799908e75ecfb54694"
    end
  
    version "0.37.0"
    
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
  
