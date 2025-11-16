class Elf2x68k < Formula
  desc "X68k cross development environment"
  homepage "https://github.com/yunkya2/elf2x68k"
  url "https://github.com/yunkya2/elf2x68k.git",
     tag: "20251106"

  depends_on "texinfo"
  depends_on "wget"

  def install
    system "make", "binutils", "INSTALL_DIR=#{prefix}"
    system "make", "gcc-stage1", "INSTALL_DIR=#{prefix}"
    system "make", "newlib", "INSTALL_DIR=#{prefix}"
    system "make", "gcc-stage2", "INSTALL_DIR=#{prefix}"
    system "make", "gdb", "INSTALL_DIR=#{prefix}"
    ENV.deparallelize
    system "make", "install", "INSTALL_DIR=#{prefix}"
    system "bash", "-c", "(cd #{prefix};./install-xclib.sh)"
  end

  test do
    # Test that the cross compiler is installed and working
    assert_predicate bin/"m68k-xelf-gcc", :exist?
    
    # Test basic compilation
    (testpath/"test.c").write <<~EOS
      int main() {
          return 0;
      }
    EOS
    
    system bin/"m68k-xelf-gcc", "test.c", "-o", "test.x"
    assert_predicate testpath/"test.x", :exist?
  end
end
