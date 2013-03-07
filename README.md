# Obi

Work in progess, soon to be combined into one jedi master script: `obi`.

## obi
Lightsaber Swiss Army Knife for wordpress development workflows. It shall become more powerful than you can possibly imagine.

Obi is a unified tool to setup project structures for multi-environment wordpress development, and database sync management.

## wicket
*Depricated, use `obi`*

## deploy
Currently only deploys folders to the server via rsync

# Useage:
`obi [$1] [$2] [$3]`

## Setup Obi: Commands to Run Once
$1 Params for setup (run once)
`setup`: sets up .newconfig file in ~/. dir. Can be run again to overwrite .newconfig file.

$2 Params for setup (run once)
`%directory%`: path to root directory containing all project folders. (Can drag/drop desired folder here from Finder)

## Using Obi: Project Setup Commands
$1 Params for projects:

`-f`: create empty folder structure, no repo, no wordpress

`-g`: create empty folder structure with git repo in ./site/ dir

`-w`: create folder structure with git repo and latest wordpress install including KLAS framework in ./site/ dir

$2 Params for projects:
`%foldername%`: project name, typically the site's domain without .tld. This name is used throughout the script for the following:

- Root directory name
- KLAS theme folder name
- Development environment WP siteurl and home variables in wp-config.php
- Development environment database name %foldername%_local_db
- Sets a git remote "beanstalk"

## Using Obi: Database Management Commands
$1 Params for databases:

`-d`: database dump to ./dumps/ dir

`-s`: sync databases between two environments

$2 Params for databases:
`%foldername%`: project name, typically the site's domain without .tld.

$3 Params for databases (only for use with $1 = `-s`):
Provides "From:To" database sync as follows:

1. Dump of first letter's environment database into ./dumps/ dir, using db credentials from the specified project's (`$2`) wp-config.php.
2. Run `sed` (find & replace) over the dump, replacing the "from" environment's base URL with the "to" environment's base URL, using URLs from the specified project's (`$2`) wp-config.php.
3. Import the find & replaced dump from step 2. into the "to" environment's database, using db credentials from the specified project's (`$2`) wp-config.php.

`-lts`: Local to Staging

`-ltp`: Local to Production

`-stl`: Staging to Local

`-stp`: Staging to Production

`-ptl`: Production to Local

`-pts`: Production to Staging
