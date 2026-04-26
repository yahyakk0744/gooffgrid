"""Generate gooffgrid brand icon.

Palette:
- bg: near-black (#0A0F14) with radial accent glow
- accent: neon mint (#7FE7B6)
- foreground: giant "g" with offset glow

Outputs:
- icon_1024.png (App Store master)
- icon_512.png (Play Store master)
"""
from PIL import Image, ImageDraw, ImageFilter, ImageFont
from pathlib import Path
import math


OUT_DIR = Path(__file__).parent
ACCENT = (127, 231, 182)
BG_DARK = (10, 15, 20)
BG_MID = (18, 26, 32)
TEXT_FG = (10, 15, 20)


def _font(size: int) -> ImageFont.ImageFont:
    # Try common bundled fonts on Windows for a bold black glyph.
    candidates = [
        "C:/Windows/Fonts/segoeuib.ttf",
        "C:/Windows/Fonts/arialbd.ttf",
        "C:/Windows/Fonts/seguisb.ttf",
    ]
    for path in candidates:
        if Path(path).exists():
            try:
                return ImageFont.truetype(path, size)
            except OSError:
                continue
    return ImageFont.load_default()


def _radial_gradient(size: int) -> Image.Image:
    img = Image.new("RGB", (size, size), BG_DARK)
    cx, cy = size / 2, size * 0.42
    max_r = size * 0.7
    px = img.load()
    for y in range(size):
        for x in range(size):
            dx, dy = x - cx, y - cy
            d = math.sqrt(dx * dx + dy * dy) / max_r
            d = min(max(d, 0), 1)
            # blend accent glow (soft) into dark bg
            glow = (1 - d) ** 2 * 0.28
            r = int(BG_DARK[0] * (1 - glow) + ACCENT[0] * glow)
            g = int(BG_DARK[1] * (1 - glow) + ACCENT[1] * glow)
            b = int(BG_DARK[2] * (1 - glow) + ACCENT[2] * glow)
            px[x, y] = (r, g, b)
    return img


def _rounded_mask(size: int, radius_ratio: float = 0.22) -> Image.Image:
    mask = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(mask)
    r = int(size * radius_ratio)
    d.rounded_rectangle([(0, 0), (size, size)], radius=r, fill=255)
    return mask


def build_icon(size: int) -> Image.Image:
    bg = _radial_gradient(size)

    # Main "g" glyph — sized to fit comfortably inside safe area
    glyph_size = int(size * 0.62)
    font = _font(glyph_size)

    gx = size // 2
    gy = int(size * 0.52)

    # Outer glow (big, soft)
    glow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    gd = ImageDraw.Draw(glow)
    gd.text((gx, gy), "g", font=font, fill=(*ACCENT, 180), anchor="mm")
    glow = glow.filter(ImageFilter.GaussianBlur(radius=size * 0.05))
    bg.paste(glow, (0, 0), glow)

    # Inner glow (tighter)
    inner_glow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    igd = ImageDraw.Draw(inner_glow)
    igd.text((gx, gy), "g", font=font, fill=(*ACCENT, 200), anchor="mm")
    inner_glow = inner_glow.filter(ImageFilter.GaussianBlur(radius=size * 0.015))
    bg.paste(inner_glow, (0, 0), inner_glow)

    # Foreground glyph — solid accent, crisp
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    ld = ImageDraw.Draw(layer)
    ld.text((gx, gy), "g", font=font, fill=(*ACCENT, 255), anchor="mm")
    bg.paste(layer, (0, 0), layer)


    # Apply rounded square mask for Android adaptive aesthetic (iOS crops
    # to its own mask so this is safe).
    rounded = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    rounded.paste(bg, (0, 0), _rounded_mask(size))
    return rounded


def main() -> None:
    for s in (1024, 512):
        img = build_icon(s)
        out = OUT_DIR / f"icon_{s}.png"
        img.save(out, "PNG", optimize=True)
        print(f"[ok] {out} ({out.stat().st_size / 1024:.1f} KB)")


if __name__ == "__main__":
    main()
