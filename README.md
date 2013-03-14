# Obi

Obi is a unified tool to setup and manage projects for multi-environments, wordpress development, and database sync management.

## Useage:

`obi` `[argument]`

or

`obi` `[argument]` `[project_name]` `[environment(s)]`

### Arguments:

`config`: configure obi

`help`: prints usage to the terminal

`mysql`: login local mysql database

`-e`: Create an empty working directory *(Followed by the `[project_name]`)*

`-g`: Create a git repository working directory *(Followed by the `[project_name]`)*

`-w`: Create a wordpress enabled git working directory *(Followed by the `[project_name]`)*

`-b`: Backup mysql database *(Followed by the `[project_name]` and then the `[environment(s)]`)*

### Project name:

Name of the folder that contains your project.

### Environments:

`-l`: local

`-s`: staging

`-p`: production

`-lts`: local to staging

`-ltp`: local to production

`-stl`: staging to local

`-stp`: staging to production

`-ptl`: production to local

`-pts`: production to staging

### Dependencies

- Git (duh)
- Uses the [KLAS Wordpress Theme Framework](https://github.com/kylelarkin/klas) - A SASS based starter theme for WordPress.
