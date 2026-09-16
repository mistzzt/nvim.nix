{
  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>o";
      group = "[O]rg";
    }
  ];

  plugins.orgmode = {
    enable = true;

    settings = {
      org_agenda_files = "~/personal/orbit/**/*";
      org_default_notes_file = "~/personal/orbit/inbox.org";
      org_tags_exclude_from_inheritance = ["project"];
      org_archive_location = "archive/%s::";
      org_todo_keywords = [
        "TODO"
        "NEXT"
        "WAITING"
        "|"
        "DONE"
        "CANCELLED"
      ];
    };
  };
}
