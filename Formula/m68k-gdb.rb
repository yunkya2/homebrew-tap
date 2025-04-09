class M68kGdb < Formula
  desc "m68k cross GNU debugger"
  homepage "https://github.com/yunkya2/gdbserver-x68k"
  url "https://ftp.gnu.org/gnu/gdb/gdb-14.2.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-14.2.tar.xz"
  sha256 "2d4dd8061d8ded12b6c63f55e45344881e8226105f4d2a9b234040efa5ce7772"
  license "GPL-3.0-or-later"

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "texinfo"

  def install
    args = %W[
      --target=m68k-elf
      --without-python
      --with-gmp=#{Formula["gmp"].opt_prefix}
      --with-mpfr=#{Formula["mpfr"].opt_prefix}
      --with-system-zlib
    ]

    mkdir "build" do
      system "mkdir", "-p", "sim/common"
      system "../configure", *args, *std_configure_args
      system "make", "all-gdb"
      system "make", "install-gdb"
    end
  end
end
