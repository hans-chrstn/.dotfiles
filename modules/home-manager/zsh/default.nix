{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.mod.programs.zsh;
in {
  options.mod.programs.zsh = {
    enable = lib.mkEnableOption "Enable the zsh feature";
    enableStarship = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable starship for zsh";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [fzf]
      ++ (
        if cfg.enableStarship
        then [starship]
        else []
      );

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      syntaxHighlighting.enable = false;
      shellAliases = {
      };

      initContent = ''
        export EDITOR=nvim
        export VISUAL="$EDITOR"
        eval "$(direnv hook zsh)"
        eval "$(starship init zsh)"
      '';

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };

    programs.starship = {
      enable = cfg.enableStarship;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        scan_timeout = 20;
        add_newline = false;

        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$git_status"
          "$cmd_duration"
          "$fill"
          "$username"
          "$hostname"
          "$time"
          "$line_break"
          "$character"
        ];

        fill = {
          symbol = " ";
        };

        username = {
          disabled = false;
          show_always = false;
          format = "[$user]($style) ";
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = "";
          format = "[@$hostname]($style) ";
          trim_at = ".";
        };

        character = {
          success_symbol = "[❯]($style)";
          error_symbol = "[❯]($style)";
        };

        directory = {
          truncation_length = 2;
          truncate_to_repo = true;
        };

        git_branch = {
          format = "[$branch]($style)";
        };

        git_status = {
          format = "([\\[$all_status$ahead_behind\\]]($style))";
          deleted = "x";
          ahead = ">";
          behind = "<";
        };

        cmd_duration = {
          min_time = 1000;
          format = " [$duration]($style) ";
        };

        time = {
          disabled = false;
          format = "[$time]($style)";
          time_format = "%T";
        };

        aws.disabled = true;
        azure.disabled = true;
        battery.disabled = true;
        buf.disabled = true;
        bun.disabled = true;
        c.disabled = true;
        cmake.disabled = true;
        cobol.disabled = true;
        conda.disabled = true;
        container.disabled = true;
        crystal.disabled = true;
        daml.disabled = true;
        dart.disabled = true;
        deno.disabled = true;
        direnv.disabled = true;
        docker_context.disabled = true;
        dotnet.disabled = true;
        elixir.disabled = true;
        elm.disabled = true;
        env_var.disabled = true;
        erlang.disabled = true;
        fennel.disabled = true;
        fossil_branch.disabled = true;
        gcloud.disabled = true;
        git_commit.disabled = true;
        git_state.disabled = true;
        gleam.disabled = true;
        golang.disabled = true;
        guix_shell.disabled = true;
        gradle.disabled = true;
        haskell.disabled = true;
        haxe.disabled = true;
        helm.disabled = true;
        java.disabled = true;
        jobs.disabled = true;
        julia.disabled = true;
        kotlin.disabled = true;
        kubernetes.disabled = true;
        localip.disabled = true;
        lua.disabled = true;
        memory_usage.disabled = true;
        meson.disabled = true;
        hg_branch.disabled = true;
        mise.disabled = true;
        mojo.disabled = true;
        nim.disabled = true;
        nix_shell.disabled = true;
        nodejs.disabled = true;
        ocaml.disabled = true;
        odin.disabled = true;
        openstack.disabled = true;
        os.disabled = true;
        package.disabled = true;
        perl.disabled = true;
        php.disabled = true;
        pijul_channel.disabled = true;
        pixi.disabled = true;
        pulumi.disabled = true;
        purescript.disabled = true;
        python.disabled = true;
        quarto.disabled = true;
        raku.disabled = true;
        red.disabled = true;
        ruby.disabled = true;
        rust.disabled = true;
        scala.disabled = true;
        shell.disabled = true;
        shlvl.disabled = true;
        singularity.disabled = true;
        solidity.disabled = true;
        spack.disabled = true;
        status.disabled = true;
        sudo.disabled = true;
        swift.disabled = true;
        terraform.disabled = true;
        typst.disabled = true;
        vagrant.disabled = true;
        vlang.disabled = true;
        zig.disabled = true;
      };
    };
  };
}
