pkgname=environment-wayland
pkgrel=3
pkgver=0.0.1
source=(
  "source.zip"
)
sha512sums=(
  # source.zip
  'eed390bdb6f55c899714d5943d7a49bce96f7c85d31ec8bea3b19139ac468a37a62032639e098c0117b5f6971ed8803a2db6c272801a6d5aee96833825cab94a'
)
arch=(
  any
)
validpgpkeys=(
  'EE92D3DE3C6C59543C0FF75CB7E510C142B88F4B' # Victor Queiroz <victorcqueirozg@gmail.com>
)
depends=(
  ibus
  fcitx5
  fcitx5-gtk
  qt5-wayland
  qt6-wayland
)

package() {
  local install_args
  find "$srcdir/source" -type f | while IFS= read -r f; do
    install_args=(
      --verbose
      -D
      -m644
      "$f"
      "$pkgdir/$(realpath --relative-to="$srcdir/source" "$f")"
    )
    install "${install_args[@]}"
  done
}

# package_environment-electron() {
#   depends=(
#     electron2-bin
#     electron6-bin
#     electron3-bin
#     electron4-bin
#     electron5-bin
#     electron7-bin
#     electron8-bin
#     electron9-bin
#     electron10-bin
#     electron11-bin
#     electron12-bin
#     electron13-bin
#     electron14-bin
#     electron15-bin
#     electron16-bin
#     electron17-bin
#     electron18-bin
#     electron19-bin
#     electron20-bin
#     electron21-bin
#     electron22-bin
#     electron23-bin
#     electron24-bin
#     electron25-bin
#     electron26-bin
#     electron27-bin
#     electron28-bin
#     electron29-bin
#     electron30-bin
#     electron31
#     electron32-bin
#     electron33-bin
#     electron34
#     electron35-bin
#     electron36-bin
#   )
#
#   optdepends=(
#     environment-wayland
#   )
#
#
#
# }
