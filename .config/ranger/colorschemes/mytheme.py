from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = underline
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                attr = normal
                fg = cyan
            else:
                fg = yellow
            if context.container:
                attr |= normal
                fg = green
            if context.directory:
                attr |= normal
                fg = white
            elif context.executable and not any((context.media, context.container, context.fifo, context.socket)):
                attr |= normal
                fg = magenta
            if context.socket:
                fg = magenta
            if context.fifo or context.device:
                fg = yellow
                if context.device:
                    attr |= normal
            if context.link:
                fg = context.good and cyan or magenta
            if context.tag_marker and not context.selected:
                attr |= normal
                if fg in (red, magenta):
                    fg = blue
                else:
                    fg = red
            if not context.selected and (context.cut or context.copied):
                fg = magenta
                attr |= normal
            if context.main_column:
                if context.selected:
                    attr |= normal
                if context.marked:
                    attr |= normal
                    fg = yellow
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = green

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                attr |= bold
                fg = context.bad and red or cyan
            elif context.directory:
                fg = yellow
            elif context.tab:
                if context.good:
                    bg = green
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = cyan
                elif context.bad:
                    fg = magenta
            if context.marked:
                attr |= bold | reverse
                fg = yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red

            if context.text:
                if context.highlight:
                    attr |= reverse

            if context.in_taskview:
                if context.title:
                    fg = blue

                if context.selected:
                    attr |= reverse

        return fg, bg, attr
