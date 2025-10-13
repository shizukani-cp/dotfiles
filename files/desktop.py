from PIL import Image, ImageDraw, ImageFont


def get_max_font_size(draw, text, font_path, box_width, box_height, max_font_size=300):
    for font_size in range(max_font_size, 0, -1):
        font = ImageFont.truetype(font_path, font_size)
        bbox = draw.textbbox((0, 0), text, font=font)
        w = bbox[2] - bbox[0]
        h = bbox[3] - bbox[1]
        if w <= box_width and h <= box_height:
            return font_size
    return 1


WIDTH = 1920
HEIGHT = 1080
font_path = '/mnt/c/Windows/Fonts/HGRSGU.TTC'

im = Image.new('RGB', (WIDTH, HEIGHT), (255, 255, 255))
draw = ImageDraw.Draw(im)
blocks = [
    ((0, 0, WIDTH/2, HEIGHT/2), "アイコン", (237, 125, 46)),
    ((WIDTH/2, 0, WIDTH, HEIGHT/2), "フォルダー", (1, 176, 241)),
    ((0, HEIGHT/2, WIDTH/2, HEIGHT), "いらないショートカット", (112, 173, 64)),
    ((WIDTH/2, HEIGHT/2, WIDTH, HEIGHT), "空き場所", (0, 87, 150)),
]
for rect, text, color in blocks:
    draw.rectangle(rect, fill=color)
    box_w = int(rect[2] - rect[0])
    box_h = int(rect[3] - rect[1])
    font_size = get_max_font_size(
        draw, text, font_path, box_w, box_h, max_font_size=300)
    font = ImageFont.truetype(font_path, font_size)
    x = (rect[0]+rect[2])/2
    y = (rect[1]+rect[3])/2
    draw.text((x, y), text, (0, 0, 0), font=font, anchor="mm")

draw.line((0, HEIGHT/2, WIDTH, HEIGHT/2), fill=(0, 0, 0), width=4)
draw.line((WIDTH/2, 0, WIDTH/2, HEIGHT), fill=(0, 0, 0), width=4)
im.save("desktop.jpg")
