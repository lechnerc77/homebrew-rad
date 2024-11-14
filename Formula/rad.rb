class Rad < Formula
    desc "Radius CLI"
    homepage "https://github.com/radius-project/radius"
    
    if Hardware::CPU.intel?
      url "https://github.com/radius-project/radius/releases/download/v0.40.0/rad_darwin_amd64"
      sha256 "79ba47bcb94c5a71c174a2946a754ceb332a24be613fc4ed3e2ec2b669dac179"
    elsif Hardware::CPU.arm?
      url "https://github.com/radius-project/radius/releases/download/v0.40.0/rad_darwin_arm64"
      sha256 "542f7bc5eb124812a0c1d057fdf8da6e8ff83ff0cae97decbdd4532dabfe5595"
    end
  
    version "0.40.0"
    
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
  
