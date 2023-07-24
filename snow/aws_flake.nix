{
  inputs =
    {
      dotfiles-awesome.url = "github:pinpox/dotfiles-awesome";
    }

      # ...

      home-manager.users.byakuya = {

  # Pass inputs to home-manager modules
  _module.args.flake-inputs = inputs;

  imports = [
    inputs.dotfiles-awesome.nixosModules.dotfiles
  ];
};
}
