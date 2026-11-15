#!/usr/bin/env python3
"""
make_app_icons.py - build the W10M app icons from logo.jpg (Java cup on #525BA0).

The source logo says "J2ME Loader"; only the cup is reused and the text is
redrawn per app variant (Segoe UI):
  W10M  "J2ME Windows 10 Mobile"  -> Project/W10M/App/Assets
  WP81  "J2ME Windows Phone 8.1"  -> Project/WP81/App/Icons (copied into Assets by the csproj)
  WP80  "J2ME Windows Phone 8"    -> Project/WP80/App/Icons
Writes (per variant dir):
  logo_j2mewp.png                         (repo root, 730x429 brand image)
  Project/W10M/App/Assets/Square44x44Logo.png    (88x88, cup)
  Project/W10M/App/Assets/Square150x150Logo.png  (300x300, cup + 2 lines)
  Project/W10M/App/Assets/Wide310x150Logo.png    (620x300, cup + text)
  Project/W10M/App/Assets/StoreLogo.png          (100x100, cup)
  Project/W10M/App/Assets/SplashScreen.png       (1240x600, cup + text)
Each asset is written as NAME.png (1x, exact size) and NAME.scale-200.png (2x).

Usage: python3 Project/tools/make_app_icons.py
"""
import os
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
SRC = os.path.join(ROOT, 'logo.jpg')
VARIANTS = [
    ('Windows 10 Mobile', os.path.join(ROOT, 'Project', 'W10M', 'App', 'Assets'), True),
    ('Windows Phone 8.1', os.path.join(ROOT, 'Project', 'WP81', 'App', 'Icons'), False),
    ('Windows Phone 8', os.path.join(ROOT, 'Project', 'WP80', 'App', 'Icons'), False),
]
ASSETS = VARIANTS[0][1]
BG = (82, 91, 160)
CUP_BOX = (263, 40, 458, 303)
FONT_BOLD = r'C:\Windows\Fonts\segoeuib.ttf'
FONT = r'C:\Windows\Fonts\segoeui.ttf'


def cup():
    """White cup with alpha from brightness above the background."""
    if os.path.exists(SRC):
        g = Image.open(SRC).convert('L').crop(CUP_BOX)
    else:
        # logo.jpg is gone: take the cup back from our own brand image (same
        # background, cup drawn centred at (365, 171), 263 px high, original size)
        w = CUP_BOX[2] - CUP_BOX[0]
        x0 = round(365 - w / 2)
        g = Image.open(os.path.join(ROOT, 'logo_j2mewp.png')).convert('L').crop((x0, 40, x0 + w, 303))
    bg_l = 98
    alpha = g.point(lambda v: max(0, min(255, (v - bg_l) * 255 // (255 - bg_l))))
    c = Image.new('RGBA', g.size, (255, 255, 255, 0))
    c.putalpha(alpha)
    return c


CUP = cup()


def place_cup(img, cx, cy, h):
    w = round(CUP.width * h / CUP.height)
    c = CUP.resize((w, h), Image.LANCZOS)
    img.alpha_composite(c, (round(cx - w / 2), round(cy - h / 2)))


def text(img, s, cx, cy, size, bold=True):
    d = ImageDraw.Draw(img)
    f = ImageFont.truetype(FONT_BOLD if bold else FONT, size)
    l, t, r, b = d.textbbox((0, 0), s, font=f)
    d.text((round(cx - (r - l) / 2 - l), round(cy - (b - t) / 2 - t)), s, font=f, fill=(255, 255, 255, 255))


def fit_size(s, max_w, size, bold=True):
    while size > 8:
        f = ImageFont.truetype(FONT_BOLD if bold else FONT, size)
        l, _, r, _ = ImageDraw.Draw(Image.new('RGBA', (1, 1))).textbbox((0, 0), s, font=f)
        if r - l <= max_w:
            return size
        size -= 1
    return size


def canvas(w, h):
    return Image.new('RGBA', (w, h), BG + (255,))


def save(img, name):
    """App assets are drawn at 2x: write NAME.scale-200.png (2x) and NAME.png
    (exact 1x size, required by the manifest validator)."""
    if os.path.isabs(name):
        img.save(name)
        print('wrote', os.path.relpath(name, ROOT), img.size)
        return
    base, ext = os.path.splitext(name)
    p2 = os.path.join(ASSETS, base + '.scale-200' + ext)
    img.save(p2)
    small = img.resize((img.width // 2, img.height // 2), Image.LANCZOS)
    p1 = os.path.join(ASSETS, name)
    small.save(p1)
    print('wrote', os.path.relpath(p1, ROOT), small.size, '+ scale-200', img.size)


def build(sub, assets, brand):
    global ASSETS
    ASSETS = assets
    os.makedirs(assets, exist_ok=True)
    title = 'J2ME ' + sub
    if brand:
        # Brand image, same layout as the source logo.
        im = canvas(730, 429)
        place_cup(im, 365, 171, 263)
        text(im, title, 365, 352, fit_size(title, 640, 40))
        save(im, os.path.join(ROOT, 'logo_j2mewp.png'))

    im = canvas(88, 88); place_cup(im, 44, 44, 70); save(im, 'Square44x44Logo.png')
    im = canvas(100, 100); place_cup(im, 50, 50, 78); save(im, 'StoreLogo.png')

    im = canvas(300, 300)
    place_cup(im, 150, 118, 150)
    text(im, 'J2ME', 150, 222, 34)
    text(im, sub, 150, 258, fit_size(sub, 260, 26, bold=False), bold=False)
    save(im, 'Square150x150Logo.png')

    im = canvas(620, 300)
    place_cup(im, 140, 150, 210)
    text(im, 'J2ME', 410, 120, 64)
    text(im, sub, 410, 190, fit_size(sub, 360, 44, bold=False), bold=False)
    save(im, 'Wide310x150Logo.png')

    im = canvas(1240, 600)
    place_cup(im, 620, 250, 330)
    text(im, title, 620, 490, fit_size(title, 1000, 64))
    save(im, 'SplashScreen.png')

    if not brand:
        # WP8.0 / 8.1 Silverlight: full-screen portrait splash (SplashScreenImage.jpg,
        # 768x1280, the OS scales it to every screen). Without it WP8.1 shows the
        # small appx splash centred on the tile colour.
        im = canvas(768, 1280)
        place_cup(im, 384, 560, 420)
        text(im, 'J2ME', 384, 860, 96)
        text(im, sub, 384, 960, fit_size(sub, 680, 60, bold=False), bold=False)
        p = os.path.join(os.path.dirname(assets), 'SplashScreenImage.jpg')
        im.convert('RGB').save(p, quality=92)
        print('wrote', os.path.relpath(p, ROOT), im.size)
        # WP8.1 appx splash (m3:SplashScreen) is full-screen portrait on phones:
        # 480x800 at scale 100, 1152x1920 at scale 240 (not the 620x300 W10M one).
        wide200 = os.path.join(assets, 'SplashScreen.scale-200.png')
        if os.path.exists(wide200):
            os.remove(wide200)
        big = im.resize((1152, 1920), Image.LANCZOS)
        big.save(os.path.join(assets, 'SplashScreen.scale-240.png'))
        big.resize((480, 800), Image.LANCZOS).save(os.path.join(assets, 'SplashScreen.png'))
        print('wrote', os.path.relpath(os.path.join(assets, 'SplashScreen.png'), ROOT), '(480, 800) + scale-240')


def main():
    for sub, assets, brand in VARIANTS:
        build(sub, assets, brand)


if __name__ == '__main__':
    main()
