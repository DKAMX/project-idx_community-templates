{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python3
  ];
  # Sets environment variables in the workspace
  env = {};
  services.docker.enable = true;
  idx = {
    previews = {
      enable = false;
      previews = {
        web = {
          command = [ "functions-framework --target my_cloud_function --debug" ];
          env = { PORT = "$PORT"; };
          manager = "web";
        };
      };
    };
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [ "ms-python.python" "RooVeterinaryInc.roo-cline" ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        create-venv =
          "python -m venv .venv 
          source .venv/bin/activate 
          pip install -r requirements.txt";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "main.py" "README.md"];
      };
    };
  };
}
