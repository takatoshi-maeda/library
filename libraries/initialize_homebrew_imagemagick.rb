def initialize_homebrew_imagemagick
  script "rmagick install fail patch" do
    interpreter "bash"
    flags "-e"
    code <<-"EOS"
    MAGICKDIR="/usr/local/Cellar/imagemagick/`ls /usr/local/Cellar/imagemagick/`/lib"
    ln -sf $MAGICKDIR/libMagickWand-Q16.7.dylib $MAGICKDIR/libMagickWand.dylib
    ln -sf $MAGICKDIR/libMagickCore-Q16.7.dylib $MAGICKDIR/libMagickCore.dylib
    ln -sf $MAGICKDIR/libMagick++-Q16.7.dylib   $MAGICKDIR/libMagick++.dylib
    EOS
  end
end
