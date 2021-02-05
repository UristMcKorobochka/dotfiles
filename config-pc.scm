;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu system nss)
      	     (ice-9 match)
	     (srfi srfi-1)
	     (gnu system keyboard)
	     (nongnu packages linux)
	     (rnrs lists)
	     (gnu)
	     (guix)
	     (gnu services)
	     (nongnu system linux-initrd))
(use-service-modules sddm xorg networking avahi desktop base ssh nix ssh)
(use-package-modules admin autotools pulseaudio linux bash xorg base display-managers nss fonts emacs-xyz wm xdisorg disk emacs freedesktop guile guile-xyz ssh wm package-management certs ntp)

(operating-system
 ;; nongnu stuff
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (locale "en_US.utf8")
 (timezone "Europe/Moscow")
 (host-name "guix-nl")
 (groups (cons* (user-group
		 (name "uinput"))
		%base-groups))
 (users (cons* (user-account
                (name "retard")
                (comment "Yurii")
                (group "users")
                (home-directory "/home/retard")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video"
		   "uinput" ; for KMonad
		   )))
               %base-user-accounts))
 (packages (cons*
            bash bash-minimal
	    pulseaudio pavucontrol
	    nss-certs nss
	    isc-dhcp
            nix
	    sddm i3-gaps
	    autoconf
	    sway swaylock swayidle swaybg waybar wofi
	    stumpwm emacs-exwm xmonad
            ntfs-3g
	    font-liberation font-fira-code font-ubuntu font-adobe100dpi font-dejavu font-wqy-zenhei font-wqy-microhei
	    
	    %base-packages))

  (services 
    (cons*
      (service sddm-service-type
	       (sddm-configuration
;;		(display-server "wayland")
		(auto-login-user "retard")
		(auto-login-session "stumpwm")))
      (service elogind-service-type)
      (service ntp-service-type)
      (service dhcp-client-service-type)
      (service openssh-service-type
	       (openssh-configuration
		(permit-root-login 'without-password)))
      %base-services))


  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (target "/boot/efi")))

  (file-systems
   (cons* (file-system
           (mount-point "/")
           (device
            (uuid "22306785-4fb9-4303-a355-b9a4b4f91cb5"
                  'ext4))
           (type "ext4"))
          (file-system
           (mount-point "/boot/efi")
           (device (uuid "320C-8132" 'fat32))
           (type "vfat"))
          %base-file-systems)))
