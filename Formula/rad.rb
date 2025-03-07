class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.44.0/rad_darwin_amd64"
      sha256 "9f9954fdc7feefc21d2c874339e6d6be3061b8d2a67924f3733d88b7ed3d0ed3"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.44.0/rad_darwin_arm64"
      sha256 "da6468d569d5bf0a68b40d446b850ac779cb903374da94e720039538e34b9580"
    end
  
    version "0.44.0"
    
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
  
