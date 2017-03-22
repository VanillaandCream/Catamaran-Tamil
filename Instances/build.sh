# Modify the Lato 2.0 family for Google Fonts. 
# Sources available here: http://www.latofonts.com/2014/02/27/lato-2-0-released/

# WARNING: Font Bakery is needed for this script to run, https://github.com/googlefonts/fontbakery

# We may also need to add symlinks for certain scripts. FB should do this by default, if not, add the following symlinks:
#
# $ ln -s /your/path/to/fontbakery/fontbakery-nametable-from-filename.py /usr/local/bin/fontbakery-nametable-from-filename.py
# $ ln -s /your/path/to/fontbakery/fontbakery-check-bbox.py /usr/local/bin/fontbakery-check-bbox.py
# $ ln -s /your/path/to/fontbakery/fontbakery-fix-vertical-metrics.py /usr/local/bin/fontbakery-fix-vertical-metrics.py
#
# Permissions may need to be changed on these symlinks as well. To do this:
# $ chmod 744 /usr/local/bin/font-bakery-script


set -e # Stop script if we have any critical errors
cd ../Fonts


FONTS=$(ls *.ttf)

# echo renaming font tables, based on new font filenames
fontbakery-nametable-from-filename.py $FONTS

# delete old fonts
rm -r $FONTS

# rename fixed fonts
for file in *.ttf.fix; do
    mv "$file" "`basename "$file" .ttf.fix`.ttf"
done


# fix fstype
FONTS=$(ls *.ttf)
fontbakery-check-bbox-fix-fstype.py $FONTS

# rename fixed fonts
for file in *.ttf.fix; do
    mv "$file" "`basename "$file" .ttf.fix`.ttf"
done


# Bump version number
FONTS=$(ls *.ttf)
fontbakery-update-version.py $FONTS 1.100 1.100

# rename fixed fonts
for file in *.ttf.fix; do
    mv "$file" "`basename "$file" .ttf.fix`.ttf"
done
