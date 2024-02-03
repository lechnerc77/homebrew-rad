class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.30.0/rad_darwin_amd64"
      sha256 "fbb5497f8277486fff7f595985eb226a141c79b0fdbc185ea64edeca7ccd7905"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.30.0/rad_darwin_arm64"
      sha256 "5ac5bd74d7f006efc0ffce44893ccf1c0b0bd6a28f4ffc877a5a3f89ec7d2e47"
    end
  
    version "0.30.0"
    
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
  