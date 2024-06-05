# NAME:         Simple PDF Analyzer
# VERSION:      0.1
# AUTHOR:       Troy E. Spier
#
# DEPENDENCIES: yad exiftool pdftotext pdfinfo pdfimages pdffonts
#               The first two (yad and exiftool) generally do not come pre-installed, but the last four
#               (pdftotext, pdfinfo, pdfimages, and pdffonts) are likely already on your system.
#
# DESCRIPTION:  This is a simple tool to display a GUI containing the output from a variety of PDF tools.
#               The program has five tabs (Basic Info, Detailed Info, Image Info, Font Info, File Contents)
#               that extract and display the relevant information in notebooks. All information and contents
#               can be automatically saved and extracted by clicking on the relevant button.
#
# LICENSE:      GNU GPLv3 (http://www.gnu.de/documents/gpl-3.0.en.html)
#
# NOTICE:       THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. 
#               EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES 
#               PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR 
#               IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
#               AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND 
#               PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE,
#               YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#               IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY 
#               COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS THE PROGRAM AS 
#               PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, 
#               INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE 
#               THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED 
#               INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE 
#               PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER 
#               PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
#
# USAGE:        ./pdf_analyzer.sh FILENAME
#
# TL;DR:
#              (1) Download the file.
#              (2) chmod +x pdf_analyzer.sh
#              (3) ./pdf_analyzer.sh FILENAME
#              (4) Enjoy!
