set -ex

CARGO_TARGET="${HOST}"
CARGO_TARGET="$(echo -n ${CARGO_TARGET} | sed "s/conda/unknown/")"
CARGO_TARGET="$(echo -n ${CARGO_TARGET} | sed "s/darwin.*/darwin/")"
CARGO_TARGET="$(echo -n ${CARGO_TARGET} | sed "s/arm64/aarch64/")"

cargo cinstall \
    --library-type cdylib \
    --release \
    --prefix "${PREFIX}" \
    --target "${CARGO_TARGET}"

# rav1e includes a command line utility that cinstall will not install          
cargo install \
    --path . \
    --root "${PREFIX}" \
    --target "${CARGO_TARGET}"

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
