"""Generate marketing screenshots for gooffgrid App Store / Play Store submission."""
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

BASE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(BASE, "screenshots")

BG_TOP = (10, 10, 10)
BG_BOT = (13, 13, 26)
NEON = (57, 255, 20)
WHITE = (255, 255, 255)
SUB = (200, 200, 210)

SCREENS = [
    ("01_unplug",    "Fişi çek, oyuna başla",         "Ekran süreni düşür, O₂ puan kazan", "🔌"),
    ("02_duel",      "Arkadaşlarınla düello yap",     "Kim daha az kullanırsa kazanır",    "⚔"),
    ("03_rewards",   "O₂ Puan ile ganimet kazan",     "Gerçek dünyada harcayabilirsin",    "💎"),
    ("04_breathe",   "Nefes al, odaklan",             "6 farklı nefes tekniği",            "🌿"),
    ("05_block",     "Uygulamaları yasakla",          "Sosyal medyayı kilitle",            "🚫"),
    ("06_global",    "13 dilde, dünyanın her yerinde","gooffgrid seninle",                 "🌍"),
]

SIZES = {
    "ios_67": (1290, 2796),
    "ios_65": (1242, 2688),
    "android": (1080, 1920),
}


def load_font(size, emoji=False):
    candidates = []
    if emoji:
        candidates += [
            r"C:\Windows\Fonts\seguiemj.ttf",
            r"C:\Windows\Fonts\segoeui.ttf",
        ]
    candidates += [
        r"C:\Windows\Fonts\segoeuib.ttf",
        r"C:\Windows\Fonts\segoeui.ttf",
        r"C:\Windows\Fonts\arialbd.ttf",
        r"C:\Windows\Fonts\arial.ttf",
    ]
    for path in candidates:
        try:
            return ImageFont.truetype(path, size)
        except Exception:
            continue
    return ImageFont.load_default()


def gradient_bg(w, h):
    img = Image.new("RGB", (w, h), BG_TOP)
    px = img.load()
    for y in range(h):
        t = y / max(1, h - 1)
        r = int(BG_TOP[0] * (1 - t) + BG_BOT[0] * t)
        g = int(BG_TOP[1] * (1 - t) + BG_BOT[1] * t)
        b = int(BG_TOP[2] * (1 - t) + BG_BOT[2] * t)
        for x in range(w):
            px[x, y] = (r, g, b)
    return img


def add_neon_glow(img, cx, cy, radius):
    glow = Image.new("RGBA", img.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(glow)
    for i in range(6):
        alpha = 40 - i * 6
        r = radius + i * 30
        d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=(57, 255, 20, max(0, alpha)))
    glow = glow.filter(ImageFilter.GaussianBlur(40))
    img.paste(glow, (0, 0), glow)
    return img


def draw_centered(draw, text, y, font, fill, w):
    bbox = draw.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    draw.text(((w - tw) / 2, y), text, font=font, fill=fill)
    return bbox[3] - bbox[1]


def wrap(text, font, draw, max_w):
    words = text.split()
    lines, cur = [], ""
    for word in words:
        trial = (cur + " " + word).strip()
        if draw.textbbox((0, 0), trial, font=font)[2] <= max_w:
            cur = trial
        else:
            if cur:
                lines.append(cur)
            cur = word
    if cur:
        lines.append(cur)
    return lines


def make_screenshot(w, h, headline, subtitle, emoji):
    img = gradient_bg(w, h).convert("RGBA")
    img = add_neon_glow(img, w // 2, int(h * 0.38), int(w * 0.28))
    draw = ImageDraw.Draw(img)

    # Top accent line
    draw.rectangle((int(w * 0.4), int(h * 0.08), int(w * 0.6), int(h * 0.085)), fill=NEON)

    # Emoji / icon
    emoji_font = load_font(int(w * 0.35), emoji=True)
    bbox = draw.textbbox((0, 0), emoji, font=emoji_font)
    ew = bbox[2] - bbox[0]
    eh = bbox[3] - bbox[1]
    draw.text(((w - ew) / 2, int(h * 0.28) - eh // 2), emoji, font=emoji_font, embedded_color=True)

    # Headline
    headline_font = load_font(int(w * 0.075))
    max_tw = int(w * 0.88)
    lines = wrap(headline, headline_font, draw, max_tw)
    y = int(h * 0.55)
    for line in lines:
        draw_centered(draw, line, y, headline_font, WHITE, w)
        y += int(w * 0.09)

    # Neon underline
    uy = y + int(w * 0.02)
    draw.rectangle((int(w * 0.35), uy, int(w * 0.65), uy + max(4, int(w * 0.008))), fill=NEON)

    # Subtitle
    sub_font = load_font(int(w * 0.045))
    y = uy + int(w * 0.05)
    for line in wrap(subtitle, sub_font, draw, max_tw):
        draw_centered(draw, line, y, sub_font, SUB, w)
        y += int(w * 0.06)

    # Logo bottom
    logo_font = load_font(int(w * 0.055))
    bbox = draw.textbbox((0, 0), "gooffgrid", font=logo_font)
    lw = bbox[2] - bbox[0]
    ly = int(h * 0.92)
    draw.text(((w - lw) / 2, ly), "gooffgrid", font=logo_font, fill=NEON)

    return img.convert("RGB")


def make_feature_graphic():
    w, h = 1024, 500
    img = gradient_bg(w, h).convert("RGBA")
    img = add_neon_glow(img, int(w * 0.8), h // 2, 120)
    draw = ImageDraw.Draw(img)

    title_font = load_font(70)
    sub_font = load_font(34)
    emoji_font = load_font(180, emoji=True)

    draw.text((60, 150), "gooffgrid", font=title_font, fill=NEON)
    draw.text((60, 240), "Fişi çek, oyuna başla", font=sub_font, fill=WHITE)
    draw.rectangle((60, 305, 260, 312), fill=NEON)
    draw.text((60, 330), "Dijital detoks + sosyal rekabet", font=sub_font, fill=SUB)

    draw.text((760, 140), "🔌", font=emoji_font, embedded_color=True)
    return img.convert("RGB")


def main():
    os.makedirs(OUT, exist_ok=True)
    count = 0
    for key, size in SIZES.items():
        folder = os.path.join(OUT, key)
        os.makedirs(folder, exist_ok=True)
        for i, (slug, headline, subtitle, emoji) in enumerate(SCREENS, 1):
            img = make_screenshot(size[0], size[1], headline, subtitle, emoji)
            path = os.path.join(folder, f"{i:02d}_{slug}.png")
            img.save(path, "PNG", optimize=True)
            count += 1
            print(f"[OK] {path}")

    fg = make_feature_graphic()
    fg_path = os.path.join(OUT, "feature_graphic.png")
    fg.save(fg_path, "PNG", optimize=True)
    count += 1
    print(f"[OK] {fg_path}")
    print(f"\nTotal files: {count}")


if __name__ == "__main__":
    main()
