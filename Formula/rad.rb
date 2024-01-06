class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.29.0/rad_darwin_amd64"
      sha256 "f22d2c407cef2f8daa3fe9a57c1cb721b5974f4302884534c212038e4a8d36fd"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.29.0/rad_darwin_arm64"
      sha256 "e2aa303c0ce42d420603466f0b9f6a70de6e703dfcb3edbc091595d109e6afaa"
    end
  
    version "0.29.0"
    
    license "MIT"
  
    def install
      if Hardware::CPU.intel?
        bin.install "rad_darwin_amd64" => "rad"
      elsif Hardware::CPU.arm?
        bin.install "rad_darwin_arm64" => "rad"
      end
  
      (bin/".installed-by.txt").write "brew"
    end

    def post_install
      # Execute the command "rad bicep download" as post install step 
      system "sudo rad bicep download"
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
  