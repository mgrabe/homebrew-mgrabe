require 'formula'

class WxmaximaRetina < Formula
  homepage 'http://andrejv.github.io/wxmaxima'
  url 'https://downloads.sourceforge.net/project/wxmaxima/wxMaxima/13.04.2/wxMaxima-13.04.2.tar.gz'
  sha1 '9508d3badb6c339f34e73e01c5065f679329a17c'

  depends_on 'wxmac'

  patch :DATA

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system 'make'
    cd 'locales' do
      system 'make', 'allmo'
    end
    system 'make', 'wxMaxima.app'
    prefix.install 'wxMaxima.app'
    system "make install"
  end

  def caveats
    <<-EOS.undent
      The program you want to run is wxmaxima.app, and it gets installed into:
        #{prefix}

       To symlink it into Applications, you can type:
         ln -s #{prefix}/wxmaxima.app /Applications

       When you start wxmaxima the first time, you have to open Preferences,
       and tell it where maxima is located.

    EOS
  end
end
__END__
diff --git a/src/MathCtrl.cpp b/src/MathCtrl.cpp
index 357e606..94b5332 100644
--- a/src/MathCtrl.cpp
+++ b/src/MathCtrl.cpp
@@ -124,7 +124,11 @@ void MathCtrl::OnPaint(wxPaintEvent& event) {
 
   // Thest if m_memory is NULL (resize event)
   if (m_memory == NULL)
-    m_memory = new wxBitmap(sz.x, sz.y);
+  {
+    // m_memory = new wxBitmap(sz.x, sz.y);
+     m_memory = new wxBitmap();
+     m_memory->CreateScaled (sz.x, sz.y, -1, dc.GetContentScaleFactor ());
+  }
 
   // Prepare memory DC
   wxString bgColStr= wxT("white");
