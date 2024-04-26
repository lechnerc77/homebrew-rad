class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.33.0/rad_darwin_amd64"
      sha256 "309dfbd901b12997b0aeb2aeb51649f078481a754f64a71c784ce04b8bdc5851"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.33.0/rad_darwin_arm64"
      sha256 "74e8117253c1b15430f02f462fdb3dc98a5d3d80240797732c7f2010f3b47075"
    end
  
    version "0.33.0"
    
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
  