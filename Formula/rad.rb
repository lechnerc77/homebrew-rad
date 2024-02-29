class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.31.0/rad_darwin_amd64"
      sha256 "d7ccd373bd20767c8840722523e63afb2ffb04863e193149a462cfbaa1d2f548"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.31.0/rad_darwin_arm64"
      sha256 "5655a7d8e66dfcb783a5c3df4234caa9ab924ac916f93e113043d4dd7fb897f3"
    end
  
    version "0.31.0"
    
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
  