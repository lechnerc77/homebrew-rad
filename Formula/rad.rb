class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.34.0/rad_darwin_amd64"
      sha256 "5d24ff26c9fa22474aa1dcd34f99003bf30584817b91b5bb698e49c04cc20a2a"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.34.0/rad_darwin_arm64"
      sha256 "7e6c37ea6ba5423dfcd32f91b5ef4b172592959a923dfb95f765d10d910752e8"
    end
  
    version "0.34.0"
    
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
  
