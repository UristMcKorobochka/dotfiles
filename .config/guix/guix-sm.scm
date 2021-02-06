;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

(use-modules (gnu) (gnu image) (gnu bootloader grub)
	     (guix gexp)
	     (ice-9 regex) (ice-9 match)  
	     (srfi srfi-1) (srfi srfi-2) (srfi srfi-9)
	     (nongnu packages linux) (nongnu system linux-initrd))
(use-service-modules xorg desktop sddm networking avahi ssh nix)
(use-package-modules xorg admin autotools pulseaudio linux bash xdisorg disk guile guile-xyz package-management ntp fonts fontutils freedesktop wm display-managers certs emacs emacs-xyz screen version-control ssh haskell-apps)

(operating-system
 ;;nongnu stuff
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (host-name "guix-rocks-sm")
 (timezone "Europe/Moscow")
 (locale "en_US.utf8")

 ;; Boot in "legacy" BIOS mode, assuming /dev/sdX is the
 ;; target hard disk, and "my-root" is the label of the target
 ;; root file system.
 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (target "/dev/sda")
              (menu-entries
	       (list
		(menu-entry 
		 (label "Bababoy")
		 (linux  "/boot/vmlinuz")
		 (initrd "/boot/initrd.img")
		 (device "popos")
		 (linux-arguments '("root=/dev/sda5")))))))
 (file-systems (cons (file-system
                      (device (file-system-label "guix-home"))
                      (mount-point "/")
                      (type "btrfs"))
                     %base-file-systems))

 (groups (cons* (user-group
		 (name "uinput"))
		%base-groups))
 
 ;; This is where user accounts are specified.  The "root"
 ;; account is implicit, and is initially created with the
 ;; empty password.
 (users (cons (user-account
               (name "retard")
               (comment "kakashka's brother")
               (group "users")

               ;; Adding the account to the "wheel" group
               ;; makes it a sudoer.  Adding it to "audio"
               ;; and "video" allows the user to play sound
               ;; and access the webcam.
               (supplementary-groups '("wheel"
                                       "audio" "video"
				       "uinput" ; for KMonad
				       )))
              %base-user-accounts))

 ;; Globally-installed packages.
 (packages (cons*
	    nss-certs
	    pulseaudio pavucontrol
	    isc-dhcp
	    nix
	    autoconf
	    ntfs-3g
	    fontconfig font-liberation font-fira-code font-ubuntu font-adobe100dpi font-dejavu font-wqy-zenhei font-wqy-microhei
	    git
	    emacs-next
	    sddm elogind stumpwm emacs-exwm xmonad sway swaylock swayidle swaybg
	    xrandr xterm xorg-server
	    kmonad
	    screen
	    %base-packages))

 ;; Add services to the baseline: a DHCP client and
 ;; an SSH server.
 (services (cons*
            (service ntp-service-type)
	    (elogind-service)
	    (service sddm-service-type 
		     (sddm-configuration
		      ;;(display-server "wayland")
		      ;;(auto-login-session "sway") 
		      (auto-login-user "retard")
		      (auto-login-session "stumpwm")))
	    ;; External monitor resolutions aren't always detected properly
	    (set-xorg-configuration
	     (xorg-configuration
	      (resolutions '((1920 1080) (1336 768) (1024 768))))
	     sddm-service-type)
	    (service dhcp-client-service-type)
	    (service wpa-supplicant-service-type
		     (wpa-supplicant-configuration
		      (interface "wlp2s0")
		      (config-file "/etc/wpa_supplicant.conf")))
	    (service nix-service-type
		     (nix-configuration
		      (extra-config '("allowUnfree = true;"))))
	    (service openssh-service-type
		     (openssh-configuration
		      (openssh openssh-sans-x)
		      (permit-root-login 'without-password)
		      (port-number 22)))
	    %base-services)))
