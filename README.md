# Dotfiles aka My NixOS Configuration

I'm moving away from classic dotfiles towards a NixOS and Home Manager
configuration. This is the result of that work, thus far anyway. I mention home
manager only because this is where I _intend_ that config to live, however at
present it is stored privately as I am yet to separate out some more sensitive
information.

## How can you use this configuration?

In short, you probably shouldn't… At least not by simply cloning and applying as
this is MY configuration. I'm quite sure it won't be yours, but don't let that
stop you taking inspiration from it.

## How did I come up with this arrangement?

Being a developer by trade, I have generally hand-crafted all of this config,
but being a developer the story of this config goes something like this:

1. Discover NixOS and marvel at how awesome its power is. I was fortunate to
   make this discovery after the introduction of a graphical installer, so I got
   a fairly easy start on my laptop and evolved my `configuration.nix` from
   there.
2. Discover home manager and realise its potential to revolutionise how I manage
   my dotfiles. This revelation cannot be understated as I was never happy with
   any of the existing methods of sharing my dotfiles across hosts.
   Incidentally, prior to this the best solution I had found was a tool called
   `chezmoi`. It allowed templated dotfiles, which was pretty awesome, however
   the syntax baffled many editors, making it tricky to work with.
3. Find the drawbacks of channels after trying to use parts of my configuration
   across hosts, only to discover this problem had already been solved by
   Flakes. Wonder why flakes are not the default approach (there's some history
   there I gather) but marvel at how powerful and precise their approach is.
4. Realise how unwieldy my `home.nix` file is getting and start breaking it into
   pieces. This was relatively easy in practice.
5. Realise how unwieldy my `configuration.nix` file is getting and wonder not
   only how to break this into pieces, but how to enable re-use of portions of
   it across hosts. This did not appear quite so easy in practice.
6. Spend far too many hours watching YouTube videos on Nix, reading blog posts
   about Nix configurations and flakes, and study a (far too) large list of
   repositories containing mixtures of personal NixOS and home manager
   configurations that others kindly made public.
7. Keep putting off the task of breaking up `configuration.nix` because it looks
   so daunting and instead delude oneself into thinking that things are working
   fine as they are. :wink:
8. Finally start refactoring, taking inspiration from two of the most impressive
   and thorough repos I had found.
9. Get a Nix error I couldn't decipher, but I'd changed too much at once and
   couldn't unpick it. Realise I'd made the schoolboy error of copy/pasting a
   large amount of code I didn't fully understand.
10. Abandon that refactor and start again, this time taking a module-based
    approach I'd come up with which would allow me to gradually migrate my
    configuration into a new structure.
11. Catch myself making things too complicated my creating custom options for
    pretty much everything. Fortunately I caught this early and came up with a
    rule-of-thumb - if a custom option affected literally **one** NixOS/home
    manager option then it has _no reason_ to exist and the target option should
    be used directly instead. This led to an approach with my host config that
    I've not seen elsewhere. I have modularised a lot of commonality, creating
    options so I could switch certain pieces on or off wholesale. This is not an
    uncommon approach, however at a host level I configure my custom options in
    a host-specific `default.nix` file, then retain `configuration.nix` and
    `hardware-configuration.nix` alongside it for host- and hardware-specific
    configuration. I've found this makes it very easy to onboard new hosts,
    since files generated upon a default install can largely be retained.
