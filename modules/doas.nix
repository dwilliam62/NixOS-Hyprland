{
  security = {
     doas.enable = false;
     doas.extraRules = [
      {
          users = ["dwilliams"]; # Replace with your username
          keepEnv = true; # Retains environment variables
          noPass = true;
      }
      {
         groups = ["wheel"]; # Allows all users in 'wheel' group
         noPass = true; # Enables passwordless execution
      }
     ];
  };
}
