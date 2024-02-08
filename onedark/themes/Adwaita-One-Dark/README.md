# Adwaita One Dark

- [x] GNOME Shell theme. GNOME 43
- [x] GTK 2 theme
- [x] [adw-gtk3-dark](https://github.com/lassekongo83/adw-gtk3) and libadwaita/GTK 4 theme recoloring
- [ ] GtkSourceView

## GNOME Shell Theme

> **Note**
> We assume you install themes in `~/.local/share/themes`

Download the `.tar.xz` file from [releases](https://github.com/lonr/adwaita-one-dark/releases) and extract the folder to `~/.local/share/themes`

Install [GNOME Tweaks](https://wiki.gnome.org/Apps/Tweaks) and [User Themes Extension](https://extensions.gnome.org/extension/19/user-themes/).

Open `gnome-tweaks` and change the shell theme. (`Appearance -- Shell`)

## Recolor GTK 4 (libadwaita) and GTK3 (adw-gtk3-dark)

[Install and enable](https://github.com/lassekongo83/adw-gtk3) the 3rd-part adw-gtk3-dark theme.

Create the following symbolic links:

```sh
ln -s ~/.local/share/themes/Adwaita-One-Dark/colors/gtk-dark.css ~/.config/gtk-4.0/gtk.css
ln -s ~/.local/share/themes/Adwaita-One-Dark/colors/gtk-dark.css ~/.config/gtk-3.0/gtk.css
```

## Enable GTK 2.0 theme

Create the following symbolic link:

```sh
mkdir -p ~/.themes/adw-gtk3-dark
ln -s ~/.local/share/themes/Adwaita-One-Dark/gtk-2.0 ~/.themes/adw-gtk3-dark/gtk-2.0
```

<details><summary>Why?</summary>

- [GTK 2 doesn't support `~/.local/share/themes/`](https://github.com/lxqt/lxqt/issues/1883#issuecomment-1043566152)
- We enabled `adw-gtk3-dark` for gtk 3 theme (not `Adwaita-One-Dark`), so our `gtk-2.0` theme need to be in `~/.themes/adw-gtk3-dark/gtk-2.0`

</details>

## Thanks to

- [GTK](https://github.com/GNOME/gtk)
- [adw-gtk3](https://github.com/lassekongo83/adw-gtk3), [adw-colors](https://github.com/lassekongo83/adw-colors)
- [Ubuntu Yaru theme suite](https://github.com/ubuntu/yaru)
