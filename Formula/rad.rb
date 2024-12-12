class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.41.0/rad_darwin_amd64"
      sha256 "6537a2a52bbda92994f8298d6ea6382c88240bf4f892040f64103eaf4fd88680"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.41.0/rad_darwin_arm64"
      sha256 "a452ac58169b594f35f4852eace9b57fd8a55a82843975a695cb7ffdc6949b82"
    end
  
    version "0.41.0"
    
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
  
