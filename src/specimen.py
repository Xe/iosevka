#!/usr/bin/env python

header = '''
<!DOCTYPE html>
<html>
    <head>
        <title>Iosevka Iaso Specimen</title>
        <link type="text/css" rel="stylesheet" href="https://within.website/static/gruvbox.css">
        <link type="text/css" rel="stylesheet" href="./family.css">
        <style>
         .aile {
            font-family: "Iosevka Aile Iaso";
            font-weight: 400;
         }
         .curly {
            font-family: "Iosevka Curly Iaso";
            font-weight: 400;
         }
         .etoile {
            font-family: "Iosevka Etoile Iaso";
            font-weight: 400;
         }
         big {
            font-size: xx-large;
         }

         main {
            max-width: 60rem;
         }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body class="snow" id="top">
        <main>
            <h1 class="etoile">Iosevka Iaso Specimen</h1>
            <p class="aile">This page will demonstrate the Iosevka Iaso font family.</p>

            <h2 class="etoile">Usage</h2>
            <p class="aile">To use this font family, import this CSS:</p>
            <code class="curly"><pre>&lt;link rel="stylesheet" href="https://cdn.xeiaso.net/static/css/iosevka/family.css" /&gt;</pre></code>
            <p class="aile">Then use the fonts as normal.</p>
'''

footer = '''
            <footer>
                <p>Xe Iaso</p>
            </footer>
        </main>
    </body>
</html>
'''

blurbs = {
    "Aile": "Designed for body text. A quasi-proportional font that evokes moods of the terminal days gone past.",
    "Curly": "Designed for code. The hacker's canvas and ink.",
    "Etoile": "Designed for titles. A serifed font that oozes modernity and classic sensibilities.",
}

with open("specimen.html", "w") as fout:
    fout.write(header)

    for family in ["Aile", "Curly", "Etoile"]:
        fout.write(f'''
        <h2 class="{family.lower()}">{family}</h2>
        <p class="{family.lower()}">{blurbs[family]}</p>
        <big class="{family.lower()}">Sphinx of black quartz, hear my vow!</big><br />
        <big class="{family.lower()}">SPHINX OF BLACK QUARTZ, HEAR MY VOW!</big><br />
        <big class="{family.lower()}">sphinx of black quartz, hear my vow!</big><br />
        <table class="{family.lower()}"><tr>
        ''')

        i = 0
        for ch in range(0x20, 0xBE):
            if i == 10:
                fout.write("</tr><tr>")
                i = 0

            fout.write(f'''<td><big>&#x{ch:02x}</big><br />0x{ch:02x}</td>''')
            i += 1

        fout.write("</tr></table>")

    fout.write(footer)
            

        
