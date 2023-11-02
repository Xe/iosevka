from os import listdir
from os.path import isfile, join, splitext


weights = {
    "thin": 100,
    "extralight": 200,
    "light": 300,
    "normal": 400,
    "medium": 500,
    "semibold": 600,
    "bold": 700,
    "extrabold": 800,
    "black": 900,
}


def chop_extended_and_check_ends_with_italic(input_string):
    starts_with_extended = input_string.startswith("extended")
    ends_with_italic = input_string.endswith("italic")

    result_string = input_string

    if starts_with_extended:
        result_string = result_string[8:]  # Remove "extended"

    if ends_with_italic:
        result_string = result_string[:-6]  # Remove "italic"

    return result_string, starts_with_extended, ends_with_italic

    
def write_font_face(fout, fname):
    fnameWithoutExt = splitext(fname)[0]
    parts = fnameWithoutExt.split("-")
    font = parts[0]
    family = parts[1]
    weight, extended, italic = chop_extended_and_check_ends_with_italic(parts[2])
    style = "italic" if italic else "normal"
    
    fout.write(f"""
@font-face {{
    font-family: "{font.title()} {family.title()} Iaso";
    font-weight: {weights[weight]};
    font-style: {style};
    {"font-stretch: expanded;" if extended else ""}
    src: local("{font.title()} {family.title()} Iaso")
       , url("{fname}") format("woff2");
}}
""")

    
files = [f for f in listdir(".") if isfile(join(".", f))]
fontFiles = [f for f in files if f.endswith(".woff2")]
fontFiles.sort()


with open("./family.css", "w") as fout:
    for fname in fontFiles:
        write_font_face(fout, fname)
    fout.close()
