#!/bin/bash

main() {
  local root_dir
  root_dir="$(pwd)"

  local src_dir
  src_dir="${root_dir}/source"

  local folder_list
  folder_list=()

  mapfile -t folder_list < <(
    local find_args
    find_args=(
      "${src_dir}"
      -mindepth 1
      -maxdepth 1
    )
    find "${find_args[@]}"
  )

  local compressed_file_list
  compressed_file_list=()

  local sha512sums
  sha512sums=()

  for folder in "${folder_list[@]}"; do
    printf 'Processing "%s"\n' "${folder}"

    local relative_folder_path
    relative_folder_path="$(realpath --relative-to "${src_dir}" "${folder}")"

    local package_name
    package_name="$(basename "${folder}")"

    # Create a `.zip` file with the package name as the only root folder
    local out_file
    out_file="${root_dir}/${package_name}.zip"

    # If `out_file` already exists, delete it
    if [ -f "${out_file}" ]; then
      rm -v "${out_file}"
    fi

    cd "${src_dir}" || exit 1

    local zip_args
    zip_args=(
      -9 -r -v
      "${out_file}"
      "$relative_folder_path"
    )

    zip "${zip_args[@]}" || exit 1

    # Add the output file to the list
    compressed_file_list+=("$(basename "${out_file}")")

    # Calculate the SHA512 sum of the `.zip` file
    local out_file_sum
    out_file_sum="$(sha512sum "${out_file}" | awk '{print $1}')"

    sha512sums+=("${out_file_sum}")
  done

  print_quoted "${compressed_file_list[@]}"

  printf '\n\n'

  print_quoted "${sha512sums[@]}"
}

print_quoted() {
  for arg in "$@"; do
    printf '"%s"\n' "$arg"
  done
}

main || exit 1
