pkgname=(
  vq-environment-configuration
  vq-skel
)
pkgrel=5
pkgver=0.0.1
source=(
  "vq-skel.zip"
  "vq-environment-configuration.zip"
)
sha512sums=(
  "c02de5c22da37dc2e9377a7c5d12ba9916c395d967e61a2b4885ea13970d308134a25f4f571c860d67d98e23a8c6bef21d1d67f86aa3c8f0a8a7d9132704cda1"
  "1d9971d981249fc3657ffca803cfccc2b3e3680828c0cd2b39cec63674e034589e5eb7cd686e66cb09d1c236fc7dadab24b315f93cf33fa6cffd9a8846a777f8"
)
arch=(
  any
)
validpgpkeys=(
  'EE92D3DE3C6C59543C0FF75CB7E510C142B88F4B' # Victor Queiroz <victorcqueirozg@gmail.com>
)

install_rootfs_package() {
  local source_dir="$srcdir/$1"

  local install_args
  find "${source_dir}" -type f | while IFS= read -r f; do
    local relative_file_path
    relative_file_path="$(realpath --relative-to="$source_dir" "$f")"

    install_args=(
      --verbose
      --mode=644
      --preserve-timestamps
      -D
      "$f"
      "$pkgdir/${relative_file_path}"
    )
    install "${install_args[@]}"
  done
}

package_vq-environment-configuration() {
  depends=(
    ibus
    fcitx5
    fcitx5-gtk
    qt5-wayland
    qt6-wayland
  )
  replaces=(
    environment-wayland
  )
  conflicts=(
    environment-wayland
  )
  replaces=(
    environment-wayland
  )

  install_rootfs_package "vq-environment-configuration"
}

package_vq-skel() {
  depends=(
    zsh
    pyenv
  )
  install_rootfs_package "vq-skel"
}
