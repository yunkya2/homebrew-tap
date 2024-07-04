class Elf2x68k < Formula
  desc "X68k cross development environment"
  homepage "https://github.com/yunkya2/elf2x68k"
  url "https://github.com/yunkya2/elf2x68k.git",
     tag: "20240707"

  depends_on "wget"
  depends_on "texinfo"

  def install
    system "make", "binutils", "INSTALL_DIR=#{prefix}"
    system "make", "gcc-stage1", "INSTALL_DIR=#{prefix}"
    system "make", "newlib", "INSTALL_DIR=#{prefix}"
    system "make", "gcc-stage2", "INSTALL_DIR=#{prefix}"
    system "make", "install", "INSTALL_DIR=#{prefix}"
    system "bash", "-c", "(cd #{prefix};./install-xclib.sh)"
  end
end
