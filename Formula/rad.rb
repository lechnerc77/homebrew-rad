class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.42.0/rad_darwin_amd64"
      sha256 "54099358b3426dad8ca53b11ec631606d63957cfbe7391774fc62a0c9afb459a"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.42.0/rad_darwin_arm64"
      sha256 "dc2ff9065df8d4e641a6ac314daf35143cab6d80f4276a5578d45a479f65735a"
    end
  
    version "0.42.0"
    
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
  
