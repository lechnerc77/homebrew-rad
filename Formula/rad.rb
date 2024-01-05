class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.28.0/rad_darwin_amd64"
      sha256 "619776c81240c0bb2ea3409a36f8d4e319f5bb48d46b40f237978f5eb932d449"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.28.0/rad_darwin_arm64"
      sha256 "175e7db5f53f28fceafb50150288255cc0e6fd06004b69d2dbd691827ec0a242"
    end
  
    version "0.28.0"
    
    license "MIT"
  
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
      
      EOS
      caveat
    end
  
    test do
      version_output = shell_output "#{bin}/rad version"
      assert_equal 0, $CHILD_STATUS.exitstatus
      assert_match "rad version", version_output
    end
  end
  