class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.43.0/rad_darwin_amd64"
      sha256 "61b5ed3b10b30b8997b5849af24a5616646209cf8d152dd6b663c3dbfed8f25a"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.43.0/rad_darwin_arm64"
      sha256 "b3b72e37a136aa1a7903bb6b9c0f9f8eb4a2a1d0efdc068f3fa6c0440f02a607"
    end
  
    version "0.43.0"
    
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
  
