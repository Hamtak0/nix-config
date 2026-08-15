{ pkgs, config, ... }:
let
  usernames = builtins.attrNames (
    pkgs.lib.filterAttrs (_: user: user.isNormalUser) config.users.users
  );
in
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ] ++ usernames;
      ensureUsers = map (username: {
        name = username;
        ensureClauses = {
          # superuser = true;
          login = true;
          createdb = true;
        };
      }) usernames;

      authentication = pkgs.lib.mkOverride 10 ''
        # type  database  DBuser  auth-method optional_ident_map
          local all       all     peer        map=superuser_map
      '';
      identMap = ''
        # ArbitraryMapName  systemUser  DBUser
          superuser_map     root        postgres
          superuser_map     postgres    postgres
          # Let other names login as themselves
          superuser_map     /^(.*)$     \1
      '';
    };
    postgresqlBackup = {
      enable = true;
      databases = [ "mydatabase" ] ++ usernames;
      startAt = "*-*-* 04:00:00";
    };
  };
}
