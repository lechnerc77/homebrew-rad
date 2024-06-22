class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.35.0/rad_darwin_amd64"
      sha256 "12bcb6669dd65c19cff1446fbf46827d3e6d749bc16d63f36cc2069bed93434c"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.35.0/rad_darwin_arm64"
      sha256 "9dfda94767ff947e158d72f4faf14bd8b6bf5936aa5a9c98320b154d8b195805"
    end
  
    version "0.35.0"
    
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
  
