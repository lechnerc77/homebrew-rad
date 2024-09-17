class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.38.0/rad_darwin_amd64"
      sha256 "6598be9393e6377ffa961fe3c2d73798739a4aa66af5bd710cab17c178cd5914"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.38.0/rad_darwin_arm64"
      sha256 "89f0e1bbced9d9fc5de64ec295a604a265e7865cbeb4e8e0435631ca401fbf5d"
    end
  
    version "0.38.0"
    
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
  
